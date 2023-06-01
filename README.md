# Verilog_Cache_Implimentation

Implimented a 256 sets,4-way associative cache with 64 B line. The addressing mode is of 32 bits with 18,8,and 6 bits respectively for tag,index and offset comparison.

The cache design also supports - 
            LRU replacement policy for cache block replacement
            Cache miss under a cache miss using Miss Status Holding Register (MSHR)
 
 Other assumptions:-getting a block from memory (DRAM) takes 400 cycles.
Once there is a miss in the cache and if the victim block (to be replaced) is dirty (write happened for that block), you
need to write back the victim block to memory (DRAM). DRAM have enough capacity and for both read
block and write block takes 400 cycles time
