`include "./cache/data_cache_memory.v"
`include "./mem/data_memory.v"
`timescale 1ns/100ps

module data_cache_memory_tb;

    // Inputs
    reg clock;
    reg reset;
    reg [3:0] read;
    reg [2:0] write;
    reg [31:0] address;
    reg [31:0] writedata;
    
    // Outputs
    wire [31:0] readdata;
    wire busywait;

    // Main memory signals
    wire MAIN_MEM_READ;
    wire MAIN_MEM_WRITE;
    wire [27:0] MAIN_MEM_ADDRESS;
    wire [127:0] MAIN_MEM_WRITE_DATA;
    wire [127:0] MAIN_MEM_READ_DATA;
    wire MAIN_MEM_BUSY_WAIT;

    // Instantiate the cache memory
    data_cache_memory uut (
        .clock(clock),
        .reset(reset),
        .read(read),
        .write(write),
        .address(address),
        .writedata(writedata),
        .readdata(readdata),
        .busywait(busywait),
        .MAIN_MEM_READ(MAIN_MEM_READ),
        .MAIN_MEM_WRITE(MAIN_MEM_WRITE),
        .MAIN_MEM_ADDRESS(MAIN_MEM_ADDRESS),
        .MAIN_MEM_WRITE_DATA(MAIN_MEM_WRITE_DATA),
        .MAIN_MEM_READ_DATA(MAIN_MEM_READ_DATA),
        .MAIN_MEM_BUSY_WAIT(MAIN_MEM_BUSY_WAIT)
    );

    // Instantiate the main memory
    data_memory main_memory (
        .clock(clock),
        .reset(reset),
        .read(MAIN_MEM_READ),
        .write(MAIN_MEM_WRITE),
        .address(MAIN_MEM_ADDRESS),
        .writedata(MAIN_MEM_WRITE_DATA),
        .readdata(MAIN_MEM_READ_DATA),
        .busywait(MAIN_MEM_BUSY_WAIT)
    );

    // Clock Generation
    always #5 clock = ~clock;  // 10ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        clock = 0;
        reset = 1;
        read = 4'b0000;
        write = 3'b000;
        address = 32'd0;
        writedata = 32'd0;
        
        // Reset the system
        #10 reset = 0;
        
        // Test 1: Read from an address (Miss -> Memory Read)
        #10 address = 32'h00000100; read = 4'b1000; write = 3'b000;  // Read from address 0x10
        while (busywait);
        #10 read = 4'b0000;  // Deassert read
        
        // Test 2: Write to the same address
        #10 address = 32'h00000100; writedata = 32'hDEADBEEF; write = 3'b110; read = 4'b0000;
        while (busywait);
        #10 write = 3'b000;  // Deassert write
        
        // Test 3: Read from the same address (Hit)
        #10 address = 32'h00000100; read = 4'b1010; write = 3'b000;
        while (busywait);
        #10 read = 4'b0000;
        
        // Test 4: Write another value to a different address (Miss -> Memory Write-back -> Memory Read)
        #10 address = 32'h00000020; writedata = 32'hCAFEBABE; write = 3'b100;
        while (busywait);
        #10 write = 3'b000;

        // Test 5: Read from the new address (Hit)
        #10 address = 32'h00000020; read = 4'b1000;
        while (busywait);
        #10 read = 4'b0000;
        
        // End of Test
        #50 $finish;
    end

    // Monitor output values
    initial begin
        $monitor("Time = %t | Read = %b | Write = %b | Addr = 0x%h | WriteData = 0x%h | ReadData = 0x%h | BusyWait = %b",
                 $time, read, write, address, writedata, readdata, busywait);
    end

endmodule
