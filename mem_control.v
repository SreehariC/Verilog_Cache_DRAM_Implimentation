module Memory_controller(
   input clk, 
   input done,
   input iamsending,
   output recieved,
   output iamtaking,
   output grant_line,
   output pop
       
//   input en,
//  input iamtaking, //memory is sending to me
//  input [31:0] data_in,
//  input [31:0] mem_ins

   
//   output grant_line,
//   output [31:0] mem_pro
);
reg grant;
reg taking;
reg rec;
reg pop1;
reg [3:0] done_counter;
initial 
    begin 
    grant=1;
    taking=0;
    done_counter=0;
    pop1=0;
    rec=0;
    end
//initial begin taking=0;
//end
assign iamtaking=taking;
assign grant_line=grant;
always @(posedge clk) 
begin
if(iamsending==1) // when the processor is sending the data grant line=0
    begin
        grant=0;
    end
else if(iamsending==0) 
    begin
        grant=1;
    end

end
always @(posedge  done) 
begin
      done_counter=0;
end
always @(posedge clk)
begin 
if(pop1==1) pop1=0;
if(rec==1) rec=0;
if((done==1 || done_counter>0) && iamsending==0)
    begin 
        done_counter=done_counter+1;
        taking=1;
        if(done_counter==1) pop1=1; // if memory has send the data pop it from mem to queue
        if(done_counter==10) begin
            done_counter=0;
            taking=0;               // stores wheather the processor is taking data from memory or not
            rec=1;
            end
           
    end
end
assign pop=pop1;
assign recieved=rec;
endmodule
