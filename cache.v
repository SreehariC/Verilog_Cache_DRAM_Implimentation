`timescale 1ns / 1ps



module cache(
input clk, input [31:0] ins,output[31:0] hit, output[31:0] miss,output [31:0]inst
    );
    reg [17:0] cache [255:0][3:0];
    parameter DEPTH = 5000;
parameter DATA_WIDTH = 32;

reg [DATA_WIDTH-1:0] mem [DEPTH-1:0];
    reg [10:0]hit_cnt=0 ;
    reg [10:0] miss_cnt=0;
    reg [17:0] lru [255:0][3:0];
    reg [31:0] mshr [3:0];
    reg [9:0]tim=0;
    
    reg is_full=0;
    reg [6:0]index;
    reg [17:0]tag;
    reg [6:0]temp_ind;
    reg [17:0]val;
    reg [4:0]pos;
 
   reg [31:0] curr;
   
    
    reg [17:0] comp;
   reg comp_out;
    reg [5:0] match = -1;
    
    assign hit=hit_cnt;
    assign miss=miss_cnt;
    assign inst=curr;
    wire empty;
    wire full;
    reg [10:0]head=0;
    reg [10:0]tail=0;

      reg is_present[3:0];
      
    initial begin
        is_full = 0;
        is_present[0]=0;
        is_present[1]=0;
        is_present[2]=0;
        is_present[3]=0;
       end


  reg [10:0]mshr_clk[3:0];
 always @(posedge clk) begin
    tim = tim + 1;
    end
 always @(posedge clk) begin
    if(is_present[0]) mshr_clk[0]=mshr_clk[0]+1;
     if(is_present[1]) mshr_clk[1]=mshr_clk[1]+1;    
     if(is_present[2]) mshr_clk[2]=mshr_clk[2]+1;
     if(is_present[3]) mshr_clk[3]=mshr_clk[3]+1;
     end  
  
  always  @(posedge clk) begin 
      mem[head]=ins;
       head=head+1;
      
     
    
     if(mshr_clk[0]==8) begin
    //$display("ms%d\n",mshr_clk[0]);
      mshr_clk[0]=0;
      is_present[0]=0;
      //mshr_cnt=0;
      temp_ind = mshr[0][13:6];
      //now finding cache in block
      pos = 0;
      val = lru[temp_ind][0];
//      $display("nahi %d",lru[temp_ind][0]);
      if(lru[temp_ind][1] < val)
      begin
      val = lru[temp_ind][1];
      pos = 1;
      end
        
      if(lru[temp_ind][2] < val)
      begin
      val = lru[temp_ind][2];
      pos = 2;
      end
      
      if(lru[temp_ind][3] < val)
      begin
      val = lru[temp_ind][3];
      pos = 3;
      end
      
      cache[temp_ind][pos] = mshr[0][31:14];
      $display("%df",temp_ind);
      lru[temp_ind][pos]= tim;
      
//            $display("cc%d",lru[temp_ind][pos]);
//              $display("cc%d",mshr[0]);
        //  mshr[0]=0;
       
      end
     
     
     //changing value
      
      if(mshr_clk[1]== 8) begin
//      $display("ms%d\n",curr);
      mshr_clk[1]=0;
      is_present[1]=0;
  
      temp_ind = mshr[1][13:6];
     
      //now finding cache in block
      pos = 0;
      val = lru[temp_ind][0];
//      $display("nahi %d",lru[temp_ind][0]);
      if(lru[temp_ind][1] < val)
      begin
      val = lru[temp_ind][1];
      pos = 1;
      end
        
      if(lru[temp_ind][2] < val)
      begin
      val = lru[temp_ind][2];
      pos = 2;
      end
      
      if(lru[temp_ind][3] < val)
      begin
      val = lru[temp_ind][3];
      pos = 3;
      end
      
      cache[temp_ind][pos] = mshr[1][31:14];
      $display("%d fuck u",mshr[1][31:14]);
      lru[temp_ind][pos]= tim;
      // mshr[1]=0;
      end
    
    
    //changing value
    
    
    if(mshr_clk[2]==8) begin
//    $display("ms%d\n",curr);
      mshr_clk[2]=0;
      is_present[2]=0;
      
      temp_ind = mshr[2][13:6];
      
      //now finding cache in block
      pos = 0;
       val = lru[temp_ind][0];
//      $display("nahi %d",lru[temp_ind][0]);
      if(lru[temp_ind][1] < val)
      begin
      val = lru[temp_ind][1];
      pos = 1;
      end
        
      if(lru[temp_ind][2] < val)
      begin
      val = lru[temp_ind][2];
      pos = 2;
      end
      
      if(lru[temp_ind][3] < val)
      begin
      val = lru[temp_ind][3];
      pos = 3;
      end
      
      cache[temp_ind][pos] = mshr[2][31:14];
      lru[temp_ind][pos]= tim;
      //mshr[2]=0;
      end
    
    
    //changing
    
    
    if(mshr_clk[3]==8) begin
//    $display("ms%d\n",curr);
      mshr_clk[3]=0;
      is_present[3]=0;
      
      temp_ind = mshr[3][13:6];
    
    
      //now finding cache in block
      pos = 0;
      val = lru[temp_ind][0];
//      $display("nahi %d",lru[temp_ind][0]);
      if(lru[temp_ind][1] < val)
      begin
      val = lru[temp_ind][1];
      pos = 1;
      end
        
      if(lru[temp_ind][2] < val)
      begin
      val = lru[temp_ind][2];
      pos = 2;
      end
      
      if(lru[temp_ind][3] < val)
      begin
      val = lru[temp_ind][3];
      pos = 3;
      end
      
      cache[temp_ind][pos] = mshr[3][31:14];
      lru[temp_ind][pos]= tim;
      //mshr[3]=0;
//      $display("cc%d",cache[temp_ind][pos]);
      end
      end
      
    
always  @(posedge clk) begin 
      if(!(is_present[0]==1 && is_present[1]==1 && is_present[2]==1 && is_present[3]==1)) is_full=0;
        if(!is_full) begin
        index =  mem[tail][13:6];
        curr=mem[tail];
        tag=mem[tail][31:14];
        
      //   $display("%d",tag);
        comp=tag;
        tail=tail+1;
        match = -1;
          //match1=-1;
          comp_out=0;
          if(cache[index][0] == comp) begin //comp1=1'b1;
          comp_out=1;
          match=0;
          end
          //else begin comp1=1'b0;
          //end
          //match2=-1;
          if(cache[index][1]==comp) begin //comp2=1'b1;
          comp_out=1;
          match=1;
          end
          //else begin comp2=1'b0;end
          //match3=-1;
          if(cache[index][2]==comp) begin //comp3=1'b1;
          comp_out=1;
          match=2;
          end
          //else begin comp3=1'b0;end    
          //match4=-1;
          if(cache[index][3]==comp) begin //comp4=1'b1;
          comp_out=1;
          match=3;
          end
          //else begin comp4=1'b0;end
          //comp_out=comp1||comp2||comp3||comp4;
      
        //match=match1+match2+match3+match4+3;
     
//        $display("h%d",comp_out);
        if(comp_out == 1) begin
        
        hit_cnt = hit_cnt + 1;
        lru[index][match]=tim;
//        $display("hit%d",hit_cnt);
//        lru[index][match]=lru[index][match]+1;
        end
        else begin
        miss_cnt = miss_cnt + 1;
        if(!is_present[0]) 
        begin
        
        mshr[0] = curr;    
        //$display("ff%d",curr);
       
        is_present[0]=1;
         mshr_clk[0]=1;
        end
        else if(!is_present[1])
         begin
//         $display("ms1");
        mshr[1] = curr;
        is_present[1]=1;
         mshr_clk[1]=1;
        end
        else if(!is_present[2])
         begin
//         $display("ms2");
        mshr[2] = curr;
        is_present[2]=1;
         mshr_clk[2]=1;
        end
        else if(!is_present[3])
         begin
//         $display("ms3");
        mshr[3] = curr;
        is_present[3]=1;
         mshr_clk[3]=1;
        end
//        else begin
////        $display("ful");
//                is_full=1;
//            end

    if(is_present[0] && is_present[1] && is_present[2] && is_present[3]) is_full=1;
        end
        
         end
         
        
        end
        
 
endmodule