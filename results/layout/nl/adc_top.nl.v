module adc_top (busy,
    clk,
    cmp_out,
    conv_done,
    cs_n,
    err_flag,
    miso,
    mosi,
    result_valid,
    rst_n,
    sample_en,
    sclk,
    channel_sel,
    dac_code,
    result_channel,
    result_data);
 output busy;
 input clk;
 input cmp_out;
 output conv_done;
 input cs_n;
 output err_flag;
 output miso;
 input mosi;
 output result_valid;
 input rst_n;
 output sample_en;
 input sclk;
 output [2:0] channel_sel;
 output [9:0] dac_code;
 output [2:0] result_channel;
 output [9:0] result_data;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire _117_;
 wire _118_;
 wire _119_;
 wire _120_;
 wire _121_;
 wire _122_;
 wire _123_;
 wire _124_;
 wire _125_;
 wire _126_;
 wire _127_;
 wire _128_;
 wire _129_;
 wire _130_;
 wire _131_;
 wire _132_;
 wire _133_;
 wire _134_;
 wire _135_;
 wire _136_;
 wire _137_;
 wire _138_;
 wire _139_;
 wire _140_;
 wire _141_;
 wire _142_;
 wire _143_;
 wire _144_;
 wire _145_;
 wire _146_;
 wire _147_;
 wire _148_;
 wire _149_;
 wire _150_;
 wire _151_;
 wire _152_;
 wire _153_;
 wire _154_;
 wire _155_;
 wire _156_;
 wire _157_;
 wire _158_;
 wire _159_;
 wire _160_;
 wire _161_;
 wire _162_;
 wire _163_;
 wire _164_;
 wire _165_;
 wire _166_;
 wire _167_;
 wire _168_;
 wire _169_;
 wire _170_;
 wire _171_;
 wire _172_;
 wire _173_;
 wire _174_;
 wire _175_;
 wire _176_;
 wire _177_;
 wire _178_;
 wire _179_;
 wire _180_;
 wire _181_;
 wire _182_;
 wire _183_;
 wire _184_;
 wire _185_;
 wire _186_;
 wire _187_;
 wire _188_;
 wire _189_;
 wire _190_;
 wire _191_;
 wire _192_;
 wire _193_;
 wire \conv_channel_w[0] ;
 wire \conv_channel_w[1] ;
 wire \conv_channel_w[2] ;
 wire conv_start_w;
 wire \sar_result_w[0] ;
 wire \sar_result_w[1] ;
 wire \sar_result_w[2] ;
 wire \sar_result_w[3] ;
 wire \sar_result_w[4] ;
 wire \sar_result_w[5] ;
 wire \sar_result_w[6] ;
 wire \sar_result_w[7] ;
 wire \sar_result_w[8] ;
 wire \sar_result_w[9] ;
 wire \u_sar_core.state_q[0] ;
 wire \u_sar_core.state_q[1] ;
 wire \u_sar_core.state_q[2] ;
 wire \u_sar_core.state_q[3] ;
 wire \u_spi.abort_err_q ;
 wire \u_spi.bit_count_q[0] ;
 wire \u_spi.bit_count_q[1] ;
 wire \u_spi.bit_count_q[2] ;
 wire \u_spi.bit_count_q[3] ;
 wire \u_spi.bit_count_q[4] ;
 wire \u_spi.ch_addr_w[0] ;
 wire \u_spi.ch_addr_w[1] ;
 wire \u_spi.ch_addr_w[2] ;
 wire \u_spi.channel_sync_q[0] ;
 wire \u_spi.channel_sync_q[1] ;
 wire \u_spi.channel_sync_q[2] ;
 wire \u_spi.cmd_err_q ;
 wire \u_spi.miso_bit ;
 wire \u_spi.req_channel_q[0] ;
 wire \u_spi.req_channel_q[1] ;
 wire \u_spi.req_channel_q[2] ;
 wire \u_spi.sgl_bit_w ;
 wire \u_spi.start_bit_w ;
 wire \u_spi.start_toggle_q ;
 wire \u_spi.sync_toggle_q1 ;
 wire \u_spi.sync_toggle_q2 ;
 wire \u_spi.sync_toggle_q3 ;
 wire \u_spi.tx_shift_q[10] ;
 wire \u_spi.tx_shift_q[11] ;
 wire \u_spi.tx_shift_q[12] ;
 wire \u_spi.tx_shift_q[13] ;
 wire \u_spi.tx_shift_q[14] ;
 wire \u_spi.tx_shift_q[15] ;
 wire \u_spi.tx_shift_q[1] ;
 wire \u_spi.tx_shift_q[2] ;
 wire \u_spi.tx_shift_q[3] ;
 wire \u_spi.tx_shift_q[4] ;
 wire \u_spi.tx_shift_q[5] ;
 wire \u_spi.tx_shift_q[6] ;
 wire \u_spi.tx_shift_q[7] ;
 wire \u_spi.tx_shift_q[8] ;
 wire \u_spi.tx_shift_q[9] ;
 wire \u_spi.tx_snapshot_q[0] ;
 wire \u_spi.tx_snapshot_q[10] ;
 wire \u_spi.tx_snapshot_q[11] ;
 wire \u_spi.tx_snapshot_q[12] ;
 wire \u_spi.tx_snapshot_q[13] ;
 wire \u_spi.tx_snapshot_q[14] ;
 wire \u_spi.tx_snapshot_q[15] ;
 wire \u_spi.tx_snapshot_q[1] ;
 wire \u_spi.tx_snapshot_q[2] ;
 wire \u_spi.tx_snapshot_q[3] ;
 wire \u_spi.tx_snapshot_q[4] ;
 wire \u_spi.tx_snapshot_q[5] ;
 wire \u_spi.tx_snapshot_q[6] ;
 wire \u_spi.tx_snapshot_q[7] ;
 wire \u_spi.tx_snapshot_q[8] ;
 wire \u_spi.tx_snapshot_q[9] ;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;
 wire net32;
 wire net33;
 wire net34;
 wire net35;
 wire net36;
 wire net37;
 wire net38;
 wire net39;
 wire net40;
 wire net41;
 wire net42;
 wire net43;
 wire net44;
 wire net45;
 wire net46;
 wire net47;
 wire net48;
 wire net49;
 wire net50;
 wire net51;
 wire net52;
 wire net53;
 wire net54;
 wire net55;
 wire net56;
 wire net57;
 wire net58;
 wire net59;
 wire net60;
 wire net61;
 wire net62;
 wire net63;
 wire net64;
 wire net65;
 wire net66;
 wire clknet_0_clk;
 wire clknet_2_0__leaf_clk;
 wire clknet_2_1__leaf_clk;
 wire clknet_2_2__leaf_clk;
 wire clknet_2_3__leaf_clk;
 wire net67;
 wire net68;
 wire net69;
 wire net70;
 wire net71;
 wire net72;
 wire net73;
 wire net74;
 wire net75;
 wire net76;
 wire net77;
 wire net78;
 wire net79;
 wire net80;
 wire net81;
 wire net82;
 wire net83;
 wire net84;
 wire net85;
 wire net86;
 wire net87;
 wire net88;
 wire net89;
 wire net90;
 wire net91;
 wire net92;
 wire net93;
 wire net94;
 wire net95;
 wire net96;
 wire net97;
 wire net98;
 wire net99;
 wire net100;
 wire net101;
 wire net102;
 wire net103;
 wire net104;
 wire net105;
 wire net106;
 wire net107;
 wire net108;
 wire net109;
 wire net110;
 wire net111;
 wire net112;
 wire net113;
 wire net114;
 wire net115;
 wire net116;
 wire net117;

 sky130_fd_sc_hd__inv_2 _194_ (.A(net44),
    .Y(_128_));
 sky130_fd_sc_hd__inv_2 _195_ (.A(\u_sar_core.state_q[1] ),
    .Y(_129_));
 sky130_fd_sc_hd__inv_2 _196_ (.A(net65),
    .Y(_042_));
 sky130_fd_sc_hd__inv_2 _197_ (.A(\u_spi.bit_count_q[0] ),
    .Y(_027_));
 sky130_fd_sc_hd__inv_2 _198_ (.A(net1),
    .Y(_130_));
 sky130_fd_sc_hd__inv_2 _199_ (.A(net12),
    .Y(_131_));
 sky130_fd_sc_hd__inv_2 _200_ (.A(net14),
    .Y(_132_));
 sky130_fd_sc_hd__inv_2 _201_ (.A(net49),
    .Y(_059_));
 sky130_fd_sc_hd__nor2_1 _202_ (.A(net43),
    .B(\u_sar_core.state_q[3] ),
    .Y(_133_));
 sky130_fd_sc_hd__nor3_1 _203_ (.A(\u_sar_core.state_q[1] ),
    .B(net43),
    .C(\u_sar_core.state_q[3] ),
    .Y(_134_));
 sky130_fd_sc_hd__or3_2 _204_ (.A(\u_sar_core.state_q[1] ),
    .B(net43),
    .C(\u_sar_core.state_q[3] ),
    .X(_135_));
 sky130_fd_sc_hd__or2_2 _205_ (.A(net44),
    .B(\u_sar_core.state_q[1] ),
    .X(_136_));
 sky130_fd_sc_hd__nor2_1 _206_ (.A(net44),
    .B(_135_),
    .Y(_137_));
 sky130_fd_sc_hd__inv_2 _207_ (.A(_137_),
    .Y(net6));
 sky130_fd_sc_hd__or3_1 _208_ (.A(_027_),
    .B(\u_spi.bit_count_q[4] ),
    .C(\u_spi.bit_count_q[1] ),
    .X(_138_));
 sky130_fd_sc_hd__nor3b_1 _209_ (.A(_138_),
    .B(\u_spi.bit_count_q[3] ),
    .C_N(\u_spi.bit_count_q[2] ),
    .Y(_139_));
 sky130_fd_sc_hd__a21bo_1 _210_ (.A1(net3),
    .A2(net6),
    .B1_N(\u_spi.sgl_bit_w ),
    .X(_140_));
 sky130_fd_sc_hd__a31o_1 _211_ (.A1(\u_spi.start_bit_w ),
    .A2(_139_),
    .A3(_140_),
    .B1(\u_spi.cmd_err_q ),
    .X(_119_));
 sky130_fd_sc_hd__and2_1 _212_ (.A(net45),
    .B(net54),
    .X(_086_));
 sky130_fd_sc_hd__nor2_1 _213_ (.A(_128_),
    .B(_135_),
    .Y(net36));
 sky130_fd_sc_hd__nand2_2 _214_ (.A(net43),
    .B(\u_sar_core.state_q[3] ),
    .Y(_141_));
 sky130_fd_sc_hd__nor2_1 _215_ (.A(_136_),
    .B(_141_),
    .Y(net10));
 sky130_fd_sc_hd__or4_1 _216_ (.A(\u_spi.bit_count_q[0] ),
    .B(\u_spi.bit_count_q[1] ),
    .C(\u_spi.bit_count_q[3] ),
    .D(\u_spi.bit_count_q[2] ),
    .X(_010_));
 sky130_fd_sc_hd__nor3_1 _217_ (.A(\u_spi.bit_count_q[3] ),
    .B(\u_spi.bit_count_q[2] ),
    .C(_138_),
    .Y(_142_));
 sky130_fd_sc_hd__and2_1 _218_ (.A(\u_spi.tx_snapshot_q[0] ),
    .B(net38),
    .X(_018_));
 sky130_fd_sc_hd__mux2_1 _219_ (.A0(\u_spi.tx_shift_q[1] ),
    .A1(\u_spi.tx_snapshot_q[1] ),
    .S(net38),
    .X(_019_));
 sky130_fd_sc_hd__mux2_1 _220_ (.A0(\u_spi.tx_shift_q[2] ),
    .A1(\u_spi.tx_snapshot_q[2] ),
    .S(net38),
    .X(_020_));
 sky130_fd_sc_hd__mux2_1 _221_ (.A0(\u_spi.tx_shift_q[3] ),
    .A1(\u_spi.tx_snapshot_q[3] ),
    .S(net38),
    .X(_021_));
 sky130_fd_sc_hd__mux2_1 _222_ (.A0(\u_spi.tx_shift_q[4] ),
    .A1(\u_spi.tx_snapshot_q[4] ),
    .S(net38),
    .X(_022_));
 sky130_fd_sc_hd__mux2_1 _223_ (.A0(\u_spi.tx_shift_q[5] ),
    .A1(\u_spi.tx_snapshot_q[5] ),
    .S(net39),
    .X(_023_));
 sky130_fd_sc_hd__mux2_1 _224_ (.A0(\u_spi.tx_shift_q[6] ),
    .A1(\u_spi.tx_snapshot_q[6] ),
    .S(net39),
    .X(_024_));
 sky130_fd_sc_hd__mux2_1 _225_ (.A0(\u_spi.tx_shift_q[7] ),
    .A1(\u_spi.tx_snapshot_q[7] ),
    .S(net39),
    .X(_025_));
 sky130_fd_sc_hd__mux2_1 _226_ (.A0(\u_spi.tx_shift_q[8] ),
    .A1(\u_spi.tx_snapshot_q[8] ),
    .S(net39),
    .X(_026_));
 sky130_fd_sc_hd__mux2_1 _227_ (.A0(\u_spi.tx_shift_q[9] ),
    .A1(\u_spi.tx_snapshot_q[9] ),
    .S(net39),
    .X(_012_));
 sky130_fd_sc_hd__mux2_1 _228_ (.A0(\u_spi.tx_shift_q[10] ),
    .A1(\u_spi.tx_snapshot_q[10] ),
    .S(net38),
    .X(_013_));
 sky130_fd_sc_hd__mux2_1 _229_ (.A0(\u_spi.tx_shift_q[11] ),
    .A1(\u_spi.tx_snapshot_q[11] ),
    .S(net38),
    .X(_014_));
 sky130_fd_sc_hd__mux2_1 _230_ (.A0(\u_spi.tx_shift_q[12] ),
    .A1(\u_spi.tx_snapshot_q[12] ),
    .S(net38),
    .X(_015_));
 sky130_fd_sc_hd__mux2_1 _231_ (.A0(\u_spi.tx_shift_q[13] ),
    .A1(\u_spi.tx_snapshot_q[13] ),
    .S(net38),
    .X(_016_));
 sky130_fd_sc_hd__mux2_1 _232_ (.A0(\u_spi.tx_shift_q[14] ),
    .A1(\u_spi.tx_snapshot_q[14] ),
    .S(net38),
    .X(_017_));
 sky130_fd_sc_hd__nor2_1 _233_ (.A(\u_spi.bit_count_q[4] ),
    .B(_010_),
    .Y(_143_));
 sky130_fd_sc_hd__mux2_1 _234_ (.A0(\u_spi.tx_shift_q[15] ),
    .A1(\u_spi.tx_snapshot_q[15] ),
    .S(_143_),
    .X(\u_spi.miso_bit ));
 sky130_fd_sc_hd__nand2_1 _235_ (.A(conv_start_w),
    .B(_137_),
    .Y(_144_));
 sky130_fd_sc_hd__and2_1 _236_ (.A(net44),
    .B(\u_sar_core.state_q[1] ),
    .X(_145_));
 sky130_fd_sc_hd__nand2_2 _237_ (.A(net44),
    .B(\u_sar_core.state_q[1] ),
    .Y(_146_));
 sky130_fd_sc_hd__nand2b_2 _238_ (.A_N(net43),
    .B(\u_sar_core.state_q[3] ),
    .Y(_147_));
 sky130_fd_sc_hd__nor2_1 _239_ (.A(_146_),
    .B(_147_),
    .Y(_148_));
 sky130_fd_sc_hd__and3b_1 _240_ (.A_N(_147_),
    .B(_128_),
    .C(\u_sar_core.state_q[1] ),
    .X(_149_));
 sky130_fd_sc_hd__mux2_1 _241_ (.A0(net11),
    .A1(net1),
    .S(net40),
    .X(_150_));
 sky130_fd_sc_hd__o21a_1 _242_ (.A1(_149_),
    .A2(_150_),
    .B1(net37),
    .X(_000_));
 sky130_fd_sc_hd__nand2_1 _243_ (.A(\u_sar_core.state_q[1] ),
    .B(_133_),
    .Y(_151_));
 sky130_fd_sc_hd__or3b_1 _244_ (.A(net44),
    .B(_129_),
    .C_N(_133_),
    .X(_152_));
 sky130_fd_sc_hd__nand2b_2 _245_ (.A_N(\u_sar_core.state_q[3] ),
    .B(net43),
    .Y(_153_));
 sky130_fd_sc_hd__o21ba_1 _246_ (.A1(\u_sar_core.state_q[1] ),
    .A2(net43),
    .B1_N(\u_sar_core.state_q[3] ),
    .X(_154_));
 sky130_fd_sc_hd__a31o_1 _247_ (.A1(_135_),
    .A2(_141_),
    .A3(_146_),
    .B1(_154_),
    .X(_155_));
 sky130_fd_sc_hd__nand2_1 _248_ (.A(_152_),
    .B(_155_),
    .Y(_156_));
 sky130_fd_sc_hd__a2111o_1 _249_ (.A1(net43),
    .A2(\u_sar_core.state_q[3] ),
    .B1(_130_),
    .C1(_129_),
    .D1(net44),
    .X(_157_));
 sky130_fd_sc_hd__or2_1 _250_ (.A(_146_),
    .B(_153_),
    .X(_158_));
 sky130_fd_sc_hd__or3_1 _251_ (.A(net43),
    .B(_134_),
    .C(_145_),
    .X(_159_));
 sky130_fd_sc_hd__and2_1 _252_ (.A(_158_),
    .B(_159_),
    .X(_160_));
 sky130_fd_sc_hd__nand2_1 _253_ (.A(_158_),
    .B(_159_),
    .Y(_161_));
 sky130_fd_sc_hd__or4_1 _254_ (.A(net44),
    .B(_129_),
    .C(\u_sar_core.state_q[2] ),
    .D(_130_),
    .X(_162_));
 sky130_fd_sc_hd__nand2_1 _255_ (.A(net44),
    .B(_129_),
    .Y(_163_));
 sky130_fd_sc_hd__o22a_1 _256_ (.A1(_131_),
    .A2(_149_),
    .B1(_163_),
    .B2(_147_),
    .X(_164_));
 sky130_fd_sc_hd__o21ai_1 _257_ (.A1(_156_),
    .A2(_162_),
    .B1(_164_),
    .Y(_165_));
 sky130_fd_sc_hd__and2_1 _258_ (.A(net37),
    .B(_165_),
    .X(_001_));
 sky130_fd_sc_hd__nor2_1 _259_ (.A(_133_),
    .B(_136_),
    .Y(_166_));
 sky130_fd_sc_hd__o2111ai_2 _260_ (.A1(_133_),
    .A2(_136_),
    .B1(_141_),
    .C1(_146_),
    .D1(_135_),
    .Y(_167_));
 sky130_fd_sc_hd__or3b_1 _261_ (.A(net44),
    .B(_134_),
    .C_N(_141_),
    .X(_168_));
 sky130_fd_sc_hd__and4bb_1 _262_ (.A_N(_130_),
    .B_N(_167_),
    .C(_168_),
    .D(_155_),
    .X(_169_));
 sky130_fd_sc_hd__nor2_1 _263_ (.A(_136_),
    .B(_147_),
    .Y(_170_));
 sky130_fd_sc_hd__o21a_1 _264_ (.A1(_147_),
    .A2(_163_),
    .B1(net13),
    .X(_171_));
 sky130_fd_sc_hd__a211o_1 _265_ (.A1(_161_),
    .A2(_169_),
    .B1(_170_),
    .C1(_171_),
    .X(_172_));
 sky130_fd_sc_hd__and2_1 _266_ (.A(net37),
    .B(_172_),
    .X(_002_));
 sky130_fd_sc_hd__and4_1 _267_ (.A(net1),
    .B(_141_),
    .C(_155_),
    .D(_166_),
    .X(_173_));
 sky130_fd_sc_hd__o2bb2a_1 _268_ (.A1_N(_161_),
    .A2_N(_173_),
    .B1(_170_),
    .B2(_132_),
    .X(_174_));
 sky130_fd_sc_hd__a21boi_1 _269_ (.A1(_158_),
    .A2(_174_),
    .B1_N(net37),
    .Y(_003_));
 sky130_fd_sc_hd__and4_1 _270_ (.A(net1),
    .B(_155_),
    .C(_167_),
    .D(_168_),
    .X(_175_));
 sky130_fd_sc_hd__or3_1 _271_ (.A(\u_sar_core.state_q[0] ),
    .B(_129_),
    .C(_153_),
    .X(_176_));
 sky130_fd_sc_hd__a22oi_1 _272_ (.A1(net15),
    .A2(_158_),
    .B1(_161_),
    .B2(_175_),
    .Y(_177_));
 sky130_fd_sc_hd__a21boi_1 _273_ (.A1(_176_),
    .A2(_177_),
    .B1_N(net37),
    .Y(_004_));
 sky130_fd_sc_hd__nor2_1 _274_ (.A(_153_),
    .B(_163_),
    .Y(_178_));
 sky130_fd_sc_hd__a2bb2o_1 _275_ (.A1_N(_157_),
    .A2_N(_161_),
    .B1(_176_),
    .B2(net16),
    .X(_179_));
 sky130_fd_sc_hd__o21a_1 _276_ (.A1(_178_),
    .A2(_179_),
    .B1(net37),
    .X(_005_));
 sky130_fd_sc_hd__o21a_1 _277_ (.A1(_153_),
    .A2(_163_),
    .B1(net17),
    .X(_180_));
 sky130_fd_sc_hd__a2bb2o_1 _278_ (.A1_N(_136_),
    .A2_N(_153_),
    .B1(_160_),
    .B2(_169_),
    .X(_181_));
 sky130_fd_sc_hd__o21a_1 _279_ (.A1(_180_),
    .A2(_181_),
    .B1(net37),
    .X(_006_));
 sky130_fd_sc_hd__o21a_1 _280_ (.A1(_136_),
    .A2(_153_),
    .B1(net18),
    .X(_182_));
 sky130_fd_sc_hd__a22o_1 _281_ (.A1(_133_),
    .A2(_145_),
    .B1(_160_),
    .B2(_173_),
    .X(_183_));
 sky130_fd_sc_hd__o21a_1 _282_ (.A1(_182_),
    .A2(_183_),
    .B1(_144_),
    .X(_007_));
 sky130_fd_sc_hd__a22oi_1 _283_ (.A1(net19),
    .A2(_151_),
    .B1(_160_),
    .B2(_175_),
    .Y(_184_));
 sky130_fd_sc_hd__a21boi_1 _284_ (.A1(_152_),
    .A2(_184_),
    .B1_N(_144_),
    .Y(_008_));
 sky130_fd_sc_hd__a21oi_1 _285_ (.A1(_152_),
    .A2(_155_),
    .B1(_162_),
    .Y(_185_));
 sky130_fd_sc_hd__and2_1 _286_ (.A(net20),
    .B(_152_),
    .X(_186_));
 sky130_fd_sc_hd__o31a_1 _287_ (.A1(net36),
    .A2(_185_),
    .A3(_186_),
    .B1(_144_),
    .X(_009_));
 sky130_fd_sc_hd__xor2_2 _288_ (.A(net117),
    .B(net68),
    .X(_011_));
 sky130_fd_sc_hd__or2_1 _289_ (.A(\u_spi.cmd_err_q ),
    .B(\u_spi.abort_err_q ),
    .X(net21));
 sky130_fd_sc_hd__xor2_1 _290_ (.A(\u_spi.bit_count_q[0] ),
    .B(\u_spi.bit_count_q[1] ),
    .X(_028_));
 sky130_fd_sc_hd__a21oi_1 _291_ (.A1(\u_spi.bit_count_q[0] ),
    .A2(\u_spi.bit_count_q[1] ),
    .B1(\u_spi.bit_count_q[2] ),
    .Y(_187_));
 sky130_fd_sc_hd__and3_1 _292_ (.A(\u_spi.bit_count_q[0] ),
    .B(\u_spi.bit_count_q[1] ),
    .C(\u_spi.bit_count_q[2] ),
    .X(_188_));
 sky130_fd_sc_hd__nor2_1 _293_ (.A(_187_),
    .B(_188_),
    .Y(_029_));
 sky130_fd_sc_hd__nand2_1 _294_ (.A(\u_spi.bit_count_q[3] ),
    .B(_188_),
    .Y(_189_));
 sky130_fd_sc_hd__xor2_1 _295_ (.A(\u_spi.bit_count_q[3] ),
    .B(_188_),
    .X(_030_));
 sky130_fd_sc_hd__xnor2_1 _296_ (.A(\u_spi.bit_count_q[4] ),
    .B(_189_),
    .Y(_031_));
 sky130_fd_sc_hd__mux2_1 _297_ (.A0(net82),
    .A1(net81),
    .S(net41),
    .X(_089_));
 sky130_fd_sc_hd__mux2_1 _298_ (.A0(net101),
    .A1(net94),
    .S(net41),
    .X(_090_));
 sky130_fd_sc_hd__mux2_1 _299_ (.A0(net102),
    .A1(net90),
    .S(net41),
    .X(_091_));
 sky130_fd_sc_hd__mux2_1 _300_ (.A0(net28),
    .A1(net79),
    .S(net41),
    .X(_092_));
 sky130_fd_sc_hd__mux2_1 _301_ (.A0(net29),
    .A1(net92),
    .S(net41),
    .X(_093_));
 sky130_fd_sc_hd__mux2_1 _302_ (.A0(net109),
    .A1(net107),
    .S(net42),
    .X(_094_));
 sky130_fd_sc_hd__mux2_1 _303_ (.A0(net31),
    .A1(net104),
    .S(net42),
    .X(_095_));
 sky130_fd_sc_hd__mux2_1 _304_ (.A0(net86),
    .A1(net84),
    .S(net42),
    .X(_096_));
 sky130_fd_sc_hd__mux2_1 _305_ (.A0(net103),
    .A1(net96),
    .S(net42),
    .X(_097_));
 sky130_fd_sc_hd__mux2_1 _306_ (.A0(net34),
    .A1(net87),
    .S(net41),
    .X(_098_));
 sky130_fd_sc_hd__mux2_1 _307_ (.A0(net22),
    .A1(net115),
    .S(net41),
    .X(_099_));
 sky130_fd_sc_hd__mux2_1 _308_ (.A0(net23),
    .A1(net111),
    .S(net41),
    .X(_100_));
 sky130_fd_sc_hd__mux2_1 _309_ (.A0(net24),
    .A1(net113),
    .S(net41),
    .X(_101_));
 sky130_fd_sc_hd__and3_1 _310_ (.A(\u_spi.start_bit_w ),
    .B(\u_spi.sgl_bit_w ),
    .C(net3),
    .X(_190_));
 sky130_fd_sc_hd__and4_2 _311_ (.A(net47),
    .B(_137_),
    .C(_139_),
    .D(_190_),
    .X(_191_));
 sky130_fd_sc_hd__xor2_1 _312_ (.A(\u_spi.start_toggle_q ),
    .B(_191_),
    .X(_102_));
 sky130_fd_sc_hd__mux2_1 _313_ (.A0(\conv_channel_w[0] ),
    .A1(net71),
    .S(_011_),
    .X(_103_));
 sky130_fd_sc_hd__mux2_1 _314_ (.A0(\conv_channel_w[1] ),
    .A1(net69),
    .S(_011_),
    .X(_104_));
 sky130_fd_sc_hd__mux2_1 _315_ (.A0(\conv_channel_w[2] ),
    .A1(net73),
    .S(_011_),
    .X(_105_));
 sky130_fd_sc_hd__mux2_1 _316_ (.A0(\u_spi.req_channel_q[0] ),
    .A1(\u_spi.ch_addr_w[0] ),
    .S(_191_),
    .X(_106_));
 sky130_fd_sc_hd__mux2_1 _317_ (.A0(\u_spi.req_channel_q[1] ),
    .A1(\u_spi.ch_addr_w[1] ),
    .S(_191_),
    .X(_107_));
 sky130_fd_sc_hd__mux2_1 _318_ (.A0(\u_spi.req_channel_q[2] ),
    .A1(\u_spi.ch_addr_w[2] ),
    .S(_191_),
    .X(_108_));
 sky130_fd_sc_hd__mux2_1 _319_ (.A0(net81),
    .A1(net1),
    .S(net40),
    .X(_109_));
 sky130_fd_sc_hd__mux2_1 _320_ (.A0(net94),
    .A1(net12),
    .S(net40),
    .X(_110_));
 sky130_fd_sc_hd__mux2_1 _321_ (.A0(net90),
    .A1(net13),
    .S(net40),
    .X(_111_));
 sky130_fd_sc_hd__mux2_1 _322_ (.A0(net79),
    .A1(net83),
    .S(net40),
    .X(_112_));
 sky130_fd_sc_hd__mux2_1 _323_ (.A0(net92),
    .A1(net95),
    .S(net40),
    .X(_113_));
 sky130_fd_sc_hd__mux2_1 _324_ (.A0(net107),
    .A1(net16),
    .S(net40),
    .X(_114_));
 sky130_fd_sc_hd__mux2_1 _325_ (.A0(net104),
    .A1(net106),
    .S(_148_),
    .X(_115_));
 sky130_fd_sc_hd__mux2_1 _326_ (.A0(net84),
    .A1(net18),
    .S(net40),
    .X(_116_));
 sky130_fd_sc_hd__mux2_1 _327_ (.A0(net96),
    .A1(net19),
    .S(net40),
    .X(_117_));
 sky130_fd_sc_hd__mux2_1 _328_ (.A0(net87),
    .A1(net89),
    .S(net40),
    .X(_118_));
 sky130_fd_sc_hd__mux2_1 _329_ (.A0(net75),
    .A1(net7),
    .S(net37),
    .X(_120_));
 sky130_fd_sc_hd__mux2_1 _330_ (.A0(net99),
    .A1(net8),
    .S(net37),
    .X(_121_));
 sky130_fd_sc_hd__mux2_1 _331_ (.A0(net77),
    .A1(net9),
    .S(net37),
    .X(_122_));
 sky130_fd_sc_hd__or2_1 _332_ (.A(net98),
    .B(net41),
    .X(_123_));
 sky130_fd_sc_hd__o211a_1 _333_ (.A1(net110),
    .A2(_135_),
    .B1(_141_),
    .C1(_128_),
    .X(_124_));
 sky130_fd_sc_hd__nand2b_1 _334_ (.A_N(net36),
    .B(_167_),
    .Y(_125_));
 sky130_fd_sc_hd__mux2_1 _335_ (.A0(net43),
    .A1(_153_),
    .S(_146_),
    .X(_192_));
 sky130_fd_sc_hd__inv_2 _336_ (.A(_192_),
    .Y(_126_));
 sky130_fd_sc_hd__nand2_1 _337_ (.A(_147_),
    .B(_158_),
    .Y(_127_));
 sky130_fd_sc_hd__and2_1 _338_ (.A(net45),
    .B(net54),
    .X(_084_));
 sky130_fd_sc_hd__and2_1 _339_ (.A(net45),
    .B(net54),
    .X(_082_));
 sky130_fd_sc_hd__and2_1 _340_ (.A(net45),
    .B(net55),
    .X(_080_));
 sky130_fd_sc_hd__and2_1 _341_ (.A(net45),
    .B(net56),
    .X(_078_));
 sky130_fd_sc_hd__and2_1 _342_ (.A(net45),
    .B(net56),
    .X(_076_));
 sky130_fd_sc_hd__and2_1 _343_ (.A(net46),
    .B(net60),
    .X(_074_));
 sky130_fd_sc_hd__and2_1 _344_ (.A(net46),
    .B(net60),
    .X(_072_));
 sky130_fd_sc_hd__and2_1 _345_ (.A(net46),
    .B(net61),
    .X(_070_));
 sky130_fd_sc_hd__and2_1 _346_ (.A(net46),
    .B(net61),
    .X(_068_));
 sky130_fd_sc_hd__and2_1 _347_ (.A(net46),
    .B(net62),
    .X(_066_));
 sky130_fd_sc_hd__and2_1 _348_ (.A(net46),
    .B(net62),
    .X(_064_));
 sky130_fd_sc_hd__and2_1 _349_ (.A(net46),
    .B(net60),
    .X(_062_));
 sky130_fd_sc_hd__and2_1 _350_ (.A(net46),
    .B(net60),
    .X(_060_));
 sky130_fd_sc_hd__and2_1 _351_ (.A(net46),
    .B(net56),
    .X(_058_));
 sky130_fd_sc_hd__buf_1 _352_ (.A(net65),
    .X(_193_));
 sky130_fd_sc_hd__and2_1 _353_ (.A(net47),
    .B(net51),
    .X(_032_));
 sky130_fd_sc_hd__and2_1 _354_ (.A(net47),
    .B(net51),
    .X(_033_));
 sky130_fd_sc_hd__and2_1 _355_ (.A(net47),
    .B(net51),
    .X(_034_));
 sky130_fd_sc_hd__and2_1 _356_ (.A(net47),
    .B(net52),
    .X(_035_));
 sky130_fd_sc_hd__and2_1 _357_ (.A(net47),
    .B(net52),
    .X(_036_));
 sky130_fd_sc_hd__and2_1 _358_ (.A(net45),
    .B(net56),
    .X(_037_));
 sky130_fd_sc_hd__and2_1 _359_ (.A(net45),
    .B(net56),
    .X(_038_));
 sky130_fd_sc_hd__and2_1 _360_ (.A(net45),
    .B(net56),
    .X(_039_));
 sky130_fd_sc_hd__and2_1 _361_ (.A(net47),
    .B(net56),
    .X(_040_));
 sky130_fd_sc_hd__and2_1 _362_ (.A(net45),
    .B(net55),
    .X(_041_));
 sky130_fd_sc_hd__inv_2 _363_ (.A(net66),
    .Y(_043_));
 sky130_fd_sc_hd__inv_2 _364_ (.A(net66),
    .Y(_044_));
 sky130_fd_sc_hd__inv_2 _365_ (.A(net66),
    .Y(_045_));
 sky130_fd_sc_hd__inv_2 _366_ (.A(net66),
    .Y(_046_));
 sky130_fd_sc_hd__inv_2 _367_ (.A(net66),
    .Y(_047_));
 sky130_fd_sc_hd__inv_2 _368_ (.A(net66),
    .Y(_048_));
 sky130_fd_sc_hd__inv_2 _369_ (.A(net66),
    .Y(_049_));
 sky130_fd_sc_hd__inv_2 _370_ (.A(net66),
    .Y(_050_));
 sky130_fd_sc_hd__inv_2 _371_ (.A(net65),
    .Y(_051_));
 sky130_fd_sc_hd__inv_2 _372_ (.A(net65),
    .Y(_052_));
 sky130_fd_sc_hd__inv_2 _373_ (.A(net65),
    .Y(_053_));
 sky130_fd_sc_hd__inv_2 _374_ (.A(net65),
    .Y(_054_));
 sky130_fd_sc_hd__inv_2 _375_ (.A(net65),
    .Y(_055_));
 sky130_fd_sc_hd__inv_2 _376_ (.A(net65),
    .Y(_056_));
 sky130_fd_sc_hd__inv_2 _377_ (.A(net65),
    .Y(_057_));
 sky130_fd_sc_hd__inv_2 _378_ (.A(net49),
    .Y(_061_));
 sky130_fd_sc_hd__inv_2 _379_ (.A(net49),
    .Y(_063_));
 sky130_fd_sc_hd__inv_2 _380_ (.A(net49),
    .Y(_065_));
 sky130_fd_sc_hd__inv_2 _381_ (.A(net49),
    .Y(_067_));
 sky130_fd_sc_hd__inv_2 _382_ (.A(net49),
    .Y(_069_));
 sky130_fd_sc_hd__inv_2 _383_ (.A(net49),
    .Y(_071_));
 sky130_fd_sc_hd__inv_2 _384_ (.A(net5),
    .Y(_073_));
 sky130_fd_sc_hd__inv_2 _385_ (.A(net5),
    .Y(_075_));
 sky130_fd_sc_hd__inv_2 _386_ (.A(net48),
    .Y(_077_));
 sky130_fd_sc_hd__inv_2 _387_ (.A(net48),
    .Y(_079_));
 sky130_fd_sc_hd__inv_2 _388_ (.A(net48),
    .Y(_081_));
 sky130_fd_sc_hd__inv_2 _389_ (.A(net48),
    .Y(_083_));
 sky130_fd_sc_hd__inv_2 _390_ (.A(net48),
    .Y(_085_));
 sky130_fd_sc_hd__inv_2 _391_ (.A(net48),
    .Y(_087_));
 sky130_fd_sc_hd__and2_1 _392_ (.A(net47),
    .B(net54),
    .X(_088_));
 sky130_fd_sc_hd__dfrtp_1 _393_ (.CLK(clknet_2_1__leaf_clk),
    .D(_089_),
    .RESET_B(net52),
    .Q(net25));
 sky130_fd_sc_hd__dfrtp_1 _394_ (.CLK(clknet_2_3__leaf_clk),
    .D(_090_),
    .RESET_B(net60),
    .Q(net26));
 sky130_fd_sc_hd__dfrtp_1 _395_ (.CLK(clknet_2_3__leaf_clk),
    .D(_091_),
    .RESET_B(net61),
    .Q(net27));
 sky130_fd_sc_hd__dfrtp_1 _396_ (.CLK(clknet_2_3__leaf_clk),
    .D(net80),
    .RESET_B(net61),
    .Q(net28));
 sky130_fd_sc_hd__dfrtp_1 _397_ (.CLK(clknet_2_3__leaf_clk),
    .D(net93),
    .RESET_B(net61),
    .Q(net29));
 sky130_fd_sc_hd__dfrtp_1 _398_ (.CLK(clknet_2_3__leaf_clk),
    .D(_094_),
    .RESET_B(net61),
    .Q(net30));
 sky130_fd_sc_hd__dfrtp_1 _399_ (.CLK(clknet_2_2__leaf_clk),
    .D(net105),
    .RESET_B(net58),
    .Q(net31));
 sky130_fd_sc_hd__dfrtp_1 _400_ (.CLK(clknet_2_3__leaf_clk),
    .D(_096_),
    .RESET_B(net60),
    .Q(net32));
 sky130_fd_sc_hd__dfrtp_1 _401_ (.CLK(clknet_2_3__leaf_clk),
    .D(_097_),
    .RESET_B(net60),
    .Q(net33));
 sky130_fd_sc_hd__dfrtp_1 _402_ (.CLK(clknet_2_1__leaf_clk),
    .D(net88),
    .RESET_B(net56),
    .Q(net34));
 sky130_fd_sc_hd__dfrtp_1 _403_ (.CLK(clknet_2_1__leaf_clk),
    .D(net116),
    .RESET_B(net52),
    .Q(net22));
 sky130_fd_sc_hd__dfrtp_1 _404_ (.CLK(clknet_2_1__leaf_clk),
    .D(net112),
    .RESET_B(net54),
    .Q(net23));
 sky130_fd_sc_hd__dfrtp_1 _405_ (.CLK(clknet_2_1__leaf_clk),
    .D(net114),
    .RESET_B(net54),
    .Q(net24));
 sky130_fd_sc_hd__dfrtp_1 _406_ (.CLK(net50),
    .D(net3),
    .RESET_B(_032_),
    .Q(\u_spi.ch_addr_w[0] ));
 sky130_fd_sc_hd__dfrtp_1 _407_ (.CLK(net50),
    .D(\u_spi.ch_addr_w[0] ),
    .RESET_B(_033_),
    .Q(\u_spi.ch_addr_w[1] ));
 sky130_fd_sc_hd__dfrtp_1 _408_ (.CLK(net50),
    .D(\u_spi.ch_addr_w[1] ),
    .RESET_B(_034_),
    .Q(\u_spi.ch_addr_w[2] ));
 sky130_fd_sc_hd__dfrtp_1 _409_ (.CLK(net50),
    .D(\u_spi.ch_addr_w[2] ),
    .RESET_B(_035_),
    .Q(\u_spi.sgl_bit_w ));
 sky130_fd_sc_hd__dfrtp_1 _410_ (.CLK(net50),
    .D(\u_spi.sgl_bit_w ),
    .RESET_B(_036_),
    .Q(\u_spi.start_bit_w ));
 sky130_fd_sc_hd__dfrtp_1 _411_ (.CLK(net50),
    .D(_102_),
    .RESET_B(net52),
    .Q(\u_spi.start_toggle_q ));
 sky130_fd_sc_hd__dfrtp_1 _412_ (.CLK(clknet_2_0__leaf_clk),
    .D(net72),
    .RESET_B(net51),
    .Q(\conv_channel_w[0] ));
 sky130_fd_sc_hd__dfrtp_1 _413_ (.CLK(clknet_2_1__leaf_clk),
    .D(net70),
    .RESET_B(net51),
    .Q(\conv_channel_w[1] ));
 sky130_fd_sc_hd__dfrtp_1 _414_ (.CLK(clknet_2_1__leaf_clk),
    .D(net74),
    .RESET_B(net51),
    .Q(\conv_channel_w[2] ));
 sky130_fd_sc_hd__dfrtp_1 _415_ (.CLK(net50),
    .D(_106_),
    .RESET_B(net51),
    .Q(\u_spi.req_channel_q[0] ));
 sky130_fd_sc_hd__dfrtp_1 _416_ (.CLK(net50),
    .D(_107_),
    .RESET_B(net51),
    .Q(\u_spi.req_channel_q[1] ));
 sky130_fd_sc_hd__dfrtp_1 _417_ (.CLK(net50),
    .D(_108_),
    .RESET_B(net51),
    .Q(\u_spi.req_channel_q[2] ));
 sky130_fd_sc_hd__dfrtp_1 _418_ (.CLK(clknet_2_0__leaf_clk),
    .D(\u_spi.req_channel_q[0] ),
    .RESET_B(net51),
    .Q(\u_spi.channel_sync_q[0] ));
 sky130_fd_sc_hd__dfrtp_1 _419_ (.CLK(clknet_2_0__leaf_clk),
    .D(\u_spi.req_channel_q[1] ),
    .RESET_B(net53),
    .Q(\u_spi.channel_sync_q[1] ));
 sky130_fd_sc_hd__dfrtp_1 _420_ (.CLK(clknet_2_1__leaf_clk),
    .D(\u_spi.req_channel_q[2] ),
    .RESET_B(net53),
    .Q(\u_spi.channel_sync_q[2] ));
 sky130_fd_sc_hd__dfrtp_1 _421_ (.CLK(clknet_2_0__leaf_clk),
    .D(net68),
    .RESET_B(net52),
    .Q(\u_spi.sync_toggle_q3 ));
 sky130_fd_sc_hd__dfrtp_1 _422_ (.CLK(clknet_2_0__leaf_clk),
    .D(net67),
    .RESET_B(net52),
    .Q(\u_spi.sync_toggle_q2 ));
 sky130_fd_sc_hd__dfrtp_1 _423_ (.CLK(net65),
    .D(_010_),
    .RESET_B(net55),
    .Q(\u_spi.abort_err_q ));
 sky130_fd_sc_hd__dfrtp_1 _424_ (.CLK(clknet_2_0__leaf_clk),
    .D(\u_spi.start_toggle_q ),
    .RESET_B(net52),
    .Q(\u_spi.sync_toggle_q1 ));
 sky130_fd_sc_hd__dfrtp_1 _425_ (.CLK(clknet_2_1__leaf_clk),
    .D(_109_),
    .RESET_B(net53),
    .Q(\sar_result_w[0] ));
 sky130_fd_sc_hd__dfrtp_1 _426_ (.CLK(clknet_2_3__leaf_clk),
    .D(_110_),
    .RESET_B(net58),
    .Q(\sar_result_w[1] ));
 sky130_fd_sc_hd__dfrtp_1 _427_ (.CLK(clknet_2_3__leaf_clk),
    .D(net91),
    .RESET_B(net61),
    .Q(\sar_result_w[2] ));
 sky130_fd_sc_hd__dfrtp_1 _428_ (.CLK(clknet_2_3__leaf_clk),
    .D(_112_),
    .RESET_B(net61),
    .Q(\sar_result_w[3] ));
 sky130_fd_sc_hd__dfrtp_1 _429_ (.CLK(clknet_2_3__leaf_clk),
    .D(_113_),
    .RESET_B(net61),
    .Q(\sar_result_w[4] ));
 sky130_fd_sc_hd__dfrtp_1 _430_ (.CLK(clknet_2_3__leaf_clk),
    .D(net108),
    .RESET_B(net58),
    .Q(\sar_result_w[5] ));
 sky130_fd_sc_hd__dfrtp_1 _431_ (.CLK(clknet_2_2__leaf_clk),
    .D(_115_),
    .RESET_B(net58),
    .Q(\sar_result_w[6] ));
 sky130_fd_sc_hd__dfrtp_1 _432_ (.CLK(clknet_2_3__leaf_clk),
    .D(net85),
    .RESET_B(net60),
    .Q(\sar_result_w[7] ));
 sky130_fd_sc_hd__dfrtp_1 _433_ (.CLK(clknet_2_3__leaf_clk),
    .D(net97),
    .RESET_B(net60),
    .Q(\sar_result_w[8] ));
 sky130_fd_sc_hd__dfrtp_1 _434_ (.CLK(clknet_2_1__leaf_clk),
    .D(_118_),
    .RESET_B(net56),
    .Q(\sar_result_w[9] ));
 sky130_fd_sc_hd__dfrtp_1 _435_ (.CLK(net48),
    .D(_027_),
    .RESET_B(_037_),
    .Q(\u_spi.bit_count_q[0] ));
 sky130_fd_sc_hd__dfrtp_1 _436_ (.CLK(net49),
    .D(_028_),
    .RESET_B(_038_),
    .Q(\u_spi.bit_count_q[1] ));
 sky130_fd_sc_hd__dfrtp_1 _437_ (.CLK(net48),
    .D(_029_),
    .RESET_B(_039_),
    .Q(\u_spi.bit_count_q[2] ));
 sky130_fd_sc_hd__dfrtp_1 _438_ (.CLK(net48),
    .D(_030_),
    .RESET_B(_040_),
    .Q(\u_spi.bit_count_q[3] ));
 sky130_fd_sc_hd__dfrtp_1 _439_ (.CLK(net49),
    .D(_031_),
    .RESET_B(_041_),
    .Q(\u_spi.bit_count_q[4] ));
 sky130_fd_sc_hd__dfrtp_1 _440_ (.CLK(clknet_2_0__leaf_clk),
    .D(_011_),
    .RESET_B(net52),
    .Q(conv_start_w));
 sky130_fd_sc_hd__dfrtp_1 _441_ (.CLK(net47),
    .D(net25),
    .RESET_B(net56),
    .Q(\u_spi.tx_snapshot_q[0] ));
 sky130_fd_sc_hd__dfrtp_1 _442_ (.CLK(_043_),
    .D(net26),
    .RESET_B(net63),
    .Q(\u_spi.tx_snapshot_q[1] ));
 sky130_fd_sc_hd__dfrtp_1 _443_ (.CLK(_044_),
    .D(net27),
    .RESET_B(net60),
    .Q(\u_spi.tx_snapshot_q[2] ));
 sky130_fd_sc_hd__dfrtp_1 _444_ (.CLK(_045_),
    .D(net28),
    .RESET_B(net61),
    .Q(\u_spi.tx_snapshot_q[3] ));
 sky130_fd_sc_hd__dfrtp_1 _445_ (.CLK(_046_),
    .D(net29),
    .RESET_B(net62),
    .Q(\u_spi.tx_snapshot_q[4] ));
 sky130_fd_sc_hd__dfrtp_1 _446_ (.CLK(_047_),
    .D(net30),
    .RESET_B(net62),
    .Q(\u_spi.tx_snapshot_q[5] ));
 sky130_fd_sc_hd__dfrtp_1 _447_ (.CLK(_048_),
    .D(net31),
    .RESET_B(net62),
    .Q(\u_spi.tx_snapshot_q[6] ));
 sky130_fd_sc_hd__dfrtp_1 _448_ (.CLK(_049_),
    .D(net32),
    .RESET_B(net63),
    .Q(\u_spi.tx_snapshot_q[7] ));
 sky130_fd_sc_hd__dfrtp_1 _449_ (.CLK(_050_),
    .D(net33),
    .RESET_B(net63),
    .Q(\u_spi.tx_snapshot_q[8] ));
 sky130_fd_sc_hd__dfrtp_1 _450_ (.CLK(_051_),
    .D(net34),
    .RESET_B(net57),
    .Q(\u_spi.tx_snapshot_q[9] ));
 sky130_fd_sc_hd__dfrtp_1 _451_ (.CLK(_052_),
    .D(net22),
    .RESET_B(net57),
    .Q(\u_spi.tx_snapshot_q[10] ));
 sky130_fd_sc_hd__dfrtp_1 _452_ (.CLK(_053_),
    .D(net23),
    .RESET_B(net57),
    .Q(\u_spi.tx_snapshot_q[11] ));
 sky130_fd_sc_hd__dfrtp_1 _453_ (.CLK(_054_),
    .D(net24),
    .RESET_B(net55),
    .Q(\u_spi.tx_snapshot_q[12] ));
 sky130_fd_sc_hd__dfrtp_1 _454_ (.CLK(_055_),
    .D(net21),
    .RESET_B(net55),
    .Q(\u_spi.tx_snapshot_q[13] ));
 sky130_fd_sc_hd__dfrtp_1 _455_ (.CLK(_056_),
    .D(net6),
    .RESET_B(net54),
    .Q(\u_spi.tx_snapshot_q[14] ));
 sky130_fd_sc_hd__dfrtp_1 _456_ (.CLK(_057_),
    .D(net35),
    .RESET_B(net55),
    .Q(\u_spi.tx_snapshot_q[15] ));
 sky130_fd_sc_hd__dfrtp_1 _457_ (.CLK(_059_),
    .D(_018_),
    .RESET_B(_058_),
    .Q(\u_spi.tx_shift_q[1] ));
 sky130_fd_sc_hd__dfrtp_1 _458_ (.CLK(_061_),
    .D(_019_),
    .RESET_B(_060_),
    .Q(\u_spi.tx_shift_q[2] ));
 sky130_fd_sc_hd__dfrtp_1 _459_ (.CLK(_063_),
    .D(_020_),
    .RESET_B(_062_),
    .Q(\u_spi.tx_shift_q[3] ));
 sky130_fd_sc_hd__dfrtp_1 _460_ (.CLK(_065_),
    .D(_021_),
    .RESET_B(_064_),
    .Q(\u_spi.tx_shift_q[4] ));
 sky130_fd_sc_hd__dfrtp_1 _461_ (.CLK(_067_),
    .D(_022_),
    .RESET_B(_066_),
    .Q(\u_spi.tx_shift_q[5] ));
 sky130_fd_sc_hd__dfrtp_1 _462_ (.CLK(_069_),
    .D(_023_),
    .RESET_B(_068_),
    .Q(\u_spi.tx_shift_q[6] ));
 sky130_fd_sc_hd__dfrtp_1 _463_ (.CLK(_071_),
    .D(_024_),
    .RESET_B(_070_),
    .Q(\u_spi.tx_shift_q[7] ));
 sky130_fd_sc_hd__dfrtp_1 _464_ (.CLK(_073_),
    .D(_025_),
    .RESET_B(_072_),
    .Q(\u_spi.tx_shift_q[8] ));
 sky130_fd_sc_hd__dfrtp_1 _465_ (.CLK(_075_),
    .D(_026_),
    .RESET_B(_074_),
    .Q(\u_spi.tx_shift_q[9] ));
 sky130_fd_sc_hd__dfrtp_1 _466_ (.CLK(_077_),
    .D(_012_),
    .RESET_B(_076_),
    .Q(\u_spi.tx_shift_q[10] ));
 sky130_fd_sc_hd__dfrtp_1 _467_ (.CLK(_079_),
    .D(_013_),
    .RESET_B(_078_),
    .Q(\u_spi.tx_shift_q[11] ));
 sky130_fd_sc_hd__dfrtp_1 _468_ (.CLK(_081_),
    .D(_014_),
    .RESET_B(_080_),
    .Q(\u_spi.tx_shift_q[12] ));
 sky130_fd_sc_hd__dfrtp_1 _469_ (.CLK(_083_),
    .D(_015_),
    .RESET_B(_082_),
    .Q(\u_spi.tx_shift_q[13] ));
 sky130_fd_sc_hd__dfrtp_1 _470_ (.CLK(_085_),
    .D(_016_),
    .RESET_B(_084_),
    .Q(\u_spi.tx_shift_q[14] ));
 sky130_fd_sc_hd__dfrtp_1 _471_ (.CLK(_087_),
    .D(_017_),
    .RESET_B(_086_),
    .Q(\u_spi.tx_shift_q[15] ));
 sky130_fd_sc_hd__dfrtp_1 _472_ (.CLK(net48),
    .D(_119_),
    .RESET_B(_088_),
    .Q(\u_spi.cmd_err_q ));
 sky130_fd_sc_hd__dfrtp_1 _473_ (.CLK(clknet_2_0__leaf_clk),
    .D(net76),
    .RESET_B(net53),
    .Q(net7));
 sky130_fd_sc_hd__dfrtp_1 _474_ (.CLK(clknet_2_1__leaf_clk),
    .D(net100),
    .RESET_B(net54),
    .Q(net8));
 sky130_fd_sc_hd__dfrtp_1 _475_ (.CLK(clknet_2_1__leaf_clk),
    .D(net78),
    .RESET_B(net54),
    .Q(net9));
 sky130_fd_sc_hd__dfrtp_1 _476_ (.CLK(clknet_2_0__leaf_clk),
    .D(_000_),
    .RESET_B(net52),
    .Q(net11));
 sky130_fd_sc_hd__dfrtp_1 _477_ (.CLK(clknet_2_1__leaf_clk),
    .D(_001_),
    .RESET_B(net58),
    .Q(net12));
 sky130_fd_sc_hd__dfrtp_1 _478_ (.CLK(clknet_2_2__leaf_clk),
    .D(_002_),
    .RESET_B(net59),
    .Q(net13));
 sky130_fd_sc_hd__dfrtp_1 _479_ (.CLK(clknet_2_2__leaf_clk),
    .D(_003_),
    .RESET_B(net59),
    .Q(net14));
 sky130_fd_sc_hd__dfrtp_1 _480_ (.CLK(clknet_2_3__leaf_clk),
    .D(_004_),
    .RESET_B(net59),
    .Q(net15));
 sky130_fd_sc_hd__dfrtp_1 _481_ (.CLK(clknet_2_2__leaf_clk),
    .D(_005_),
    .RESET_B(net59),
    .Q(net16));
 sky130_fd_sc_hd__dfrtp_1 _482_ (.CLK(clknet_2_2__leaf_clk),
    .D(_006_),
    .RESET_B(net59),
    .Q(net17));
 sky130_fd_sc_hd__dfrtp_1 _483_ (.CLK(clknet_2_2__leaf_clk),
    .D(_007_),
    .RESET_B(net58),
    .Q(net18));
 sky130_fd_sc_hd__dfrtp_1 _484_ (.CLK(clknet_2_2__leaf_clk),
    .D(_008_),
    .RESET_B(net58),
    .Q(net19));
 sky130_fd_sc_hd__dfrtp_1 _485_ (.CLK(clknet_2_0__leaf_clk),
    .D(_009_),
    .RESET_B(net58),
    .Q(net20));
 sky130_fd_sc_hd__dfrtp_1 _486_ (.CLK(clknet_2_1__leaf_clk),
    .D(_123_),
    .RESET_B(net54),
    .Q(net35));
 sky130_fd_sc_hd__dfrtp_1 _487_ (.CLK(clknet_2_1__leaf_clk),
    .D(_124_),
    .RESET_B(net53),
    .Q(\u_sar_core.state_q[0] ));
 sky130_fd_sc_hd__dfrtp_4 _488_ (.CLK(clknet_2_2__leaf_clk),
    .D(_125_),
    .RESET_B(net58),
    .Q(\u_sar_core.state_q[1] ));
 sky130_fd_sc_hd__dfrtp_1 _489_ (.CLK(clknet_2_2__leaf_clk),
    .D(_126_),
    .RESET_B(net58),
    .Q(\u_sar_core.state_q[2] ));
 sky130_fd_sc_hd__dfrtp_4 _490_ (.CLK(clknet_2_2__leaf_clk),
    .D(_127_),
    .RESET_B(net59),
    .Q(\u_sar_core.state_q[3] ));
 sky130_fd_sc_hd__ebufn_8 _491_ (.A(\u_spi.miso_bit ),
    .TE_B(_193_),
    .Z(miso));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Right_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Right_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Right_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Right_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Right_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Right_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Right_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Right_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Right_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Right_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Right_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Right_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_32_Right_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_33_Right_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_34_Right_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_35_Right_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_36_Right_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_45 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_46 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_47 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_48 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_49 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_50 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_51 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_52 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_53 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_54 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_55 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_56 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_57 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_58 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_59 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Left_60 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Left_61 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Left_62 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Left_63 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Left_64 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Left_65 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Left_66 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Left_67 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Left_68 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_32_Left_69 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_33_Left_70 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_34_Left_71 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_35_Left_72 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_36_Left_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_145 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_147 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_149 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_151 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_153 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_155 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_157 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_159 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_161 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_162 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_165 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_166 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_167 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_168 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_169 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_170 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_171 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_172 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_173 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_174 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_175 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_176 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_177 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_178 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_179 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_180 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_181 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_183 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_184 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_185 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_186 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_187 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_188 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_189 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_190 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_191 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_192 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_193 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_194 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_195 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_196 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_197 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_198 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_199 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_200 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_201 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_202 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_203 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_204 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_205 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_206 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_207 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_208 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_209 ();
 sky130_fd_sc_hd__dlymetal6s2s_1 input1 (.A(cmp_out),
    .X(net1));
 sky130_fd_sc_hd__buf_1 input2 (.A(cs_n),
    .X(net2));
 sky130_fd_sc_hd__buf_1 input3 (.A(mosi),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(rst_n),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_2 input5 (.A(sclk),
    .X(net5));
 sky130_fd_sc_hd__buf_2 output6 (.A(net6),
    .X(busy));
 sky130_fd_sc_hd__buf_2 output7 (.A(net7),
    .X(channel_sel[0]));
 sky130_fd_sc_hd__buf_2 output8 (.A(net8),
    .X(channel_sel[1]));
 sky130_fd_sc_hd__buf_2 output9 (.A(net9),
    .X(channel_sel[2]));
 sky130_fd_sc_hd__buf_2 output10 (.A(net42),
    .X(conv_done));
 sky130_fd_sc_hd__buf_2 output11 (.A(net11),
    .X(dac_code[0]));
 sky130_fd_sc_hd__buf_2 output12 (.A(net12),
    .X(dac_code[1]));
 sky130_fd_sc_hd__buf_2 output13 (.A(net13),
    .X(dac_code[2]));
 sky130_fd_sc_hd__buf_2 output14 (.A(net14),
    .X(dac_code[3]));
 sky130_fd_sc_hd__buf_2 output15 (.A(net15),
    .X(dac_code[4]));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .X(dac_code[5]));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .X(dac_code[6]));
 sky130_fd_sc_hd__buf_2 output18 (.A(net18),
    .X(dac_code[7]));
 sky130_fd_sc_hd__buf_2 output19 (.A(net19),
    .X(dac_code[8]));
 sky130_fd_sc_hd__buf_2 output20 (.A(net20),
    .X(dac_code[9]));
 sky130_fd_sc_hd__buf_2 output21 (.A(net21),
    .X(err_flag));
 sky130_fd_sc_hd__buf_2 output22 (.A(net22),
    .X(result_channel[0]));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .X(result_channel[1]));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .X(result_channel[2]));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .X(result_data[0]));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .X(result_data[1]));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .X(result_data[2]));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(result_data[3]));
 sky130_fd_sc_hd__buf_2 output29 (.A(net29),
    .X(result_data[4]));
 sky130_fd_sc_hd__buf_2 output30 (.A(net30),
    .X(result_data[5]));
 sky130_fd_sc_hd__buf_2 output31 (.A(net31),
    .X(result_data[6]));
 sky130_fd_sc_hd__buf_2 output32 (.A(net32),
    .X(result_data[7]));
 sky130_fd_sc_hd__buf_2 output33 (.A(net33),
    .X(result_data[8]));
 sky130_fd_sc_hd__buf_2 output34 (.A(net34),
    .X(result_data[9]));
 sky130_fd_sc_hd__buf_2 output35 (.A(net35),
    .X(result_valid));
 sky130_fd_sc_hd__buf_2 output36 (.A(net36),
    .X(sample_en));
 sky130_fd_sc_hd__buf_2 fanout37 (.A(_144_),
    .X(net37));
 sky130_fd_sc_hd__clkbuf_4 fanout38 (.A(_142_),
    .X(net38));
 sky130_fd_sc_hd__clkbuf_2 fanout39 (.A(_142_),
    .X(net39));
 sky130_fd_sc_hd__clkbuf_4 fanout40 (.A(_148_),
    .X(net40));
 sky130_fd_sc_hd__clkbuf_4 fanout41 (.A(net10),
    .X(net41));
 sky130_fd_sc_hd__clkbuf_2 fanout42 (.A(net10),
    .X(net42));
 sky130_fd_sc_hd__buf_2 fanout43 (.A(\u_sar_core.state_q[2] ),
    .X(net43));
 sky130_fd_sc_hd__buf_2 fanout44 (.A(\u_sar_core.state_q[0] ),
    .X(net44));
 sky130_fd_sc_hd__clkbuf_2 fanout45 (.A(_042_),
    .X(net45));
 sky130_fd_sc_hd__clkbuf_2 fanout46 (.A(net47),
    .X(net46));
 sky130_fd_sc_hd__clkbuf_2 fanout47 (.A(_042_),
    .X(net47));
 sky130_fd_sc_hd__clkbuf_4 fanout48 (.A(net49),
    .X(net48));
 sky130_fd_sc_hd__clkbuf_4 fanout49 (.A(net50),
    .X(net49));
 sky130_fd_sc_hd__buf_2 fanout50 (.A(net5),
    .X(net50));
 sky130_fd_sc_hd__buf_2 fanout51 (.A(net53),
    .X(net51));
 sky130_fd_sc_hd__clkbuf_4 fanout52 (.A(net53),
    .X(net52));
 sky130_fd_sc_hd__buf_2 fanout53 (.A(net64),
    .X(net53));
 sky130_fd_sc_hd__buf_2 fanout54 (.A(net57),
    .X(net54));
 sky130_fd_sc_hd__clkbuf_2 fanout55 (.A(net57),
    .X(net55));
 sky130_fd_sc_hd__buf_2 fanout56 (.A(net57),
    .X(net56));
 sky130_fd_sc_hd__clkbuf_2 fanout57 (.A(net64),
    .X(net57));
 sky130_fd_sc_hd__clkbuf_4 fanout58 (.A(net64),
    .X(net58));
 sky130_fd_sc_hd__clkbuf_2 fanout59 (.A(net64),
    .X(net59));
 sky130_fd_sc_hd__buf_2 fanout60 (.A(net63),
    .X(net60));
 sky130_fd_sc_hd__clkbuf_4 fanout61 (.A(net63),
    .X(net61));
 sky130_fd_sc_hd__dlymetal6s2s_1 fanout62 (.A(net63),
    .X(net62));
 sky130_fd_sc_hd__clkbuf_2 fanout63 (.A(net64),
    .X(net63));
 sky130_fd_sc_hd__clkbuf_2 fanout64 (.A(net4),
    .X(net64));
 sky130_fd_sc_hd__buf_4 fanout65 (.A(net2),
    .X(net65));
 sky130_fd_sc_hd__clkbuf_4 fanout66 (.A(net2),
    .X(net66));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_0__f_clk (.A(clknet_0_clk),
    .X(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_1__f_clk (.A(clknet_0_clk),
    .X(clknet_2_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_2__f_clk (.A(clknet_0_clk),
    .X(clknet_2_2__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_3__f_clk (.A(clknet_0_clk),
    .X(clknet_2_3__leaf_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload0 (.A(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__bufinv_16 clkload1 (.A(clknet_2_2__leaf_clk));
 sky130_fd_sc_hd__dlygate4sd3_1 hold1 (.A(\u_spi.sync_toggle_q1 ),
    .X(net67));
 sky130_fd_sc_hd__dlygate4sd3_1 hold2 (.A(\u_spi.sync_toggle_q2 ),
    .X(net68));
 sky130_fd_sc_hd__dlygate4sd3_1 hold3 (.A(\u_spi.channel_sync_q[1] ),
    .X(net69));
 sky130_fd_sc_hd__dlygate4sd3_1 hold4 (.A(_104_),
    .X(net70));
 sky130_fd_sc_hd__dlygate4sd3_1 hold5 (.A(\u_spi.channel_sync_q[0] ),
    .X(net71));
 sky130_fd_sc_hd__dlygate4sd3_1 hold6 (.A(_103_),
    .X(net72));
 sky130_fd_sc_hd__dlygate4sd3_1 hold7 (.A(\u_spi.channel_sync_q[2] ),
    .X(net73));
 sky130_fd_sc_hd__dlygate4sd3_1 hold8 (.A(_105_),
    .X(net74));
 sky130_fd_sc_hd__dlygate4sd3_1 hold9 (.A(\conv_channel_w[0] ),
    .X(net75));
 sky130_fd_sc_hd__dlygate4sd3_1 hold10 (.A(_120_),
    .X(net76));
 sky130_fd_sc_hd__dlygate4sd3_1 hold11 (.A(\conv_channel_w[2] ),
    .X(net77));
 sky130_fd_sc_hd__dlygate4sd3_1 hold12 (.A(_122_),
    .X(net78));
 sky130_fd_sc_hd__dlygate4sd3_1 hold13 (.A(\sar_result_w[3] ),
    .X(net79));
 sky130_fd_sc_hd__dlygate4sd3_1 hold14 (.A(_092_),
    .X(net80));
 sky130_fd_sc_hd__dlygate4sd3_1 hold15 (.A(\sar_result_w[0] ),
    .X(net81));
 sky130_fd_sc_hd__dlygate4sd3_1 hold16 (.A(net25),
    .X(net82));
 sky130_fd_sc_hd__dlygate4sd3_1 hold17 (.A(net14),
    .X(net83));
 sky130_fd_sc_hd__dlygate4sd3_1 hold18 (.A(\sar_result_w[7] ),
    .X(net84));
 sky130_fd_sc_hd__dlygate4sd3_1 hold19 (.A(_116_),
    .X(net85));
 sky130_fd_sc_hd__dlygate4sd3_1 hold20 (.A(net32),
    .X(net86));
 sky130_fd_sc_hd__dlygate4sd3_1 hold21 (.A(\sar_result_w[9] ),
    .X(net87));
 sky130_fd_sc_hd__dlygate4sd3_1 hold22 (.A(_098_),
    .X(net88));
 sky130_fd_sc_hd__dlygate4sd3_1 hold23 (.A(net20),
    .X(net89));
 sky130_fd_sc_hd__dlygate4sd3_1 hold24 (.A(\sar_result_w[2] ),
    .X(net90));
 sky130_fd_sc_hd__dlygate4sd3_1 hold25 (.A(_111_),
    .X(net91));
 sky130_fd_sc_hd__dlygate4sd3_1 hold26 (.A(\sar_result_w[4] ),
    .X(net92));
 sky130_fd_sc_hd__dlygate4sd3_1 hold27 (.A(_093_),
    .X(net93));
 sky130_fd_sc_hd__dlygate4sd3_1 hold28 (.A(\sar_result_w[1] ),
    .X(net94));
 sky130_fd_sc_hd__dlygate4sd3_1 hold29 (.A(net15),
    .X(net95));
 sky130_fd_sc_hd__dlygate4sd3_1 hold30 (.A(\sar_result_w[8] ),
    .X(net96));
 sky130_fd_sc_hd__dlygate4sd3_1 hold31 (.A(_117_),
    .X(net97));
 sky130_fd_sc_hd__dlygate4sd3_1 hold32 (.A(net35),
    .X(net98));
 sky130_fd_sc_hd__dlygate4sd3_1 hold33 (.A(\conv_channel_w[1] ),
    .X(net99));
 sky130_fd_sc_hd__dlygate4sd3_1 hold34 (.A(_121_),
    .X(net100));
 sky130_fd_sc_hd__dlygate4sd3_1 hold35 (.A(net26),
    .X(net101));
 sky130_fd_sc_hd__dlygate4sd3_1 hold36 (.A(net27),
    .X(net102));
 sky130_fd_sc_hd__dlygate4sd3_1 hold37 (.A(net33),
    .X(net103));
 sky130_fd_sc_hd__dlygate4sd3_1 hold38 (.A(\sar_result_w[6] ),
    .X(net104));
 sky130_fd_sc_hd__dlygate4sd3_1 hold39 (.A(_095_),
    .X(net105));
 sky130_fd_sc_hd__dlygate4sd3_1 hold40 (.A(net17),
    .X(net106));
 sky130_fd_sc_hd__dlygate4sd3_1 hold41 (.A(\sar_result_w[5] ),
    .X(net107));
 sky130_fd_sc_hd__dlygate4sd3_1 hold42 (.A(_114_),
    .X(net108));
 sky130_fd_sc_hd__dlygate4sd3_1 hold43 (.A(net30),
    .X(net109));
 sky130_fd_sc_hd__dlygate4sd3_1 hold44 (.A(conv_start_w),
    .X(net110));
 sky130_fd_sc_hd__dlygate4sd3_1 hold45 (.A(net8),
    .X(net111));
 sky130_fd_sc_hd__dlygate4sd3_1 hold46 (.A(_100_),
    .X(net112));
 sky130_fd_sc_hd__dlygate4sd3_1 hold47 (.A(net9),
    .X(net113));
 sky130_fd_sc_hd__dlygate4sd3_1 hold48 (.A(_101_),
    .X(net114));
 sky130_fd_sc_hd__dlygate4sd3_1 hold49 (.A(net7),
    .X(net115));
 sky130_fd_sc_hd__dlygate4sd3_1 hold50 (.A(_099_),
    .X(net116));
 sky130_fd_sc_hd__dlygate4sd3_1 hold51 (.A(\u_spi.sync_toggle_q3 ),
    .X(net117));
 sky130_ef_sc_hd__decap_12 FILLER_0_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_53 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_65 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_70 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_82 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_119 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_126 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_133 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_141 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_153 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_165 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_175 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_187 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_195 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_15 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_39 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_55 ();
 sky130_fd_sc_hd__decap_6 FILLER_1_66 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_92 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_98 ();
 sky130_fd_sc_hd__decap_6 FILLER_1_113 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_119 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_140 ();
 sky130_fd_sc_hd__decap_8 FILLER_1_147 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_155 ();
 sky130_fd_sc_hd__decap_8 FILLER_1_160 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_190 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_202 ();
 sky130_fd_sc_hd__decap_6 FILLER_1_214 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_27 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_29 ();
 sky130_fd_sc_hd__decap_4 FILLER_2_71 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_75 ();
 sky130_fd_sc_hd__decap_4 FILLER_2_94 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_98 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_119 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_138 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_146 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_2_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_15 ();
 sky130_fd_sc_hd__decap_8 FILLER_3_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_35 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_55 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_65 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_69 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_108 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_113 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_130 ();
 sky130_fd_sc_hd__decap_8 FILLER_3_159 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_167 ();
 sky130_fd_sc_hd__decap_6 FILLER_3_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_178 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_190 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_202 ();
 sky130_fd_sc_hd__decap_6 FILLER_3_214 ();
 sky130_ef_sc_hd__decap_12 FILLER_4_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_4_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_49 ();
 sky130_fd_sc_hd__decap_6 FILLER_4_78 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_89 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_118 ();
 sky130_fd_sc_hd__decap_8 FILLER_4_130 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_138 ();
 sky130_ef_sc_hd__decap_12 FILLER_4_141 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_162 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_166 ();
 sky130_fd_sc_hd__decap_6 FILLER_4_190 ();
 sky130_fd_sc_hd__decap_6 FILLER_4_197 ();
 sky130_ef_sc_hd__decap_12 FILLER_4_208 ();
 sky130_ef_sc_hd__decap_12 FILLER_5_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_5_35 ();
 sky130_fd_sc_hd__decap_8 FILLER_5_47 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_55 ();
 sky130_fd_sc_hd__decap_8 FILLER_5_57 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_65 ();
 sky130_fd_sc_hd__decap_4 FILLER_5_95 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_99 ();
 sky130_fd_sc_hd__decap_4 FILLER_5_108 ();
 sky130_fd_sc_hd__decap_4 FILLER_5_113 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_137 ();
 sky130_fd_sc_hd__decap_4 FILLER_5_141 ();
 sky130_fd_sc_hd__decap_8 FILLER_5_169 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_177 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_218 ();
 sky130_ef_sc_hd__decap_12 FILLER_6_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_6_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_27 ();
 sky130_fd_sc_hd__decap_8 FILLER_6_33 ();
 sky130_ef_sc_hd__decap_12 FILLER_6_61 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_73 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_82 ();
 sky130_fd_sc_hd__decap_6 FILLER_6_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_91 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_100 ();
 sky130_ef_sc_hd__decap_12 FILLER_6_107 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_119 ();
 sky130_fd_sc_hd__decap_8 FILLER_6_129 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_137 ();
 sky130_ef_sc_hd__decap_12 FILLER_6_166 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_181 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_200 ();
 sky130_fd_sc_hd__decap_8 FILLER_6_210 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_218 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_3 ();
 sky130_fd_sc_hd__decap_8 FILLER_7_15 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_23 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_34 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_62 ();
 sky130_fd_sc_hd__decap_6 FILLER_7_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_91 ();
 sky130_fd_sc_hd__decap_8 FILLER_7_113 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_121 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_128 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_140 ();
 sky130_fd_sc_hd__decap_6 FILLER_7_152 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_158 ();
 sky130_fd_sc_hd__decap_6 FILLER_7_162 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_181 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_205 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_41 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_82 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_85 ();
 sky130_fd_sc_hd__decap_6 FILLER_8_97 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_103 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_112 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_138 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_141 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_153 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_180 ();
 sky130_fd_sc_hd__decap_4 FILLER_8_192 ();
 sky130_fd_sc_hd__decap_4 FILLER_8_197 ();
 sky130_ef_sc_hd__decap_12 FILLER_8_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_218 ();
 sky130_fd_sc_hd__decap_8 FILLER_9_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_11 ();
 sky130_ef_sc_hd__decap_12 FILLER_9_21 ();
 sky130_ef_sc_hd__decap_12 FILLER_9_33 ();
 sky130_fd_sc_hd__decap_8 FILLER_9_45 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_53 ();
 sky130_fd_sc_hd__decap_4 FILLER_9_57 ();
 sky130_fd_sc_hd__decap_8 FILLER_9_66 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_74 ();
 sky130_fd_sc_hd__decap_8 FILLER_9_95 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_111 ();
 sky130_ef_sc_hd__decap_12 FILLER_9_121 ();
 sky130_ef_sc_hd__decap_12 FILLER_9_133 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_145 ();
 sky130_ef_sc_hd__decap_12 FILLER_9_154 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_166 ();
 sky130_ef_sc_hd__decap_12 FILLER_9_178 ();
 sky130_fd_sc_hd__decap_6 FILLER_9_213 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_219 ();
 sky130_fd_sc_hd__decap_4 FILLER_10_23 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_10_49 ();
 sky130_ef_sc_hd__decap_12 FILLER_10_61 ();
 sky130_fd_sc_hd__decap_8 FILLER_10_73 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_90 ();
 sky130_ef_sc_hd__decap_12 FILLER_10_120 ();
 sky130_fd_sc_hd__decap_8 FILLER_10_132 ();
 sky130_fd_sc_hd__decap_4 FILLER_10_141 ();
 sky130_fd_sc_hd__decap_6 FILLER_10_148 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_174 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_10_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_217 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_26 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_55 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_82 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_110 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_113 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_125 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_134 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_142 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_148 ();
 sky130_fd_sc_hd__decap_8 FILLER_11_160 ();
 sky130_fd_sc_hd__decap_8 FILLER_11_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_11_180 ();
 sky130_ef_sc_hd__decap_12 FILLER_11_192 ();
 sky130_ef_sc_hd__decap_12 FILLER_11_204 ();
 sky130_ef_sc_hd__decap_12 FILLER_12_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_12_19 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_12_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_41 ();
 sky130_ef_sc_hd__decap_12 FILLER_12_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_12_97 ();
 sky130_fd_sc_hd__decap_4 FILLER_12_109 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_134 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_141 ();
 sky130_fd_sc_hd__decap_4 FILLER_12_146 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_150 ();
 sky130_ef_sc_hd__decap_12 FILLER_12_174 ();
 sky130_fd_sc_hd__decap_6 FILLER_12_186 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_195 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_15 ();
 sky130_fd_sc_hd__decap_8 FILLER_13_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_69 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_84 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_96 ();
 sky130_fd_sc_hd__decap_4 FILLER_13_108 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_113 ();
 sky130_fd_sc_hd__decap_4 FILLER_13_125 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_129 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_155 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_167 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_182 ();
 sky130_ef_sc_hd__decap_12 FILLER_13_208 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_29 ();
 sky130_fd_sc_hd__decap_6 FILLER_14_41 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_70 ();
 sky130_fd_sc_hd__fill_2 FILLER_14_82 ();
 sky130_fd_sc_hd__decap_4 FILLER_14_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_109 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_121 ();
 sky130_fd_sc_hd__decap_6 FILLER_14_133 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_139 ();
 sky130_ef_sc_hd__decap_12 FILLER_14_146 ();
 sky130_fd_sc_hd__decap_8 FILLER_14_185 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_193 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_197 ();
 sky130_fd_sc_hd__decap_6 FILLER_14_209 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_215 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_3 ();
 sky130_fd_sc_hd__decap_8 FILLER_15_15 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_43 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_55 ();
 sky130_fd_sc_hd__decap_6 FILLER_15_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_72 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_141 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_153 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_165 ();
 sky130_fd_sc_hd__decap_6 FILLER_15_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_179 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_191 ();
 sky130_ef_sc_hd__decap_12 FILLER_15_203 ();
 sky130_fd_sc_hd__decap_4 FILLER_15_215 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_219 ();
 sky130_ef_sc_hd__decap_12 FILLER_16_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_16_19 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_51 ();
 sky130_fd_sc_hd__decap_8 FILLER_16_75 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_102 ();
 sky130_fd_sc_hd__decap_6 FILLER_16_123 ();
 sky130_fd_sc_hd__fill_2 FILLER_16_138 ();
 sky130_ef_sc_hd__decap_12 FILLER_16_141 ();
 sky130_ef_sc_hd__decap_12 FILLER_16_153 ();
 sky130_ef_sc_hd__decap_12 FILLER_16_165 ();
 sky130_ef_sc_hd__decap_12 FILLER_16_177 ();
 sky130_fd_sc_hd__decap_6 FILLER_16_189 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_195 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_197 ();
 sky130_ef_sc_hd__decap_12 FILLER_16_203 ();
 sky130_fd_sc_hd__decap_4 FILLER_16_215 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_219 ();
 sky130_ef_sc_hd__decap_12 FILLER_17_7 ();
 sky130_ef_sc_hd__decap_12 FILLER_17_19 ();
 sky130_fd_sc_hd__fill_2 FILLER_17_31 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_39 ();
 sky130_fd_sc_hd__fill_2 FILLER_17_48 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_53 ();
 sky130_fd_sc_hd__decap_6 FILLER_17_69 ();
 sky130_ef_sc_hd__decap_12 FILLER_17_95 ();
 sky130_fd_sc_hd__decap_4 FILLER_17_107 ();
 sky130_fd_sc_hd__fill_1 FILLER_17_111 ();
 sky130_fd_sc_hd__fill_1 FILLER_17_146 ();
 sky130_fd_sc_hd__decap_6 FILLER_17_162 ();
 sky130_fd_sc_hd__decap_4 FILLER_17_169 ();
 sky130_fd_sc_hd__decap_8 FILLER_17_179 ();
 sky130_fd_sc_hd__decap_6 FILLER_17_210 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_18_26 ();
 sky130_fd_sc_hd__decap_6 FILLER_18_51 ();
 sky130_fd_sc_hd__fill_2 FILLER_18_60 ();
 sky130_fd_sc_hd__decap_8 FILLER_18_75 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_83 ();
 sky130_ef_sc_hd__decap_12 FILLER_18_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_97 ();
 sky130_fd_sc_hd__fill_2 FILLER_18_115 ();
 sky130_fd_sc_hd__decap_8 FILLER_18_121 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_137 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_141 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_18_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_18_218 ();
 sky130_fd_sc_hd__decap_8 FILLER_19_7 ();
 sky130_fd_sc_hd__fill_1 FILLER_19_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_39 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_49 ();
 sky130_fd_sc_hd__fill_1 FILLER_19_55 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_64 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_90 ();
 sky130_fd_sc_hd__decap_6 FILLER_19_113 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_128 ();
 sky130_ef_sc_hd__decap_12 FILLER_19_138 ();
 sky130_fd_sc_hd__decap_6 FILLER_19_150 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_165 ();
 sky130_ef_sc_hd__decap_12 FILLER_19_169 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_181 ();
 sky130_ef_sc_hd__decap_12 FILLER_19_207 ();
 sky130_fd_sc_hd__fill_1 FILLER_19_219 ();
 sky130_fd_sc_hd__decap_8 FILLER_20_7 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_15 ();
 sky130_fd_sc_hd__decap_4 FILLER_20_23 ();
 sky130_fd_sc_hd__fill_1 FILLER_20_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_20_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_20_41 ();
 sky130_ef_sc_hd__decap_12 FILLER_20_53 ();
 sky130_fd_sc_hd__decap_4 FILLER_20_65 ();
 sky130_ef_sc_hd__decap_12 FILLER_20_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_20_97 ();
 sky130_fd_sc_hd__decap_8 FILLER_20_109 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_137 ();
 sky130_fd_sc_hd__fill_2 FILLER_20_141 ();
 sky130_fd_sc_hd__decap_6 FILLER_20_175 ();
 sky130_fd_sc_hd__fill_1 FILLER_20_181 ();
 sky130_fd_sc_hd__decap_8 FILLER_20_185 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_20_202 ();
 sky130_fd_sc_hd__fill_2 FILLER_20_214 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_13 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_25 ();
 sky130_fd_sc_hd__decap_6 FILLER_21_37 ();
 sky130_fd_sc_hd__decap_6 FILLER_21_50 ();
 sky130_fd_sc_hd__decap_4 FILLER_21_69 ();
 sky130_fd_sc_hd__fill_1 FILLER_21_73 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_84 ();
 sky130_fd_sc_hd__decap_6 FILLER_21_96 ();
 sky130_fd_sc_hd__fill_1 FILLER_21_102 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_125 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_148 ();
 sky130_fd_sc_hd__decap_8 FILLER_21_160 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_181 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_21_205 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_217 ();
 sky130_fd_sc_hd__decap_4 FILLER_22_23 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_27 ();
 sky130_fd_sc_hd__decap_8 FILLER_22_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_61 ();
 sky130_fd_sc_hd__decap_4 FILLER_22_79 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_83 ();
 sky130_ef_sc_hd__decap_12 FILLER_22_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_97 ();
 sky130_fd_sc_hd__fill_2 FILLER_22_128 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_139 ();
 sky130_fd_sc_hd__decap_8 FILLER_22_149 ();
 sky130_fd_sc_hd__fill_2 FILLER_22_157 ();
 sky130_fd_sc_hd__decap_4 FILLER_22_164 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_168 ();
 sky130_fd_sc_hd__decap_4 FILLER_22_192 ();
 sky130_fd_sc_hd__decap_8 FILLER_22_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_22_214 ();
 sky130_ef_sc_hd__decap_12 FILLER_23_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_23_19 ();
 sky130_fd_sc_hd__fill_1 FILLER_23_27 ();
 sky130_fd_sc_hd__decap_8 FILLER_23_34 ();
 sky130_fd_sc_hd__decap_4 FILLER_23_52 ();
 sky130_fd_sc_hd__decap_4 FILLER_23_70 ();
 sky130_fd_sc_hd__fill_1 FILLER_23_74 ();
 sky130_ef_sc_hd__decap_12 FILLER_23_89 ();
 sky130_fd_sc_hd__fill_2 FILLER_23_101 ();
 sky130_fd_sc_hd__fill_1 FILLER_23_111 ();
 sky130_ef_sc_hd__decap_12 FILLER_23_113 ();
 sky130_fd_sc_hd__decap_8 FILLER_23_125 ();
 sky130_fd_sc_hd__fill_2 FILLER_23_133 ();
 sky130_fd_sc_hd__decap_6 FILLER_23_139 ();
 sky130_ef_sc_hd__decap_12 FILLER_23_169 ();
 sky130_fd_sc_hd__decap_6 FILLER_23_181 ();
 sky130_fd_sc_hd__fill_1 FILLER_23_187 ();
 sky130_fd_sc_hd__decap_8 FILLER_23_211 ();
 sky130_fd_sc_hd__fill_1 FILLER_23_219 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_24_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_41 ();
 sky130_fd_sc_hd__fill_1 FILLER_24_56 ();
 sky130_fd_sc_hd__fill_2 FILLER_24_82 ();
 sky130_fd_sc_hd__decap_8 FILLER_24_98 ();
 sky130_fd_sc_hd__fill_2 FILLER_24_126 ();
 sky130_fd_sc_hd__decap_3 FILLER_24_137 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_141 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_153 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_165 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_177 ();
 sky130_fd_sc_hd__decap_6 FILLER_24_189 ();
 sky130_fd_sc_hd__fill_1 FILLER_24_195 ();
 sky130_fd_sc_hd__decap_3 FILLER_24_197 ();
 sky130_ef_sc_hd__decap_12 FILLER_24_205 ();
 sky130_fd_sc_hd__decap_3 FILLER_24_217 ();
 sky130_fd_sc_hd__decap_8 FILLER_25_3 ();
 sky130_fd_sc_hd__decap_6 FILLER_25_31 ();
 sky130_fd_sc_hd__decap_8 FILLER_25_44 ();
 sky130_fd_sc_hd__fill_1 FILLER_25_52 ();
 sky130_fd_sc_hd__decap_4 FILLER_25_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_25_61 ();
 sky130_fd_sc_hd__decap_4 FILLER_25_86 ();
 sky130_fd_sc_hd__fill_2 FILLER_25_110 ();
 sky130_fd_sc_hd__decap_3 FILLER_25_122 ();
 sky130_fd_sc_hd__fill_2 FILLER_25_156 ();
 sky130_fd_sc_hd__fill_1 FILLER_25_167 ();
 sky130_fd_sc_hd__decap_8 FILLER_25_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_25_214 ();
 sky130_ef_sc_hd__decap_12 FILLER_26_3 ();
 sky130_fd_sc_hd__decap_4 FILLER_26_15 ();
 sky130_fd_sc_hd__decap_6 FILLER_26_22 ();
 sky130_fd_sc_hd__fill_2 FILLER_26_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_26_54 ();
 sky130_fd_sc_hd__decap_4 FILLER_26_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_26_75 ();
 sky130_fd_sc_hd__decap_4 FILLER_26_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_26_89 ();
 sky130_fd_sc_hd__fill_1 FILLER_26_110 ();
 sky130_fd_sc_hd__decap_3 FILLER_26_119 ();
 sky130_fd_sc_hd__decap_6 FILLER_26_130 ();
 sky130_fd_sc_hd__fill_1 FILLER_26_136 ();
 sky130_ef_sc_hd__decap_12 FILLER_26_181 ();
 sky130_fd_sc_hd__decap_3 FILLER_26_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_26_202 ();
 sky130_fd_sc_hd__decap_6 FILLER_26_214 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_3 ();
 sky130_fd_sc_hd__decap_4 FILLER_27_15 ();
 sky130_fd_sc_hd__decap_8 FILLER_27_47 ();
 sky130_fd_sc_hd__fill_1 FILLER_27_55 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_57 ();
 sky130_fd_sc_hd__decap_4 FILLER_27_69 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_78 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_90 ();
 sky130_fd_sc_hd__decap_8 FILLER_27_102 ();
 sky130_fd_sc_hd__fill_2 FILLER_27_110 ();
 sky130_fd_sc_hd__decap_6 FILLER_27_113 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_132 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_144 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_156 ();
 sky130_ef_sc_hd__decap_12 FILLER_27_169 ();
 sky130_fd_sc_hd__decap_4 FILLER_27_181 ();
 sky130_fd_sc_hd__fill_1 FILLER_27_185 ();
 sky130_fd_sc_hd__decap_8 FILLER_27_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_27_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_28_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_28_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_28_27 ();
 sky130_fd_sc_hd__decap_6 FILLER_28_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_28_35 ();
 sky130_ef_sc_hd__decap_12 FILLER_28_39 ();
 sky130_fd_sc_hd__decap_6 FILLER_28_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_28_57 ();
 sky130_fd_sc_hd__decap_6 FILLER_28_69 ();
 sky130_ef_sc_hd__decap_12 FILLER_28_91 ();
 sky130_fd_sc_hd__decap_4 FILLER_28_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_28_107 ();
 sky130_fd_sc_hd__decap_3 FILLER_28_117 ();
 sky130_fd_sc_hd__decap_8 FILLER_28_149 ();
 sky130_fd_sc_hd__fill_2 FILLER_28_157 ();
 sky130_fd_sc_hd__decap_8 FILLER_28_164 ();
 sky130_fd_sc_hd__decap_3 FILLER_28_172 ();
 sky130_ef_sc_hd__decap_12 FILLER_28_180 ();
 sky130_fd_sc_hd__decap_4 FILLER_28_192 ();
 sky130_ef_sc_hd__decap_12 FILLER_28_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_28_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_28_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_29_7 ();
 sky130_ef_sc_hd__decap_12 FILLER_29_19 ();
 sky130_fd_sc_hd__decap_4 FILLER_29_31 ();
 sky130_fd_sc_hd__fill_1 FILLER_29_35 ();
 sky130_fd_sc_hd__fill_2 FILLER_29_42 ();
 sky130_fd_sc_hd__fill_1 FILLER_29_50 ();
 sky130_fd_sc_hd__fill_2 FILLER_29_54 ();
 sky130_fd_sc_hd__decap_6 FILLER_29_72 ();
 sky130_fd_sc_hd__fill_1 FILLER_29_86 ();
 sky130_fd_sc_hd__decap_4 FILLER_29_107 ();
 sky130_fd_sc_hd__fill_1 FILLER_29_111 ();
 sky130_fd_sc_hd__decap_6 FILLER_29_141 ();
 sky130_fd_sc_hd__fill_1 FILLER_29_147 ();
 sky130_fd_sc_hd__fill_2 FILLER_29_166 ();
 sky130_ef_sc_hd__decap_12 FILLER_29_192 ();
 sky130_ef_sc_hd__decap_12 FILLER_29_204 ();
 sky130_fd_sc_hd__decap_4 FILLER_29_216 ();
 sky130_ef_sc_hd__decap_12 FILLER_30_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_30_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_27 ();
 sky130_fd_sc_hd__fill_2 FILLER_30_55 ();
 sky130_fd_sc_hd__decap_8 FILLER_30_68 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_76 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_83 ();
 sky130_fd_sc_hd__decap_4 FILLER_30_85 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_89 ();
 sky130_ef_sc_hd__decap_12 FILLER_30_93 ();
 sky130_ef_sc_hd__decap_12 FILLER_30_105 ();
 sky130_fd_sc_hd__decap_4 FILLER_30_117 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_121 ();
 sky130_fd_sc_hd__decap_6 FILLER_30_130 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_136 ();
 sky130_fd_sc_hd__fill_1 FILLER_30_181 ();
 sky130_ef_sc_hd__decap_12 FILLER_30_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_30_218 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_15 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_31_39 ();
 sky130_fd_sc_hd__decap_8 FILLER_31_48 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_57 ();
 sky130_fd_sc_hd__decap_8 FILLER_31_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_31_77 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_100 ();
 sky130_fd_sc_hd__fill_1 FILLER_31_122 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_140 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_152 ();
 sky130_fd_sc_hd__fill_1 FILLER_31_164 ();
 sky130_fd_sc_hd__decap_4 FILLER_31_178 ();
 sky130_fd_sc_hd__fill_1 FILLER_31_182 ();
 sky130_ef_sc_hd__decap_12 FILLER_31_203 ();
 sky130_fd_sc_hd__decap_4 FILLER_31_215 ();
 sky130_fd_sc_hd__fill_1 FILLER_31_219 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_32_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_41 ();
 sky130_fd_sc_hd__decap_6 FILLER_32_53 ();
 sky130_fd_sc_hd__decap_4 FILLER_32_79 ();
 sky130_fd_sc_hd__fill_1 FILLER_32_83 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_32_97 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_149 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_161 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_173 ();
 sky130_fd_sc_hd__decap_8 FILLER_32_185 ();
 sky130_fd_sc_hd__decap_3 FILLER_32_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_32_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_32_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_32_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_15 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_39 ();
 sky130_fd_sc_hd__decap_4 FILLER_33_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_33_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_33_65 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_74 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_86 ();
 sky130_fd_sc_hd__decap_6 FILLER_33_98 ();
 sky130_fd_sc_hd__decap_6 FILLER_33_121 ();
 sky130_fd_sc_hd__decap_4 FILLER_33_147 ();
 sky130_fd_sc_hd__decap_8 FILLER_33_154 ();
 sky130_fd_sc_hd__decap_3 FILLER_33_165 ();
 sky130_fd_sc_hd__decap_4 FILLER_33_169 ();
 sky130_fd_sc_hd__fill_1 FILLER_33_173 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_194 ();
 sky130_ef_sc_hd__decap_12 FILLER_33_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_33_218 ();
 sky130_ef_sc_hd__decap_12 FILLER_34_6 ();
 sky130_fd_sc_hd__decap_8 FILLER_34_18 ();
 sky130_fd_sc_hd__fill_2 FILLER_34_26 ();
 sky130_ef_sc_hd__decap_12 FILLER_34_29 ();
 sky130_fd_sc_hd__decap_4 FILLER_34_41 ();
 sky130_fd_sc_hd__decap_4 FILLER_34_80 ();
 sky130_fd_sc_hd__decap_8 FILLER_34_94 ();
 sky130_fd_sc_hd__fill_1 FILLER_34_139 ();
 sky130_fd_sc_hd__fill_1 FILLER_34_150 ();
 sky130_fd_sc_hd__decap_4 FILLER_34_191 ();
 sky130_fd_sc_hd__fill_1 FILLER_34_195 ();
 sky130_ef_sc_hd__decap_12 FILLER_34_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_34_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_34_217 ();
 sky130_ef_sc_hd__decap_12 FILLER_35_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_35_15 ();
 sky130_fd_sc_hd__decap_8 FILLER_35_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_35_35 ();
 sky130_fd_sc_hd__decap_4 FILLER_35_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_35_61 ();
 sky130_fd_sc_hd__fill_2 FILLER_35_110 ();
 sky130_fd_sc_hd__decap_3 FILLER_35_122 ();
 sky130_fd_sc_hd__fill_1 FILLER_35_161 ();
 sky130_ef_sc_hd__decap_12 FILLER_35_182 ();
 sky130_ef_sc_hd__decap_12 FILLER_35_194 ();
 sky130_ef_sc_hd__decap_12 FILLER_35_206 ();
 sky130_fd_sc_hd__fill_2 FILLER_35_218 ();
 sky130_ef_sc_hd__decap_12 FILLER_36_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_36_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_36_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_36_29 ();
 sky130_fd_sc_hd__decap_4 FILLER_36_41 ();
 sky130_fd_sc_hd__decap_6 FILLER_36_49 ();
 sky130_fd_sc_hd__fill_1 FILLER_36_55 ();
 sky130_fd_sc_hd__fill_2 FILLER_36_66 ();
 sky130_fd_sc_hd__fill_1 FILLER_36_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_98 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_105 ();
 sky130_fd_sc_hd__decap_4 FILLER_36_113 ();
 sky130_fd_sc_hd__fill_1 FILLER_36_121 ();
 sky130_fd_sc_hd__fill_2 FILLER_36_141 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_147 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_154 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_161 ();
 sky130_fd_sc_hd__fill_1 FILLER_36_167 ();
 sky130_ef_sc_hd__decap_12 FILLER_36_169 ();
 sky130_ef_sc_hd__decap_12 FILLER_36_181 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_193 ();
 sky130_ef_sc_hd__decap_12 FILLER_36_197 ();
 sky130_fd_sc_hd__decap_8 FILLER_36_209 ();
 sky130_fd_sc_hd__decap_3 FILLER_36_217 ();
endmodule
