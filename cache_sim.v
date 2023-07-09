//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 08.04.2023 23:48:04
//// Design Name: 
//// Module Name: sim_cache
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module sim_cache;
//    reg clk;
//    reg ins;
//    wire [30:0] hit;
//    wire [30:0] miss;
//    cache testcache(clk,ins,hit,miss);
    
//    initial begin
//endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2023 10:44:40
// Design Name: 
// Module Name: cache_sim
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


`timescale 1ns / 1ps

module cache_sim(output reg[30:0] cnt);

 // Inputs

 reg Clk=0;

 reg [31:0] dataIn;
 wire [31:0] hit,miss;
wire [31:0]out;
reg enab=1;
 // Instantiate the Unit Under Test (UUT)

 cache uut (
 Clk,dataIn,hit,miss ,out     
                  );

 initial begin

  // Initialize Inputs
enab=0;
  dataIn  = 32'hffffffff;

  // Wait 100 ns for global reset to finish

  // Add stimulus here
  #20
  dataIn  = 32'h22222222;
  #20
  dataIn  = 32'h33333333;
  #20
  dataIn  = 32'h44444444;
  #20
  dataIn  = 32'h11111111;
 #20
  dataIn  = 32'h55555555;
  #20
  dataIn  = 32'h66666666;
  #20
  dataIn  = 32'h77777777;
  #20
  dataIn  = 32'h88888888;
  #20
dataIn = 32'h17409488;
#20
dataIn = 32'h24551711;
#20
dataIn = 32'h52761423;
#20
dataIn = 32'h22168576;
#20
dataIn = 32'h18927954;
#20
dataIn = 32'h31233411;
#20
dataIn = 32'h38742779;
#20
dataIn = 32'h31986502;
#20
dataIn = 32'h86024865;
#20
dataIn = 32'h09006138;
#20
dataIn = 32'h93446066;
#20
dataIn = 32'h18496378;
#20
dataIn = 32'h82913598;
#20
dataIn = 32'h40763615;
#20
dataIn = 32'h42097372;
#20
dataIn = 32'h60165754;
#20
dataIn = 32'h12001460;
#20
dataIn = 32'h71777733;
#20
dataIn = 32'h59981826;
#20
dataIn = 32'h60380125;
#20
dataIn = 32'h09478351;
#20
dataIn = 32'h20164061;
#20
dataIn = 32'h89841439;
#20
dataIn = 32'h88087783;
#20
dataIn = 32'h83710734;
#20
dataIn = 32'h96510996;
#20
dataIn = 32'h83484992;
#20
dataIn = 32'h55333743;
#20
dataIn = 32'h80880681;
#20
dataIn = 32'h98972282;
#20
dataIn = 32'h89078158;
#20
dataIn = 32'h61242586;
#20
dataIn = 32'h26539246;
#20
dataIn = 32'h18211976;
#20
dataIn = 32'h29520039;
#20
dataIn = 32'h18195325;
#20
dataIn = 32'h25867722;
#20
dataIn = 32'h94196982;
#20
dataIn = 32'h55491250;
#20
dataIn = 32'h83939679;
#20
dataIn = 32'h97693576;
#20
dataIn = 32'h65825441;
#20
dataIn = 32'h61633553;
#20
dataIn = 32'h28253618;
#20
dataIn = 32'h62146291;
#20
dataIn = 32'h50364929;
#20
dataIn = 32'h34405963;
#20
dataIn = 32'h42887581;
#20
dataIn = 32'h25744444;
#20
dataIn = 32'h29307787;
#20
dataIn = 32'h30382520;
#20
dataIn = 32'h37297534;
#20
dataIn = 32'h32113253;
#20
dataIn = 32'h51222640;
#20
dataIn = 32'h70340053;
#20
dataIn = 32'h10675004;
#20
dataIn = 32'h54956482;
#20
dataIn = 32'h16831484;
#20
dataIn = 32'h92070607;
#20
dataIn = 32'h05673849;
#20
dataIn = 32'h26577457;
#20
dataIn = 32'h98302236;
#20
dataIn = 32'h71554026;
#20
dataIn = 32'h06111730;
#20
dataIn = 32'h04830129;
#20
dataIn = 32'h03885770;
#20
dataIn = 32'h89307478;
#20
dataIn = 32'h37100834;
#20
dataIn = 32'h50145620;
#20
dataIn = 32'h35666767;
#20
dataIn = 32'h71916272;
#20
dataIn = 32'h76513995;
#20
dataIn = 32'h92653244;
#20
dataIn = 32'h42792373;
#20
dataIn = 32'h15785832;
#20
dataIn = 32'h41159510;
#20
dataIn = 32'h64530891;
#20
dataIn = 32'h34746365;
#20
dataIn = 32'h28103155;
#20
dataIn = 32'h22174823;
#20
dataIn = 32'h63035280;
#20
dataIn = 32'h72259108;
#20
dataIn = 32'h50790534;
#20
dataIn = 32'h10485925;
#20
dataIn = 32'h41395827;
#20
dataIn = 32'h96177190;
#20
dataIn = 32'h34175332;
#20
dataIn = 32'h41290874;
#20
dataIn = 32'h56807743;
#20
dataIn = 32'h13630190;
#20
dataIn = 32'h42931482;
#20
dataIn = 32'h05593287;
#20
dataIn = 32'h48143552;
#20
dataIn = 32'h68929594;
#20
dataIn = 32'h50588013;
#20
dataIn = 32'h22270313;
#20
dataIn = 32'h37095583;
#20
dataIn = 32'h78379391;
#20
dataIn = 32'h82801848;
#20
dataIn = 32'h60930087;
#20
dataIn = 32'h63565839;
#20
dataIn = 32'h48397645;
#20
dataIn = 32'h86155196;
#20
dataIn = 32'h45425326;
#20
dataIn = 32'h82663945;
#20
dataIn = 32'h62535661;
#20
dataIn = 32'h44626825;
#20
dataIn = 32'h51015176;
#20
dataIn = 32'h00243362;
#20
dataIn = 32'h82343436;
#20
dataIn = 32'h84739800;
#20
dataIn = 32'h88051436;
#20
dataIn = 32'h39219823;
#20
dataIn = 32'h40231989;
#20
dataIn = 32'h89135142;
#20
dataIn = 32'h53892870;
#20
dataIn = 32'h14819359;
#20
dataIn = 32'h79801475;
#20
dataIn = 32'h55092824;
#20
dataIn = 32'h50440511;
#20
dataIn = 32'h59083872;
#20
dataIn = 32'h69381033;
#20
dataIn = 32'h84801541;
#20
dataIn = 32'h37358569;
#20
dataIn = 32'h08936069;
#20
dataIn = 32'h78941566;
#20
dataIn = 32'h66671406;
#20
dataIn = 32'h12149523;
#20
dataIn = 32'h41523168;
#20
dataIn = 32'h82771260;
#20
dataIn = 32'h49460362;
#20
dataIn = 32'h45881214;
#20
dataIn = 32'h98245299;
#20
dataIn = 32'h83869866;
#20
dataIn = 32'h23826275;
#20
dataIn = 32'h78278020;
#20
dataIn = 32'h89282055;
#20
dataIn = 32'h27678781;
#20
dataIn = 32'h60958900;
#20
dataIn = 32'h07255214;
#20
dataIn = 32'h86468983;
#20
dataIn = 32'h55155840;
#20
dataIn = 32'h54721499;
#20
dataIn = 32'h03035076;
#20
dataIn = 32'h78364419;
#20
dataIn = 32'h55747340;
#20
dataIn = 32'h88152324;
#20
dataIn = 32'h66629049;
#20
dataIn = 32'h31199555;
#20
dataIn = 32'h60594634;
#20
dataIn = 32'h90539128;
#20
dataIn = 32'h81860249;
#20
dataIn = 32'h02215444;
#20
dataIn = 32'h25042127;
#20
dataIn = 32'h79554034;
#20
dataIn = 32'h12298227;
#20
dataIn = 32'h85839446;
#20
dataIn = 32'h98566072;
#20
dataIn = 32'h72647132;
#20
dataIn = 32'h16383286;
#20
dataIn = 32'h01260546;
#20
dataIn = 32'h79347881;
#20
dataIn = 32'h63876172;
#20
dataIn = 32'h37858587;
#20
dataIn = 32'h33108109;
#20
dataIn = 32'h24915733;
#20
dataIn = 32'h42201277;
#20
dataIn = 32'h02410373;
#20
dataIn = 32'h95972028;
#20
dataIn = 32'h67081830;
#20
dataIn = 32'h36202841;
#20
dataIn = 32'h83758170;
#20
dataIn = 32'h48813678;
#20
dataIn = 32'h95556630;
#20
dataIn = 32'h08823065;
#20
dataIn = 32'h09722829;
#20
dataIn = 32'h44827258;
#20
dataIn = 32'h47395190;
#20
dataIn = 32'h28314310;
#20
dataIn = 32'h40790814;
#20
dataIn = 32'h07953823;
#20
dataIn = 32'h21040759;
#20
dataIn = 32'h05120989;
#20
dataIn = 32'h17330766;
#20
dataIn = 32'h02898999;
#20
dataIn = 32'h42087873;
#20
dataIn = 32'h07642191;
#20
dataIn = 32'h60336221;
#20
dataIn = 32'h43260549;
#20
dataIn = 32'h60827407;
#20
dataIn = 32'h60129385;
#20
dataIn = 32'h15668898;
#20
dataIn = 32'h70791586;
#20
dataIn = 32'h39453823;
#20
dataIn = 32'h94851328;
#20
dataIn = 32'h16467796;
#20
dataIn = 32'h41926315;
#20
dataIn = 32'h97026176;
#20
dataIn = 32'h25340755;
#20
dataIn = 32'h31888017;
#20
dataIn = 32'h50590935;
#20
dataIn = 32'h42726722;
#20
dataIn = 32'h01175918;
#20
dataIn = 32'h17866992;
#20
dataIn = 32'h66584037;
#20
dataIn = 32'h83112576;
#20
dataIn = 32'h21611574;
#20
dataIn = 32'h85649843;
#20
dataIn = 32'h25383270;
#20
dataIn = 32'h68011953;
#20
dataIn = 32'h63153403;
#20
dataIn = 32'h17903529;
#20
dataIn = 32'h12617015;
#20
dataIn = 32'h22905183;
#20
dataIn = 32'h68861667;
#20
dataIn = 32'h04989498;
#20
dataIn = 32'h75648687;
#20
dataIn = 32'h80956900;
#20
dataIn = 32'h13558017;
#20
dataIn = 32'h74670741;
#20
dataIn = 32'h21835714;
#20
dataIn = 32'h76823027;
#20
dataIn = 32'h88597134;
#20
dataIn = 32'h71371275;
#20
dataIn = 32'h34455141;
#20
dataIn = 32'h26633008;
#20
dataIn = 32'h13816980;
#20
dataIn = 32'h13939365;
#20
dataIn = 32'h54050655;
#20
dataIn = 32'h18962250;
#20
dataIn = 32'h52520672;
#20
dataIn = 32'h80068306;
#20
dataIn = 32'h43705207;
#20
dataIn = 32'h56181856;
#20
dataIn = 32'h59265232;
#20
dataIn = 32'h12288874;
#20
dataIn = 32'h00599530;
#20
dataIn = 32'h99511123;
#20
dataIn = 32'h39723304;
#20
dataIn = 32'h84392490;
#20
dataIn = 32'h57476630;
#20
dataIn = 32'h90801510;
#20
dataIn = 32'h39589625;
#20
dataIn = 32'h76385930;
#20
dataIn = 32'h25157794;
#20
dataIn = 32'h17857884;
#20
dataIn = 32'h23841304;
#20
dataIn = 32'h17721313;
#20
dataIn = 32'h15150512;
#20
dataIn = 32'h21553892;
#20
dataIn = 32'h84275840;
#20
dataIn = 32'h94435841;
#20
dataIn = 32'h03340675;
#20
dataIn = 32'h56098357;
#20
dataIn = 32'h90487402;
#20
dataIn = 32'h35416645;
#20
dataIn = 32'h29124993;
#20
dataIn = 32'h76587897;
#20
dataIn = 32'h71650132;
#20
dataIn = 32'h60574490;
#20
dataIn = 32'h61190421;
#20
dataIn = 32'h97093331;
#20
dataIn = 32'h35695988;
#20
dataIn = 32'h39513628;
#20
dataIn = 32'h81981334;
#20
dataIn = 32'h39272176;
#20
dataIn = 32'h17306025;
#20
dataIn = 32'h60720954;
#20
dataIn = 32'h32560881;
#20
dataIn = 32'h57579237;
#20
dataIn = 32'h27936381;
#20
dataIn = 32'h06876512;
#20
dataIn = 32'h95615413;
#20
dataIn = 32'h85092133;
#20
dataIn = 32'h52904857;
#20
dataIn = 32'h33030321;
#20
dataIn = 32'h10818728;
#20
dataIn = 32'h92302825;
#20
dataIn = 32'h58124988;
#20
dataIn = 32'h27179503;
#20
dataIn = 32'h40153423;
#20
dataIn = 32'h29492490;
#20
dataIn = 32'h44985323;
#20
dataIn = 32'h01719883;
#20
dataIn = 32'h29332834;
#20
dataIn = 32'h02012107;
#20
dataIn = 32'h66805889;
#20
dataIn = 32'h57322200;
#20
dataIn = 32'h23168772;
#20
dataIn = 32'h87959291;
#20
dataIn = 32'h30819202;
#20
dataIn = 32'h47581007;
#20
dataIn = 32'h16930373;
#20
dataIn = 32'h04323102;
#20
dataIn = 32'h77130703;
#20
dataIn = 32'h63195615;
#20
dataIn = 32'h10973081;
#20
dataIn = 32'h51717949;
#20
dataIn = 32'h80018508;
#20
dataIn = 32'h92808514;
#20
dataIn = 32'h73616808;
#20
dataIn = 32'h65710283;
#20
dataIn = 32'h55614938;
#20
dataIn = 32'h32337301;
#20
dataIn = 32'h48789897;
#20
dataIn = 32'h91958969;
#20
dataIn = 32'h33141457;
#20
dataIn = 32'h63463834;
#20
dataIn = 32'h27890140;
#20
dataIn = 32'h73494568;
#20
dataIn = 32'h98997084;
#20
dataIn = 32'h56936200;
#20
dataIn = 32'h65161973;
#20
dataIn = 32'h50065182;
#20
dataIn = 32'h72452258;
#20
dataIn = 32'h69835505;
#20
dataIn = 32'h81507341;
#20
dataIn = 32'h56417040;
#20
dataIn = 32'h61055258;
#20
dataIn = 32'h32785272;
#20
dataIn = 32'h97631598;
#20
dataIn = 32'h95495252;
#20
dataIn = 32'h23087283;
#20
dataIn = 32'h75418296;
#20
dataIn = 32'h89816375;
#20
dataIn = 32'h41012285;
#20
dataIn = 32'h46773449;
#20
dataIn = 32'h18387971;
#20
dataIn = 32'h14352915;
#20
dataIn = 32'h56790231;
#20
dataIn = 32'h98784443;
#20
dataIn = 32'h58029498;
#20
dataIn = 32'h35043525;
#20
dataIn = 32'h77744041;
#20
dataIn = 32'h15402868;
#20
dataIn = 32'h14764987;
#20
dataIn = 32'h38628098;
#20
dataIn = 32'h04968284;
#20
dataIn = 32'h79407481;
#20
dataIn = 32'h82214669;
#20
dataIn = 32'h38136452;
#20
dataIn = 32'h20103873;
#20
dataIn = 32'h31456121;
#20
dataIn = 32'h91804774;
#20
dataIn = 32'h11981032;
#20
dataIn = 32'h50322633;
#20
dataIn = 32'h61582193;
#20
dataIn = 32'h97213209;
#20
dataIn = 32'h27450329;
#20
dataIn = 32'h78011474;
#20
dataIn = 32'h39967620;
#20
dataIn = 32'h96230351;
#20
dataIn = 32'h96792756;
#20
dataIn = 32'h82463091;
#20
dataIn = 32'h87684037;
#20
dataIn = 32'h96227307;
#20
dataIn = 32'h30736467;
#20
dataIn = 32'h40124463;
#20
dataIn = 32'h45020169;
#20
dataIn = 32'h37915244;
#20
dataIn = 32'h13468870;
#20
dataIn = 32'h34467181;
#20
dataIn = 32'h21231110;
#20
dataIn = 32'h89109774;
#20
dataIn = 32'h51678393;
#20
dataIn = 32'h13963752;
#20
dataIn = 32'h07170671;
#20
dataIn = 32'h75481752;
#20
dataIn = 32'h17531000;
#20
dataIn = 32'h50078649;
#20
dataIn = 32'h14808997;
#20
dataIn = 32'h99960638;
#20
dataIn = 32'h03694204;
#20
dataIn = 32'h43691891;
#20
dataIn = 32'h18635091;
#20
dataIn = 32'h08226897;
#20
dataIn = 32'h78930563;
#20
dataIn = 32'h97743583;
#20
dataIn = 32'h33610474;
#20
dataIn = 32'h27157227;
#20
dataIn = 32'h03609896;
#20
dataIn = 32'h40290322;
#20
dataIn = 32'h47745313;
#20
dataIn = 32'h34352169;
#20
dataIn = 32'h88414573;
#20
dataIn = 32'h02777020;
#20
dataIn = 32'h08645015;
#20
dataIn = 32'h73279114;
#20
dataIn = 32'h03315830;
#20
dataIn = 32'h51025104;
#20
dataIn = 32'h06489562;
#20
dataIn = 32'h22174786;
#20
dataIn = 32'h00213924;
#20
dataIn = 32'h15406681;
#20
dataIn = 32'h33105893;
#20
dataIn = 32'h89843996;
#20
dataIn = 32'h97725232;
#20
dataIn = 32'h83385788;
#20
dataIn = 32'h13512086;
#20
dataIn = 32'h55395354;
#20
dataIn = 32'h85035084;
#20
dataIn = 32'h35812602;
#20
dataIn = 32'h21650177;
#20
dataIn = 32'h38351321;
#20
dataIn = 32'h94230148;
#20
dataIn = 32'h66138794;
#20
dataIn = 32'h43544277;
#20
dataIn = 32'h56690709;
#20
dataIn = 32'h86732015;
#20
dataIn = 32'h35654681;
#20
dataIn = 32'h58533287;
#20
dataIn = 32'h69646321;
#20
dataIn = 32'h05870037;
#20
dataIn = 32'h34620116;
#20
dataIn = 32'h53495343;
#20
dataIn = 32'h77091540;
#20
dataIn = 32'h07123773;
#20
dataIn = 32'h33915888;
#20
dataIn = 32'h02443367;
#20
dataIn = 32'h66148165;
#20
dataIn = 32'h96871916;
#20
dataIn = 32'h76371279;
#20
dataIn = 32'h47182488;
#20
dataIn = 32'h16204859;
#20
dataIn = 32'h44499453;
#20
dataIn = 32'h21743190;
#20
dataIn = 32'h73842698;
#20
dataIn = 32'h77487832;
#20
dataIn = 32'h19374443;
#20
dataIn = 32'h51328090;
#20
dataIn = 32'h34944398;
#20
dataIn = 32'h53812389;
#20
dataIn = 32'h85106181;
#20
dataIn = 32'h87728236;
#20
dataIn = 32'h69651380;
#20
dataIn = 32'h76160310;
#20
dataIn = 32'h43158954;
#20
dataIn = 32'h57446775;
#20
dataIn = 32'h26889198;
#20
dataIn = 32'h05029602;
#20
dataIn = 32'h29267360;
#20
dataIn = 32'h52171153;
#20
dataIn = 32'h26681586;
#20
dataIn = 32'h94662881;
#20
dataIn = 32'h68789790;
#20
dataIn = 32'h58269717;
#20
dataIn = 32'h51644996;
#20
dataIn = 32'h15560750;
#20
dataIn = 32'h79568537;
#20
dataIn = 32'h07523049;
#20
dataIn = 32'h85800977;
#20
dataIn = 32'h44759232;
#20
dataIn = 32'h23197304;
#20
dataIn = 32'h37808812;
#20
dataIn = 32'h74919362;
#20
dataIn = 32'h07200535;
#20
dataIn = 32'h77443386;
#20
dataIn = 32'h44592442;
#20
dataIn = 32'h42532340;
#20
dataIn = 32'h23720776;
#20
dataIn = 32'h17567908;
#20
dataIn = 32'h57425658;
#20
dataIn = 32'h82852767;
#20
dataIn = 32'h33569445;
#20
dataIn = 32'h96929561;
#20
dataIn = 32'h78372691;
#20
dataIn = 32'h00456364;
#20
dataIn = 32'h67639147;
#20
dataIn = 32'h50055886;
#20
dataIn = 32'h98156060;
#20
dataIn = 32'h47864034;
#20
dataIn = 32'h10043610;
#20
dataIn = 32'h56867678;
#20
dataIn = 32'h94510286;
#20
dataIn = 32'h70774622;
#20
dataIn = 32'h96564069;
#20
dataIn = 32'h62912647;
#20
dataIn = 32'h08241003;
#20
dataIn = 32'h61798029;
#20
dataIn = 32'h89747753;
#20
dataIn = 32'h91296114;
#20
dataIn = 32'h98697482;
#20
dataIn = 32'h58256193;
#20
dataIn = 32'h71320689;
#20
dataIn = 32'h93911348;
#20
dataIn = 32'h24914394;
#20
dataIn = 32'h95216725;
#20
dataIn = 32'h18075742;
#20
dataIn = 32'h91844812;
#20
dataIn = 32'h84673158;
#20
dataIn = 32'h54266461;
#20
dataIn = 32'h40466758;
#20
dataIn = 32'h11511907;
#20
dataIn = 32'h63445726;
#20
dataIn = 32'h56296532;
#20
dataIn = 32'h16349056;
#20
dataIn = 32'h50653326;
#20
dataIn = 32'h60620052;
#20
dataIn = 32'h05610494;
#20
dataIn = 32'h02664072;
#20
dataIn = 32'h66851002;
#20
dataIn = 32'h13843508;
#20
dataIn = 32'h70535630;
#20
dataIn = 32'h29937939;
#20
dataIn = 32'h30251183;
#20
dataIn = 32'h37467194;
#20
dataIn = 32'h61282577;
#20
dataIn = 32'h84206505;
#20
dataIn = 32'h60724440;
#20
dataIn = 32'h50662631;
#20
dataIn = 32'h75554899;
#20
dataIn = 32'h81277921;
#20
dataIn = 32'h82979900;
#20
dataIn = 32'h64253519;
#20
dataIn = 32'h78491987;
#20
dataIn = 32'h96956474;
#20
dataIn = 32'h48651498;
#20
dataIn = 32'h87345775;
#20
dataIn = 32'h13379653;
#20
dataIn = 32'h40249804;
#20
dataIn = 32'h26156105;
#20
dataIn = 32'h04870817;
#20
dataIn = 32'h28011910;
#20
dataIn = 32'h32322818;
#20
dataIn = 32'h75626474;
#20
dataIn = 32'h37054373;
#20
dataIn = 32'h80568268;
#20
dataIn = 32'h12662430;
#20
dataIn = 32'h20510580;
#20
dataIn = 32'h13828457;
#20
dataIn = 32'h23891622;
#20
dataIn = 32'h13856689;
#20
dataIn = 32'h35769577;
 end 
 initial begin
 #1
  forever #10 Clk = ~Clk;  
  end
   initial begin
   cnt = 0;
  forever #20 cnt = cnt+1;  
  end
endmodule