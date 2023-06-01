`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2023 17:31:27
// Design Name: 
// Module Name: Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Memory(
input clk,
input [31:0] address,
input grant_line,
output [31:0] done_address,
output done,
output reg [12:0] hit_counter,
output reg [20:0] counter,
input pop,
output reg [12:0] miss_counter
    );
integer i,j,k;
//reg [7:0] DRAM [0:1][0:7][0:15][0:255][0:1023];
reg [7:0] row_buffer [0:1][0:7][0:15]; 
reg [20:0] count;
reg [12:0] miss;
//reg channel1;
//reg [8:0] counter [0:1][0:7][0:15];
//reg [31:0] queue1 [0:5000]; //
//reg [11:0] front1;
//reg [11:0] rear1;
reg [31:0] bshr [0:1][0:9];
reg [8:0] bshr_counter [0:1][0:9];
//reg bank_status [0:1][0:7][0:15];
reg [31:0] queue [0:1][0:9][0:5000];
reg [12:0] front [0:1][0:9];
reg [12:0] rear [0:1][0:9];
reg [31:0] mem_ins;
reg channel;
reg [2:0] rank;
reg [3:0] bank;
reg [7:0] row;
reg [9:0] col;
reg [7:0] block;
reg channel1;
reg [2:0] rank1;
reg [3:0] bank1;
reg [7:0] row1;
reg [9:0] col1;
reg [7:0] block1;
reg [31:0] mem_to_pro [0:5000];
reg [12:0] front1;
reg [12:0] rear1;
reg done1;
reg [12:0] out;
reg [12:0] miss;
reg round_robin;
initial 
begin 
done1=0;
count=0;
out=0;
front1=0;
miss=0;
rear1=1;
round_robin=1;


for (i=0;i<2;i=i+1)// initializing the arrays
begin 
    for(j=0;j<10;j=j+1) 
    begin 
        bshr_counter[i][j]=0;
        front[i][j]=-1;
        rear[i][j]=0;
    end
end
end

always @(posedge grant_line) 
    begin
    if(address!=-1) begin
//        $display("new %d",address);
        channel=address[25:25];
        rank=address[24:22];
        bank=address[21:18];
        row=address[17:10];
        col=address[9:0];
        block=address[5:0];
        // checking wheather the value is already present in bshr
        if(bshr[channel][0][21:18]==bank && bshr[channel][0][24:22]==rank && bshr_counter[channel][0]>0)
            begin 
//                $display("in queue %d",address);
                front[channel][0]=front[channel][0]+1;
                queue[channel][0][front[channel][0]]=address;
//                out=out+1;
            end
        else if(bshr[channel][1][21:18]==bank && bshr[channel][1][24:22]==rank && bshr_counter[channel][1]>0)
            begin 
                front[channel][1]=front[channel][1]+1;
                queue[channel][1][front[channel][1]]=address;
//                out=out+1;
            end
        else if(bshr[channel][2][21:18]==bank && bshr[channel][2][24:22]==rank && bshr_counter[channel][2]>0)
            begin 
                front[channel][2]=front[channel][2]+1;
                queue[channel][2][front[channel][2]]=address;
//                out=out+1;
            end       
        else if(bshr[channel][3][21:18]==bank && bshr[channel][3][24:22]==rank && bshr_counter[channel][3]>0)
            begin 
                front[channel][3]=front[channel][3]+1;
                queue[channel][3][front[channel][3]]=address;
//                out=out+1;
            end 
        else if(bshr[channel][4][21:18]==bank && bshr[channel][4][24:22]==rank && bshr_counter[channel][4]>0)
            begin 
                front[channel][4]=front[channel][4]+1;
                queue[channel][4][front[channel][4]]=address;
//                out=out+1;
            end
        else if(bshr[channel][5][21:18]==bank && bshr[channel][5][24:22]==rank && bshr_counter[channel][5]>0)
            begin 
                front[channel][5]=front[channel][5]+1;
                queue[channel][5][front[channel][5]]=address;
//                out=out+1;
            end  
        else if(bshr[channel][6][21:18]==bank && bshr[channel][6][24:22]==rank  && bshr_counter[channel][6]>0)
            begin 
                front[channel][6]=front[channel][6]+1;
                queue[channel][6][front[channel][6]]=address;
//                out=out+1;
            end 
        else if(bshr[channel][7][21:18]==bank && bshr[channel][7][24:22]==rank && bshr_counter[channel][7]>0)
            begin 
                front[channel][7]=front[channel][7]+1;
                queue[channel][7][front[channel][7]]=address;
//                out=out+1;
            end 
        else if(bshr[channel][8][21:18]==bank && bshr[channel][8][24:22]==rank && bshr_counter[channel][8]>0)
            begin 
                front[channel][8]=front[channel][8]+1;
                queue[channel][8][front[channel][8]]=address;
//                out=out+1;
            end 
        else if(bshr[channel][9][21:18]==bank && bshr[channel][9][24:22]==rank && bshr_counter[channel][9]>0)
            begin 
                front[channel][9]=front[channel][9]+1;
                queue[channel][9][front[channel][9]]=address;
            end 
        else 
        begin 
//          $display("%d",address);
       // If the value is not present then checking which entry of bshr is empty and putting the value there and increasing the miss count
        if(bshr_counter[channel][0]==0)
            begin 
              
                bshr[channel][0]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    $display("hitt 0 %d",address);
                    bshr_counter[channel][0]=32;
                    out=out+1;
                end
                else 
                begin 
                    bshr_counter[channel][0]=256;
                    miss=miss+1;
                end
            end
        else if(bshr_counter[channel][1]==0)
            begin 
                bshr[channel][1]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][1]=32;
                    $display("hitt 1 %d",address);
                    out=out+1;
                end
                else 
                begin 
                    bshr_counter[channel][1]=256;
                    miss=miss+1;
                end
            end
         else if(bshr_counter[channel][2]==0)
            begin 
                bshr[channel][2]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][2]=32;
                    $display("hitt 2 %d",address);
                    out=out+1;
                end
                else 
                begin 
                    bshr_counter[channel][2]=256;
                    miss=miss+1;
                end
            end
          else if(bshr_counter[channel][3]==0)
            begin 
                bshr[channel][3]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][3]=32;
                    out=out+1;
                    $display("hitt 3 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][3]=256;
                    miss=miss+1;
                end
            end
          else if(bshr_counter[channel][4]==0)
            begin 
                bshr[channel][4]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][4]=32;
                    out=out+1;
                    $display("hitt 4 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][4]=256;
                    miss=miss+1;
                end
            end  
          else if(bshr_counter[channel][5]==0)
            begin 
                bshr[channel][5]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][5]=32;
                    out=out+1;
                    $display("hitt 5 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][5]=256;
                    miss=miss+1;
                end
            end
           else if(bshr_counter[channel][6]==0)
            begin 
                bshr[channel][6]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][6]=32;
                    out=out+1;
                    $display("hitt 6 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][6]=256;
                    miss=miss+1;
                end
            end
            else if(bshr_counter[channel][7]==0)
            begin 
                bshr[channel][7]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][7]=32;
                    out=out+1;
                    $display("hitt 7 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][7]=256;
                    miss=miss+1;
                end
            end
            else if(bshr_counter[channel][8]==0)
            begin 
                bshr[channel][8]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][8]=32;
                    out=out+1;
                    $display("hitt 8 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][8]=256;
                    miss=miss+1;
                end
            end
            else if(bshr_counter[channel][9]==0)
            begin 
                bshr[channel][9]=address;
                if(row_buffer[channel][rank][bank]==row)
                begin 
                    bshr_counter[channel][9]=32;
                    out=out+1;
                    $display("hitt 9 %d",address);
                end
                else 
                begin 
                    bshr_counter[channel][9]=256;
                    miss=miss+1;
                end
            end
        end
        end
        end

// Removing value from bshr when it is ready and sending the address back to processor
always @(posedge clk) 
begin 
count=count+1;

//$display(bshr_counter[0][0]);
if(round_robin==0) begin
    if(bshr_counter[0][0]==1)
    begin 
//        $display("hi%d",bshr[0][0]);
//    $display("hee%d",bshr[0][0]);
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][0];  // putting the scanned adress in the mem to processor queue
        row_buffer[bshr[0][0][25:25]][bshr[0][0][24:22]][bshr[0][0][21:18]]=bshr[0][0][17:10]; // putting the corressponding row in the row buffer
//        $display("%d %d",rear[0][0],front[0][0]);
        if(rear[0][0]==front[0][0]+1)
        begin 
            bshr[0][0]=0;
        end
        else 
        begin 
            bshr[0][0]=queue[0][0][rear[0][0]];
            rear[0][0]=rear[0][0]+1;
            channel1=bshr[0][0][25:25];
            rank1=bshr[0][0][24:22];
            bank1=bshr[0][0][21:18];
            row1=bshr[0][0][17:10];
            col1=bshr[0][0][9:0];
            block1=bshr[0][0][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1) //checking for row hit
            begin 
//                $display("hit %d",bshr[0][0]);
                bshr_counter[channel1][0]=32; // counter which stores the value of count for each bshr entry
                out=out+1;
                $display("hit 0 %d",bshr[0][0]);
            end
            else 
            begin 
                bshr_counter[channel1][0]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][0]>0) 
    begin 
        bshr_counter[0][0]=bshr_counter[0][0]-1;
    end
    if(bshr_counter[1][0]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][0];
        row_buffer[bshr[1][0][25:25]][bshr[1][0][24:22]][bshr[1][0][21:18]]=bshr[1][0][17:10];
        if(rear[1][0]==front[1][0]+1)
        begin 
            bshr[1][0]=0;
        end
        else 
        begin 
            bshr[1][0]=queue[1][0][rear[1][0]];
            rear[1][0]=rear[1][0]+1;
            channel1=bshr[1][0][25:25];
            rank1=bshr[1][0][24:22];
            bank1=bshr[1][0][21:18];
            row1=bshr[1][0][17:10];
            col1=bshr[1][0][9:0];
            block1=bshr[1][0][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
//                $display("hee%d",bshr[1][0]);
                bshr_counter[channel1][0]=32;
                out=out+1;
                $display("hit 0 %d",bshr[1][0]);
            end
            else 
            begin 
                bshr_counter[channel1][0]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][0]>0) 
    begin 
        bshr_counter[1][0]=bshr_counter[1][0]-1;
    end
    end
    else begin
    if(bshr_counter[1][0]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][0];
        row_buffer[bshr[1][0][25:25]][bshr[1][0][24:22]][bshr[1][0][21:18]]=bshr[1][0][17:10];
        if(rear[1][0]==front[1][0]+1)
        begin 
            bshr[1][0]=0;
        end
        else 
        begin 
            bshr[1][0]=queue[1][0][rear[1][0]];
            rear[1][0]=rear[1][0]+1;
            channel1=bshr[1][0][25:25];
            rank1=bshr[1][0][24:22];
            bank1=bshr[1][0][21:18];
            row1=bshr[1][0][17:10];
            col1=bshr[1][0][9:0];
            block1=bshr[1][0][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
//                $display("hee%d",bshr[1][0]);
                bshr_counter[channel1][0]=32;
                out=out+1;
                $display("hit 0 %d",bshr[1][0]);
            end
            else 
            begin 
                bshr_counter[channel1][0]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][0]==1)
    begin 
//        $display("hi%d",bshr[0][0]);
//    $display("hee%d",bshr[0][0]);
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][0];
        row_buffer[bshr[0][0][25:25]][bshr[0][0][24:22]][bshr[0][0][21:18]]=bshr[0][0][17:10];
//        $display("%d %d",rear[0][0],front[0][0]);
        if(rear[0][0]==front[0][0]+1)
        begin 
            bshr[0][0]=0;
        end
        else 
        begin 
            bshr[0][0]=queue[0][0][rear[0][0]];
            rear[0][0]=rear[0][0]+1;
            channel1=bshr[0][0][25:25];
            rank1=bshr[0][0][24:22];
            bank1=bshr[0][0][21:18];
            row1=bshr[0][0][17:10];
            col1=bshr[0][0][9:0];
            block1=bshr[0][0][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
//                $display("hit %d",bshr[0][0]);
                bshr_counter[channel1][0]=32;
                out=out+1;
                $display("hit 0 %d",bshr[0][0]);
            end
            else 
            begin 
                bshr_counter[channel1][0]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][0]>0) 
    begin 
        bshr_counter[0][0]=bshr_counter[0][0]-1;
    end
    if(bshr_counter[1][0]>0) 
    begin 
        bshr_counter[1][0]=bshr_counter[1][0]-1;
    end
   end
    round_robin=(round_robin+1)%2;
    if(round_robin==0) begin
    if(bshr_counter[0][1]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][1];
        row_buffer[bshr[0][1][25:25]][bshr[0][1][24:22]][bshr[0][1][21:18]]=bshr[0][1][17:10];
        if(rear[0][1]==front[0][1]+1)
        begin 
            bshr[0][1]=0;
        end
        else 
        begin 
            bshr[0][1]=queue[0][1][rear[0][1]];
            rear[0][1]=rear[0][1]+1;
            channel1=bshr[0][1][25:25];
            rank1=bshr[0][1][24:22];
            bank1=bshr[0][1][21:18];
            row1=bshr[0][1][17:10];
            col1=bshr[0][1][9:0];
            block1=bshr[0][1][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][1]=32;
                out=out+1;
                $display("hit 1 %d",bshr[0][1]);
            end
            else 
            begin 
                bshr_counter[channel1][1]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][1]>0) 
    begin 
        bshr_counter[0][1]=bshr_counter[0][1]-1;
    end
    if(bshr_counter[1][1]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][1];
        row_buffer[bshr[1][1][25:25]][bshr[1][1][24:22]][bshr[1][1][21:18]]=bshr[1][1][17:10];
        if(rear[1][1]==front[1][1]+1)
        begin 
            bshr[1][1]=0;
        end
        else 
        begin 
            bshr[1][1]=queue[1][1][rear[1][1]];
            rear[1][1]=rear[1][1]+1;
            channel1=bshr[1][1][25:25];
            rank1=bshr[1][1][24:22];
            bank1=bshr[1][1][21:18];
            row1=bshr[1][1][17:10];
            col1=bshr[1][1][9:0];
            block1=bshr[1][1][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][1]=32;
                out=out+1;
                $display("hit 1 %d",bshr[1][1]);
            end
            else 
            begin 
                bshr_counter[channel1][1]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][1]>0) 
    begin 
        bshr_counter[1][1]=bshr_counter[1][1]-1;
    end
    end
    else begin
        if(bshr_counter[1][1]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][1];
        row_buffer[bshr[1][1][25:25]][bshr[1][1][24:22]][bshr[1][1][21:18]]=bshr[1][1][17:10];
        if(rear[1][1]==front[1][1]+1)
        begin 
            bshr[1][1]=0;
        end
        else 
        begin 
            bshr[1][1]=queue[1][1][rear[1][1]];
            rear[1][1]=rear[1][1]+1;
            channel1=bshr[1][1][25:25];
            rank1=bshr[1][1][24:22];
            bank1=bshr[1][1][21:18];
            row1=bshr[1][1][17:10];
            col1=bshr[1][1][9:0];
            block1=bshr[1][1][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][1]=32;
                out=out+1;
                $display("hit 1 %d",bshr[1][1]);
            end
            else 
            begin 
                bshr_counter[channel1][1]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][1]>0) 
    begin 
        bshr_counter[1][1]=bshr_counter[1][1]-1;
    end
    if(bshr_counter[0][1]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][1];
        row_buffer[bshr[0][1][25:25]][bshr[0][1][24:22]][bshr[0][1][21:18]]=bshr[0][1][17:10];
        if(rear[0][1]==front[0][1]+1)
        begin 
            bshr[0][1]=0;
        end
        else 
        begin 
            bshr[0][1]=queue[0][1][rear[0][1]];
            rear[0][1]=rear[0][1]+1;
            channel1=bshr[0][1][25:25];
            rank1=bshr[0][1][24:22];
            bank1=bshr[0][1][21:18];
            row1=bshr[0][1][17:10];
            col1=bshr[0][1][9:0];
            block1=bshr[0][1][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][1]=32;
                out=out+1;
                $display("hit 1 %d",bshr[0][1]);
            end
            else 
            begin 
                bshr_counter[channel1][1]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][1]>0) 
    begin 
        bshr_counter[0][1]=bshr_counter[0][1]-1;
    end
    end
    round_robin=(round_robin+1)%2;
if(round_robin==0) begin
    if(bshr_counter[0][2]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][2];
        row_buffer[bshr[0][2][25:25]][bshr[0][2][24:22]][bshr[0][2][21:18]]=bshr[0][2][17:10];
         if(rear[0][2]==front[0][2]+1)
        begin 
            bshr[0][2]=0;
        end
        else 
        begin 
            bshr[0][2]=queue[0][2][rear[0][2]];
            rear[0][2]=rear[0][2]+1;
            channel1=bshr[0][2][25:25];
            rank1=bshr[0][2][24:22];
            bank1=bshr[0][2][21:18];
            row1=bshr[0][2][17:10];
            col1=bshr[0][2][9:0];
            block1=bshr[0][2][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][2]=32;
                out=out+1;
                $display("hit 2 %d",bshr[0][2]);
            end
            else 
            begin 
                bshr_counter[channel1][2]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][2]>0) 
    begin 
        bshr_counter[0][2]=bshr_counter[0][2]-1;
    end
    if(bshr_counter[1][2]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][2];
        row_buffer[bshr[1][2][25:25]][bshr[1][2][24:22]][bshr[1][2][21:18]]=bshr[1][2][17:10];
         if(rear[1][2]==front[1][2]+1)
        begin 
            bshr[1][2]=0;
        end
        else 
        begin 
            bshr[1][2]=queue[1][2][rear[1][2]];
            rear[1][2]=rear[1][2]+1;
            channel1=bshr[1][2][25:25];
            rank1=bshr[1][2][24:22];
            bank1=bshr[1][2][21:18];
            row1=bshr[1][2][17:10];
            col1=bshr[1][2][9:0];
            block1=bshr[1][2][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][2]=32;
                out=out+1;
                $display("hit 2 %d",bshr[1][2]);
            end
            else 
            begin 
                bshr_counter[channel1][2]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][2]>0) 
    begin 
        bshr_counter[1][2]=bshr_counter[1][2]-1;
    end
end
else begin
    if(bshr_counter[1][2]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][2];
        row_buffer[bshr[1][2][25:25]][bshr[1][2][24:22]][bshr[1][2][21:18]]=bshr[1][2][17:10];
         if(rear[1][2]==front[1][2]+1)
        begin 
            bshr[1][2]=0;
        end
        else 
        begin 
            bshr[1][2]=queue[1][2][rear[1][2]];
            rear[1][2]=rear[1][2]+1;
            channel1=bshr[1][2][25:25];
            rank1=bshr[1][2][24:22];
            bank1=bshr[1][2][21:18];
            row1=bshr[1][2][17:10];
            col1=bshr[1][2][9:0];
            block1=bshr[1][2][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][2]=32;
                out=out+1;
                $display("hit 2 %d",bshr[1][2]);
            end
            else 
            begin 
                bshr_counter[channel1][2]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][2]>0) 
    begin 
        bshr_counter[1][2]=bshr_counter[1][2]-1;
    end
    if(bshr_counter[0][2]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][2];
        row_buffer[bshr[0][2][25:25]][bshr[0][2][24:22]][bshr[0][2][21:18]]=bshr[0][2][17:10];
         if(rear[0][2]==front[0][2]+1)
        begin 
            bshr[0][2]=0;
        end
        else 
        begin 
            bshr[0][2]=queue[0][2][rear[0][2]];
            rear[0][2]=rear[0][2]+1;
            channel1=bshr[0][2][25:25];
            rank1=bshr[0][2][24:22];
            bank1=bshr[0][2][21:18];
            row1=bshr[0][2][17:10];
            col1=bshr[0][2][9:0];
            block1=bshr[0][2][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][2]=32;
                out=out+1;
                $display("hit 2 %d",bshr[0][2]);
            end
            else 
            begin 
                bshr_counter[channel1][2]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][2]>0) 
    begin 
        bshr_counter[0][2]=bshr_counter[0][2]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][3]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][3];
        row_buffer[bshr[0][3][25:25]][bshr[0][3][24:22]][bshr[0][3][21:18]]=bshr[0][3][17:10];
         if(rear[0][3]==front[0][3]+1)
        begin 
            bshr[0][3]=0;
        end
        else 
        begin 
            bshr[0][3]=queue[0][3][rear[0][3]];
            rear[0][3]=rear[0][3]+1;
            channel1=bshr[0][3][25:25];
            rank1=bshr[0][3][24:22];
            bank1=bshr[0][3][21:18];
            row1=bshr[0][3][17:10];
            col1=bshr[0][3][9:0];
            block1=bshr[0][3][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][3]=32;
                out=out+1;
                $display("hit 3 %d",bshr[0][3]);
            end
            else 
            begin 
                bshr_counter[channel1][3]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][3]>0) 
    begin 
        bshr_counter[0][3]=bshr_counter[0][3]-1;
    end
    if(bshr_counter[1][3]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][3];
        row_buffer[bshr[1][3][25:25]][bshr[1][3][24:22]][bshr[1][3][21:18]]=bshr[1][3][17:10];
         if(rear[1][3]==front[1][3]+1)
        begin 
            bshr[1][3]=0;
        end
        else 
        begin 
            bshr[1][3]=queue[1][3][rear[1][3]];
            rear[1][3]=rear[1][3]+1;
            channel1=bshr[1][3][25:25];
            rank1=bshr[1][3][24:22];
            bank1=bshr[1][3][21:18];
            row1=bshr[1][3][17:10];
            col1=bshr[1][3][9:0];
            block1=bshr[1][3][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][3]=32;
                out=out+1;
                $display("hit 3 %d",bshr[1][3]);
            end
            else 
            begin 
                bshr_counter[channel1][3]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][3]>0) 
    begin 
        bshr_counter[1][3]=bshr_counter[1][3]-1;
    end
end
else begin
    if(bshr_counter[1][3]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][3];
        row_buffer[bshr[1][3][25:25]][bshr[1][3][24:22]][bshr[1][3][21:18]]=bshr[1][3][17:10];
         if(rear[1][3]==front[1][3]+1)
        begin 
            bshr[1][3]=0;
        end
        else 
        begin 
            bshr[1][3]=queue[1][3][rear[1][3]];
            rear[1][3]=rear[1][3]+1;
            channel1=bshr[1][3][25:25];
            rank1=bshr[1][3][24:22];
            bank1=bshr[1][3][21:18];
            row1=bshr[1][3][17:10];
            col1=bshr[1][3][9:0];
            block1=bshr[1][3][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][3]=32;
                out=out+1;
                $display("hit 3 %d",bshr[1][3]);
            end
            else 
            begin 
                bshr_counter[channel1][3]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][3]>0) 
    begin 
        bshr_counter[1][3]=bshr_counter[1][3]-1;
    end
    if(bshr_counter[0][3]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][3];
        row_buffer[bshr[0][3][25:25]][bshr[0][3][24:22]][bshr[0][3][21:18]]=bshr[0][3][17:10];
         if(rear[0][3]==front[0][3]+1)
        begin 
            bshr[0][3]=0;
        end
        else 
        begin 
            bshr[0][3]=queue[0][3][rear[0][3]];
            rear[0][3]=rear[0][3]+1;
            channel1=bshr[0][3][25:25];
            rank1=bshr[0][3][24:22];
            bank1=bshr[0][3][21:18];
            row1=bshr[0][3][17:10];
            col1=bshr[0][3][9:0];
            block1=bshr[0][3][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][3]=32;
                out=out+1;
                $display("hit 3 %d",bshr[0][3]);
            end
            else 
            begin 
                bshr_counter[channel1][3]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][3]>0) 
    begin 
        bshr_counter[0][3]=bshr_counter[0][3]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][4]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][4];
        row_buffer[bshr[0][4][25:25]][bshr[0][4][24:22]][bshr[0][4][21:18]]=bshr[0][4][17:10];
        if(rear[0][4]==front[0][4]+1)
        begin 
            bshr[0][4]=0;
        end
        else 
        begin 
            bshr[0][4]=queue[0][4][rear[0][4]];
            rear[0][4]=rear[0][4]+1;
            channel1=bshr[0][4][25:25];
            rank1=bshr[0][4][24:22];
            bank1=bshr[0][4][21:18];
            row1=bshr[0][4][17:10];
            col1=bshr[0][4][9:0];
            block1=bshr[0][4][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][4]=32;
                out=out+1;
                $display("hit 4 %d",bshr[0][4]);
            end
            else 
            begin 
                bshr_counter[channel1][4]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
        
    end
    if(bshr_counter[0][4]>0) 
    begin 
        bshr_counter[0][4]=bshr_counter[0][4]-1;
    end
    if(bshr_counter[1][4]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][4];
        row_buffer[bshr[1][4][25:25]][bshr[1][4][24:22]][bshr[1][4][21:18]]=bshr[1][4][17:10];
        if(rear[1][4]==front[1][4]+1)
        begin 
            bshr[1][4]=0;
        end
        else 
        begin 
            bshr[1][4]=queue[1][4][rear[1][4]];
            rear[1][4]=rear[1][4]+1;
            channel1=bshr[1][4][25:25];
            rank1=bshr[1][4][24:22];
            bank1=bshr[1][4][21:18];
            row1=bshr[1][4][17:10];
            col1=bshr[1][4][9:0];
            block1=bshr[1][4][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][4]=32;
                out=out+1;
                $display("hit %d",bshr[1][4]);
            end
            else 
            begin 
                bshr_counter[channel1][4]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][4]>0) 
    begin 
        bshr_counter[1][4]=bshr_counter[1][4]-1;
    end
end
else begin
    if(bshr_counter[1][4]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][4];
        row_buffer[bshr[1][4][25:25]][bshr[1][4][24:22]][bshr[1][4][21:18]]=bshr[1][4][17:10];
        if(rear[1][4]==front[1][4]+1)
        begin 
            bshr[1][4]=0;
        end
        else 
        begin 
            bshr[1][4]=queue[1][4][rear[1][4]];
            rear[1][4]=rear[1][4]+1;
            channel1=bshr[1][4][25:25];
            rank1=bshr[1][4][24:22];
            bank1=bshr[1][4][21:18];
            row1=bshr[1][4][17:10];
            col1=bshr[1][4][9:0];
            block1=bshr[1][4][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][4]=32;
                out=out+1;
                $display("hit %d",bshr[1][4]);
            end
            else 
            begin 
                bshr_counter[channel1][4]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][4]>0) 
    begin 
        bshr_counter[1][4]=bshr_counter[1][4]-1;
    end
    if(bshr_counter[0][4]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][4];
        row_buffer[bshr[0][4][25:25]][bshr[0][4][24:22]][bshr[0][4][21:18]]=bshr[0][4][17:10];
        if(rear[0][4]==front[0][4]+1)
        begin 
            bshr[0][4]=0;
        end
        else 
        begin 
            bshr[0][4]=queue[0][4][rear[0][4]];
            rear[0][4]=rear[0][4]+1;
            channel1=bshr[0][4][25:25];
            rank1=bshr[0][4][24:22];
            bank1=bshr[0][4][21:18];
            row1=bshr[0][4][17:10];
            col1=bshr[0][4][9:0];
            block1=bshr[0][4][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][4]=32;
                out=out+1;
                $display("hit 4 %d",bshr[0][4]);
            end
            else 
            begin 
                bshr_counter[channel1][4]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
        
    end
    if(bshr_counter[0][4]>0) 
    begin 
        bshr_counter[0][4]=bshr_counter[0][4]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][5]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][5];
        row_buffer[bshr[0][5][25:25]][bshr[0][5][24:22]][bshr[0][5][21:18]]=bshr[0][5][17:10];
        if(rear[0][5]==front[0][5]+1)
        begin 
            bshr[0][5]=0;
        end
        else 
        begin 
            bshr[0][5]=queue[0][5][rear[0][5]];
            rear[0][5]=rear[0][5]+1;
            channel1=bshr[0][5][25:25];
            rank1=bshr[0][5][24:22];
            bank1=bshr[0][5][21:18];
            row1=bshr[0][5][17:10];
            col1=bshr[0][5][9:0];
            block1=bshr[0][5][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][5]=32;
                out=out+1;
                $display("hit 5 %d",bshr[0][5]);
            end
            else 
            begin 
                bshr_counter[channel1][5]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][5]>0) 
    begin 
        bshr_counter[0][5]=bshr_counter[0][5]-1;
    end
    if(bshr_counter[1][5]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][5];
        row_buffer[bshr[1][5][25:25]][bshr[1][5][24:22]][bshr[1][5][21:18]]=bshr[1][5][17:10];
        if(rear[1][5]==front[1][5]+1)
        begin 
            bshr[1][5]=0;
        end
        else 
        begin 
            bshr[1][5]=queue[1][5][rear[1][5]];
            rear[1][5]=rear[1][5]+1;
            channel1=bshr[1][5][25:25];
            rank1=bshr[1][5][24:22];
            bank1=bshr[1][5][21:18];
            row1=bshr[1][5][17:10];
            col1=bshr[1][5][9:0];
            block1=bshr[1][5][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][5]=32;
                out=out+1;
                $display("hit 5 %d",bshr[1][5]);
            end
            else 
            begin 
                bshr_counter[channel1][5]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][5]>0) 
    begin 
        bshr_counter[1][5]=bshr_counter[1][5]-1;
    end
end
else begin
    if(bshr_counter[1][5]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][5];
        row_buffer[bshr[1][5][25:25]][bshr[1][5][24:22]][bshr[1][5][21:18]]=bshr[1][5][17:10];
        if(rear[1][5]==front[1][5]+1)
        begin 
            bshr[1][5]=0;
        end
        else 
        begin 
            bshr[1][5]=queue[1][5][rear[1][5]];
            rear[1][5]=rear[1][5]+1;
            channel1=bshr[1][5][25:25];
            rank1=bshr[1][5][24:22];
            bank1=bshr[1][5][21:18];
            row1=bshr[1][5][17:10];
            col1=bshr[1][5][9:0];
            block1=bshr[1][5][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][5]=32;
                out=out+1;
                $display("hit 5 %d",bshr[1][5]);
            end
            else 
            begin 
                bshr_counter[channel1][5]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][5]>0) 
    begin 
        bshr_counter[1][5]=bshr_counter[1][5]-1;
    end
    if(bshr_counter[0][5]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][5];
        row_buffer[bshr[0][5][25:25]][bshr[0][5][24:22]][bshr[0][5][21:18]]=bshr[0][5][17:10];
        if(rear[0][5]==front[0][5]+1)
        begin 
            bshr[0][5]=0;
        end
        else 
        begin 
            bshr[0][5]=queue[0][5][rear[0][5]];
            rear[0][5]=rear[0][5]+1;
            channel1=bshr[0][5][25:25];
            rank1=bshr[0][5][24:22];
            bank1=bshr[0][5][21:18];
            row1=bshr[0][5][17:10];
            col1=bshr[0][5][9:0];
            block1=bshr[0][5][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][5]=32;
                out=out+1;
                $display("hit 5 %d",bshr[0][5]);
            end
            else 
            begin 
                bshr_counter[channel1][5]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][5]>0) 
    begin 
        bshr_counter[0][5]=bshr_counter[0][5]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][6]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][6];
        row_buffer[bshr[0][6][25:25]][bshr[0][6][24:22]][bshr[0][6][21:18]]=bshr[0][6][17:10];
        if(rear[0][6]==front[0][6]+1)
        begin 
            bshr[0][6]=0;
        end
        else 
        begin 
            bshr[0][6]=queue[0][6][rear[0][6]];
            rear[0][6]=rear[0][6]+1;
            channel1=bshr[0][6][25:25];
            rank1=bshr[0][6][24:22];
            bank1=bshr[0][6][21:18];
            row1=bshr[0][6][17:10];
            col1=bshr[0][6][9:0];
            block1=bshr[0][6][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][6]=32;
                out=out+1;
                $display("hit 6 %d",bshr[0][6]);
            end
            else 
            begin 
                bshr_counter[channel1][6]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][6]>0) 
    begin 
        bshr_counter[0][6]=bshr_counter[0][6]-1;
    end
    if(bshr_counter[1][6]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][6];
        row_buffer[bshr[1][6][25:25]][bshr[1][6][24:22]][bshr[1][6][21:18]]=bshr[1][6][17:10];
        if(rear[1][6]==front[1][6]+1)
        begin 
            bshr[1][6]=0;
        end
        else 
        begin 
            bshr[1][6]=queue[1][6][rear[1][6]];
            rear[1][6]=rear[1][6]+1;
            channel1=bshr[1][6][25:25];
            rank1=bshr[1][6][24:22];
            bank1=bshr[1][6][21:18];
            row1=bshr[1][6][17:10];
            col1=bshr[1][6][9:0];
            block1=bshr[1][6][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][6]=32;
                out=out+1;
                $display("hit 6 %d",bshr[1][6]);
            end
            else 
            begin 
                bshr_counter[channel1][6]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][6]>0) 
    begin 
        bshr_counter[1][6]=bshr_counter[1][6]-1;
    end
end
else begin
    if(bshr_counter[1][6]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][6];
        row_buffer[bshr[1][6][25:25]][bshr[1][6][24:22]][bshr[1][6][21:18]]=bshr[1][6][17:10];
        if(rear[1][6]==front[1][6]+1)
        begin 
            bshr[1][6]=0;
        end
        else 
        begin 
            bshr[1][6]=queue[1][6][rear[1][6]];
            rear[1][6]=rear[1][6]+1;
            channel1=bshr[1][6][25:25];
            rank1=bshr[1][6][24:22];
            bank1=bshr[1][6][21:18];
            row1=bshr[1][6][17:10];
            col1=bshr[1][6][9:0];
            block1=bshr[1][6][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][6]=32;
                out=out+1;
                $display("hit 6 %d",bshr[1][6]);
            end
            else 
            begin 
                bshr_counter[channel1][6]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][6]>0) 
    begin 
        bshr_counter[1][6]=bshr_counter[1][6]-1;
    end
    if(bshr_counter[0][6]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][6];
        row_buffer[bshr[0][6][25:25]][bshr[0][6][24:22]][bshr[0][6][21:18]]=bshr[0][6][17:10];
        if(rear[0][6]==front[0][6]+1)
        begin 
            bshr[0][6]=0;
        end
        else 
        begin 
            bshr[0][6]=queue[0][6][rear[0][6]];
            rear[0][6]=rear[0][6]+1;
            channel1=bshr[0][6][25:25];
            rank1=bshr[0][6][24:22];
            bank1=bshr[0][6][21:18];
            row1=bshr[0][6][17:10];
            col1=bshr[0][6][9:0];
            block1=bshr[0][6][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][6]=32;
                out=out+1;
                $display("hit 6 %d",bshr[0][6]);
            end
            else 
            begin 
                bshr_counter[channel1][6]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][6]>0) 
    begin 
        bshr_counter[0][6]=bshr_counter[0][6]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][7]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][7];
        row_buffer[bshr[0][7][25:25]][bshr[0][7][24:22]][bshr[0][7][21:18]]=bshr[0][7][17:10];
        if(rear[0][7]==front[0][7]+1)
        begin 
            bshr[0][7]=0;
        end
        else 
        begin 
            bshr[0][7]=queue[0][7][rear[0][7]];
            rear[0][7]=rear[0][7]+1;
            channel1=bshr[0][7][25:25];
            rank1=bshr[0][7][24:22];
            bank1=bshr[0][7][21:18];
            row1=bshr[0][7][17:10];
            col1=bshr[0][7][9:0];
            block1=bshr[0][7][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][7]=32;
                out=out+1;
                $display("hit 7 %d",bshr[0][7]);
            end
            else 
            begin 
                bshr_counter[channel1][7]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][7]>0) 
    begin 
        bshr_counter[0][7]=bshr_counter[0][7]-1;
    end
    if(bshr_counter[1][7]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][7];
        row_buffer[bshr[1][7][25:25]][bshr[1][7][24:22]][bshr[1][7][21:18]]=bshr[1][7][17:10];
        if(rear[1][7]==front[1][7]+1)
        begin 
            bshr[1][7]=0;
        end
        else 
        begin 
            bshr[1][7]=queue[1][7][rear[1][7]];
            rear[1][7]=rear[1][7]+1;
            channel1=bshr[1][7][25:25];
            rank1=bshr[1][7][24:22];
            bank1=bshr[1][7][21:18];
            row1=bshr[1][7][17:10];
            col1=bshr[1][7][9:0];
            block1=bshr[1][7][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][7]=32;
                out=out+1;
                $display("hit 7 %d",bshr[1][7]);
            end
            else 
            begin 
                bshr_counter[channel1][7]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][7]>0) 
    begin 
        bshr_counter[1][7]=bshr_counter[1][7]-1;
    end
end
else begin
    if(bshr_counter[1][7]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][7];
        row_buffer[bshr[1][7][25:25]][bshr[1][7][24:22]][bshr[1][7][21:18]]=bshr[1][7][17:10];
        if(rear[1][7]==front[1][7]+1)
        begin 
            bshr[1][7]=0;
        end
        else 
        begin 
            bshr[1][7]=queue[1][7][rear[1][7]];
            rear[1][7]=rear[1][7]+1;
            channel1=bshr[1][7][25:25];
            rank1=bshr[1][7][24:22];
            bank1=bshr[1][7][21:18];
            row1=bshr[1][7][17:10];
            col1=bshr[1][7][9:0];
            block1=bshr[1][7][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][7]=32;
                out=out+1;
                $display("hit 7 %d",bshr[1][7]);
            end
            else 
            begin 
                bshr_counter[channel1][7]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][7]>0) 
    begin 
        bshr_counter[1][7]=bshr_counter[1][7]-1;
    end
    if(bshr_counter[0][7]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][7];
        row_buffer[bshr[0][7][25:25]][bshr[0][7][24:22]][bshr[0][7][21:18]]=bshr[0][7][17:10];
        if(rear[0][7]==front[0][7]+1)
        begin 
            bshr[0][7]=0;
        end
        else 
        begin 
            bshr[0][7]=queue[0][7][rear[0][7]];
            rear[0][7]=rear[0][7]+1;
            channel1=bshr[0][7][25:25];
            rank1=bshr[0][7][24:22];
            bank1=bshr[0][7][21:18];
            row1=bshr[0][7][17:10];
            col1=bshr[0][7][9:0];
            block1=bshr[0][7][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][7]=32;
                out=out+1;
                $display("hit 7 %d",bshr[0][7]);
            end
            else 
            begin 
                bshr_counter[channel1][7]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][7]>0) 
    begin 
        bshr_counter[0][7]=bshr_counter[0][7]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][8]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][8];
        row_buffer[bshr[0][8][25:25]][bshr[0][8][24:22]][bshr[0][8][21:18]]=bshr[0][8][17:10];
        if(rear[0][8]==front[0][8]+1)
        begin 
            bshr[0][8]=0;
        end
        else 
        begin 
            bshr[0][8]=queue[0][8][rear[0][8]];
            rear[0][8]=rear[0][8]+1;
            channel1=bshr[0][8][25:25];
            rank1=bshr[0][8][24:22];
            bank1=bshr[0][8][21:18];
            row1=bshr[0][8][17:10];
            col1=bshr[0][8][9:0];
            block1=bshr[0][8][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][8]=32;
                out=out+1;
                $display("hit 8 %d",bshr[0][8]);
            end
            else 
            begin 
                bshr_counter[channel1][8]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][8]>0) 
    begin 
        bshr_counter[0][8]=bshr_counter[0][8]-1;
    end
    if(bshr_counter[1][8]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][8];
        row_buffer[bshr[1][8][25:25]][bshr[1][8][24:22]][bshr[1][8][21:18]]=bshr[1][8][17:10];
        if(rear[1][8]==front[1][8]+1)
        begin 
            bshr[1][8]=0;
        end
        else 
        begin 
            bshr[1][8]=queue[1][8][rear[1][8]];
            rear[1][8]=rear[1][8]+1;
            channel1=bshr[1][8][25:25];
            rank1=bshr[1][8][24:22];
            bank1=bshr[1][8][21:18];
            row1=bshr[1][8][17:10];
            col1=bshr[1][8][9:0];
            block1=bshr[1][8][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][8]=32;
                out=out+1;
                $display("hit 8 %d",bshr[1][8]);
            end
            else 
            begin 
                bshr_counter[channel1][8]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][8]>0) 
    begin 
        bshr_counter[1][8]=bshr_counter[1][8]-1;
    end
end
else begin
    if(bshr_counter[1][8]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][8];
        row_buffer[bshr[1][8][25:25]][bshr[1][8][24:22]][bshr[1][8][21:18]]=bshr[1][8][17:10];
        if(rear[1][8]==front[1][8]+1)
        begin 
            bshr[1][8]=0;
        end
        else 
        begin 
            bshr[1][8]=queue[1][8][rear[1][8]];
            rear[1][8]=rear[1][8]+1;
            channel1=bshr[1][8][25:25];
            rank1=bshr[1][8][24:22];
            bank1=bshr[1][8][21:18];
            row1=bshr[1][8][17:10];
            col1=bshr[1][8][9:0];
            block1=bshr[1][8][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][8]=32;
                out=out+1;
                $display("hit 8 %d",bshr[1][8]);
            end
            else 
            begin 
                bshr_counter[channel1][8]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][8]>0) 
    begin 
        bshr_counter[1][8]=bshr_counter[1][8]-1;
    end
    if(bshr_counter[0][8]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][8];
        row_buffer[bshr[0][8][25:25]][bshr[0][8][24:22]][bshr[0][8][21:18]]=bshr[0][8][17:10];
        if(rear[0][8]==front[0][8]+1)
        begin 
            bshr[0][8]=0;
        end
        else 
        begin 
            bshr[0][8]=queue[0][8][rear[0][8]];
            rear[0][8]=rear[0][8]+1;
            channel1=bshr[0][8][25:25];
            rank1=bshr[0][8][24:22];
            bank1=bshr[0][8][21:18];
            row1=bshr[0][8][17:10];
            col1=bshr[0][8][9:0];
            block1=bshr[0][8][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][8]=32;
                out=out+1;
                $display("hit 8 %d",bshr[0][8]);
            end
            else 
            begin 
                bshr_counter[channel1][8]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][8]>0) 
    begin 
        bshr_counter[0][8]=bshr_counter[0][8]-1;
    end
end
round_robin=(round_robin+1)%2;
if(round_robin==0)begin
    if(bshr_counter[0][9]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][9];
        row_buffer[bshr[0][9][25:25]][bshr[0][9][24:22]][bshr[0][9][21:18]]=bshr[0][9][17:10];
        if(rear[0][9]==front[0][9]+1)
        begin 
            bshr[0][9]=0;
        end
        else 
        begin 
            bshr[0][9]=queue[0][9][rear[0][9]];
            rear[0][9]=rear[0][9]+1;
            channel1=bshr[0][9][25:25];
            rank1=bshr[0][9][24:22];
            bank1=bshr[0][9][21:18];
            row1=bshr[0][9][17:10];
            col1=bshr[0][9][9:0];
            block1=bshr[0][9][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][9]=32;
                out=out+1;
                $display("hit 9 %d",bshr[0][9]);
            end
            else 
            begin 
                bshr_counter[channel1][9]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][9]>0) 
    begin 
        bshr_counter[0][9]=bshr_counter[0][9]-1;
    end
    if(bshr_counter[1][9]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][9];
        row_buffer[bshr[1][9][25:25]][bshr[1][9][24:22]][bshr[1][9][21:18]]=bshr[1][9][17:10];
        if(rear[1][9]==front[1][9]+1)
        begin 
            bshr[1][9]=0;
        end
        else 
        begin 
            bshr[1][9]=queue[1][9][rear[1][9]];
            rear[1][9]=rear[1][9]+1;
            channel1=bshr[1][9][25:25];
            rank1=bshr[1][9][24:22];
            bank1=bshr[1][9][21:18];
            row1=bshr[1][9][17:10];
            col1=bshr[1][9][9:0];
            block1=bshr[1][9][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][9]=32;
                out=out+1;
                $display("hit 9 %d",bshr[1][9]);
            end
            else 
            begin 
                bshr_counter[channel1][9]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][9]>0) 
    begin 
        bshr_counter[1][9]=bshr_counter[1][9]-1;
    end
end
else begin
    if(bshr_counter[1][9]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[1][9];
        row_buffer[bshr[1][9][25:25]][bshr[1][9][24:22]][bshr[1][9][21:18]]=bshr[1][9][17:10];
        if(rear[1][9]==front[1][9]+1)
        begin 
            bshr[1][9]=0;
        end
        else 
        begin 
            bshr[1][9]=queue[1][9][rear[1][9]];
            rear[1][9]=rear[1][9]+1;
            channel1=bshr[1][9][25:25];
            rank1=bshr[1][9][24:22];
            bank1=bshr[1][9][21:18];
            row1=bshr[1][9][17:10];
            col1=bshr[1][9][9:0];
            block1=bshr[1][9][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][9]=32;
                out=out+1;
                $display("hit 9 %d",bshr[1][9]);
            end
            else 
            begin 
                bshr_counter[channel1][9]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[1][9]>0) 
    begin 
        bshr_counter[1][9]=bshr_counter[1][9]-1;
    end
    if(bshr_counter[0][9]==1)
    begin 
        front1=front1+1;
        mem_to_pro[front1]=bshr[0][9];
        row_buffer[bshr[0][9][25:25]][bshr[0][9][24:22]][bshr[0][9][21:18]]=bshr[0][9][17:10];
        if(rear[0][9]==front[0][9]+1)
        begin 
            bshr[0][9]=0;
        end
        else 
        begin 
            bshr[0][9]=queue[0][9][rear[0][9]];
            rear[0][9]=rear[0][9]+1;
            channel1=bshr[0][9][25:25];
            rank1=bshr[0][9][24:22];
            bank1=bshr[0][9][21:18];
            row1=bshr[0][9][17:10];
            col1=bshr[0][9][9:0];
            block1=bshr[0][9][5:0];
            if(row_buffer[channel1][rank1][bank1]==row1)
            begin 
                bshr_counter[channel1][9]=32;
                out=out+1;
                $display("hit 9 %d",bshr[0][9]);
            end
            else 
            begin 
                bshr_counter[channel1][9]=256;
                miss=miss+1;
//                row_buffer[channel1][rank1][bank1]=row1;
            end
        end
    end
    if(bshr_counter[0][9]>0) 
    begin 
        bshr_counter[0][9]=bshr_counter[0][9]-1;
    end
end
// checking wheather mem to pro queue is empty or not
if(front1>=rear1)
begin 
    done1=1;
end
else begin
done1=0;
end
if(pop==1) begin 
//$display("%d",mem_to_pro[rear1]);
mem_ins=mem_to_pro[rear1];
rear1=rear1+1;

done1=0;
end
hit_counter<=out;
counter<=count;
miss_counter<=miss;
end
assign done=done1;
assign done_address=mem_ins;
//assign hit_counter=out;
endmodule