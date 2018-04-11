// lab2_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 15.0 145

`timescale 1 ps / 1 ps
module lab2_mm_interconnect_0 (
		input  wire        altpll_0_c0_clk,                                        //                                      altpll_0_c0.clk
		input  wire        Rsa256Wrapper_0_reset_sink_reset_bridge_in_reset_reset, // Rsa256Wrapper_0_reset_sink_reset_bridge_in_reset.reset
		input  wire [4:0]  Rsa256Wrapper_0_avalon_master_0_address,                //                  Rsa256Wrapper_0_avalon_master_0.address
		output wire        Rsa256Wrapper_0_avalon_master_0_waitrequest,            //                                                 .waitrequest
		input  wire        Rsa256Wrapper_0_avalon_master_0_read,                   //                                                 .read
		output wire [31:0] Rsa256Wrapper_0_avalon_master_0_readdata,               //                                                 .readdata
		input  wire        Rsa256Wrapper_0_avalon_master_0_write,                  //                                                 .write
		input  wire [31:0] Rsa256Wrapper_0_avalon_master_0_writedata,              //                                                 .writedata
		output wire [0:0]  rs232_0_avalon_rs232_slave_address,                     //                       rs232_0_avalon_rs232_slave.address
		output wire        rs232_0_avalon_rs232_slave_write,                       //                                                 .write
		output wire        rs232_0_avalon_rs232_slave_read,                        //                                                 .read
		input  wire [31:0] rs232_0_avalon_rs232_slave_readdata,                    //                                                 .readdata
		output wire [31:0] rs232_0_avalon_rs232_slave_writedata,                   //                                                 .writedata
		output wire [3:0]  rs232_0_avalon_rs232_slave_byteenable,                  //                                                 .byteenable
		output wire        rs232_0_avalon_rs232_slave_chipselect                   //                                                 .chipselect
	);

	wire         rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_waitrequest;   // rs232_0_avalon_rs232_slave_translator:uav_waitrequest -> Rsa256Wrapper_0_avalon_master_0_translator:uav_waitrequest
	wire  [31:0] rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_readdata;      // rs232_0_avalon_rs232_slave_translator:uav_readdata -> Rsa256Wrapper_0_avalon_master_0_translator:uav_readdata
	wire         rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_debugaccess;   // Rsa256Wrapper_0_avalon_master_0_translator:uav_debugaccess -> rs232_0_avalon_rs232_slave_translator:uav_debugaccess
	wire   [4:0] rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_address;       // Rsa256Wrapper_0_avalon_master_0_translator:uav_address -> rs232_0_avalon_rs232_slave_translator:uav_address
	wire         rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_read;          // Rsa256Wrapper_0_avalon_master_0_translator:uav_read -> rs232_0_avalon_rs232_slave_translator:uav_read
	wire   [3:0] rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_byteenable;    // Rsa256Wrapper_0_avalon_master_0_translator:uav_byteenable -> rs232_0_avalon_rs232_slave_translator:uav_byteenable
	wire         rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_readdatavalid; // rs232_0_avalon_rs232_slave_translator:uav_readdatavalid -> Rsa256Wrapper_0_avalon_master_0_translator:uav_readdatavalid
	wire         rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_lock;          // Rsa256Wrapper_0_avalon_master_0_translator:uav_lock -> rs232_0_avalon_rs232_slave_translator:uav_lock
	wire         rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_write;         // Rsa256Wrapper_0_avalon_master_0_translator:uav_write -> rs232_0_avalon_rs232_slave_translator:uav_write
	wire  [31:0] rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_writedata;     // Rsa256Wrapper_0_avalon_master_0_translator:uav_writedata -> rs232_0_avalon_rs232_slave_translator:uav_writedata
	wire   [2:0] rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_burstcount;    // Rsa256Wrapper_0_avalon_master_0_translator:uav_burstcount -> rs232_0_avalon_rs232_slave_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (5),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (5),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) rsa256wrapper_0_avalon_master_0_translator (
		.clk                    (altpll_0_c0_clk),                                                                    //                       clk.clk
		.reset                  (Rsa256Wrapper_0_reset_sink_reset_bridge_in_reset_reset),                             //                     reset.reset
		.uav_address            (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (Rsa256Wrapper_0_avalon_master_0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (Rsa256Wrapper_0_avalon_master_0_waitrequest),                                        //                          .waitrequest
		.av_read                (Rsa256Wrapper_0_avalon_master_0_read),                                               //                          .read
		.av_readdata            (Rsa256Wrapper_0_avalon_master_0_readdata),                                           //                          .readdata
		.av_write               (Rsa256Wrapper_0_avalon_master_0_write),                                              //                          .write
		.av_writedata           (Rsa256Wrapper_0_avalon_master_0_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                                               //               (terminated)
		.av_byteenable          (4'b1111),                                                                            //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                                               //               (terminated)
		.av_begintransfer       (1'b0),                                                                               //               (terminated)
		.av_chipselect          (1'b0),                                                                               //               (terminated)
		.av_readdatavalid       (),                                                                                   //               (terminated)
		.av_lock                (1'b0),                                                                               //               (terminated)
		.av_debugaccess         (1'b0),                                                                               //               (terminated)
		.uav_clken              (),                                                                                   //               (terminated)
		.av_clken               (1'b1),                                                                               //               (terminated)
		.uav_response           (2'b00),                                                                              //               (terminated)
		.av_response            (),                                                                                   //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                               //               (terminated)
		.av_writeresponsevalid  ()                                                                                    //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (1),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (5),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) rs232_0_avalon_rs232_slave_translator (
		.clk                    (altpll_0_c0_clk),                                                                    //                      clk.clk
		.reset                  (Rsa256Wrapper_0_reset_sink_reset_bridge_in_reset_reset),                             //                    reset.reset
		.uav_address            (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (rsa256wrapper_0_avalon_master_0_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (rs232_0_avalon_rs232_slave_address),                                                 //      avalon_anti_slave_0.address
		.av_write               (rs232_0_avalon_rs232_slave_write),                                                   //                         .write
		.av_read                (rs232_0_avalon_rs232_slave_read),                                                    //                         .read
		.av_readdata            (rs232_0_avalon_rs232_slave_readdata),                                                //                         .readdata
		.av_writedata           (rs232_0_avalon_rs232_slave_writedata),                                               //                         .writedata
		.av_byteenable          (rs232_0_avalon_rs232_slave_byteenable),                                              //                         .byteenable
		.av_chipselect          (rs232_0_avalon_rs232_slave_chipselect),                                              //                         .chipselect
		.av_begintransfer       (),                                                                                   //              (terminated)
		.av_beginbursttransfer  (),                                                                                   //              (terminated)
		.av_burstcount          (),                                                                                   //              (terminated)
		.av_readdatavalid       (1'b0),                                                                               //              (terminated)
		.av_waitrequest         (1'b0),                                                                               //              (terminated)
		.av_writebyteenable     (),                                                                                   //              (terminated)
		.av_lock                (),                                                                                   //              (terminated)
		.av_clken               (),                                                                                   //              (terminated)
		.uav_clken              (1'b0),                                                                               //              (terminated)
		.av_debugaccess         (),                                                                                   //              (terminated)
		.av_outputenable        (),                                                                                   //              (terminated)
		.uav_response           (),                                                                                   //              (terminated)
		.av_response            (2'b00),                                                                              //              (terminated)
		.uav_writeresponsevalid (),                                                                                   //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                                //              (terminated)
	);

endmodule