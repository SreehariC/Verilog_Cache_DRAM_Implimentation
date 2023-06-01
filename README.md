# Verilog_Cache_DRAM_Implimentation

Implimented Cache and DRAM in a Hardware Description language (Verilog)

Cache Details:-

Implimented a 256 sets,4-way associative cache with 64 B line. The addressing mode is of 32 bits with 18,8,and 6 bits respectively for tag,index and offset comparison.

The cache design also supports - 
            LRU replacement policy for cache block replacement
            Cache miss under a cache miss using Miss Status Holding Register (MSHR)(Cache miss under a cache miss means while serving a cache miss, another cache miss can happen. The processor can send another cache request while other cache access is in progress.)

 
 Other assumptions:-getting a block from memory (DRAM) takes 400 cycles.
Once there is a miss in the cache and if the victim block (to be replaced) is dirty (write happened for that block), you
need to write back the victim block to memory (DRAM). DRAM have enough capacity and for both read
block and write block takes 400 cycles time.

DRAM details:-
       
 Implemented DRAM with 2 channels, 8 ranks per channel, 16 Banks per rank, and each bank of size 256 rows and 1024 columns, assuming the cache block size is 64B.Processor generated address is of 32 bits  and the physical/memory address is 26-bit.
 
 The memory design also includes:-
            Page Mode Access for each bank. Accessing a block (read/write) from Buffered Page takes 32 cycles but reading a page from the row to the page buffer takes 128 cycles, and writing the page buffer to a row of the bank takes 256 cycles.
            Every channel has a block access status register(BSHR) and it can store, information about 8 block accesses.The information can be read, write, served, and ready to serve.
            
 Other assumptions:-Transferring a block from Memory to Processor (or Processor to Memory) takes consecutive 9 cycles (one cycle for information sender, receiver, and address and 8 cycles for data of the cache block). The BUS uses FCFS policy. The 4-bit control is used for (a) processor request line and granted line and (b) Memory request line and granted line. The grant line can be activated for 10 cycles for a![abstract view of design](https://github.com/SreehariC/Verilog_Cache_DRAM_Implimentation/assets/95119050/ea17856d-718f-4cd2-b152-b606c7be8490)
![communication between cache memory and memory controller](https://github.com/SreehariC/Verilog_Cache_DRAM_Implimentation/assets/95119050/5464ee54-3e1d-467c-a40a-bdbcfabfcee7)
 request
            
