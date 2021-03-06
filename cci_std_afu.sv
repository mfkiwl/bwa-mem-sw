// ***************************************************************************
//
//        Copyright (C) 2008-2014 Intel Corporation All Rights Reserved.
//
//
// Engineer:            Arthur.Sheiman@Intel.com
// Create Date:         02-17-10 02:28
// Edited by:           Pratik.m.marolia@intel.com
// Edit Date:           10/09/2014
// Module Name:         cci_std_afu
// Project:             QLP2 with CCI-S interface
// Description:         This module presents the CCI STANDARD port interface. Instantiate
//                      the user AFU in this module. For more information on CCI interface
//                      refer to "CCI Specification.pdf"
//
// ***************************************************************************
// CAUTION: sharath.jayaprakash@intel.com
// Interrupts and Umsgs are NOT supported as a part of system release 3.3. We 
// do expect to support these features in the future. These ports are 
// currently defined as placeholders. 
// When writing a wrapper for your AFU you need to define these ports for 
// compilation purposes.
// ***************************************************************************

module cci_std_afu(
  // Link/Protocol (LP) clocks and reset
  input  /*var*/  logic             vl_clk_LPdomain_32ui,                      // CCI Inteface Clock. 32ui link/protocol clock domain.
  input  /*var*/  logic             vl_clk_LPdomain_16ui,                      // 2x CCI interface clock. Synchronous.16ui link/protocol clock domain.
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_SystemReset_n,         // System Reset
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_SoftReset_n,           // CCI-S soft reset

  // Native CCI Interface (cache line interface for back end)
  /* Channel 0 can receive READ, WRITE, WRITE CSR responses.*/
  input  /*var*/  logic      [17:0] ffs_vl18_LP32ui_lp2sy_C0RxHdr,             // System to LP header
  input  /*var*/  logic     [511:0] ffs_vl512_LP32ui_lp2sy_C0RxData,           // System to LP data 
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxWrValid,           // RxWrHdr valid signal 
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxRdValid,           // RxRdHdr valid signal
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxCgValid,           // RxCgHdr valid signal
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxUgValid,           // Rx Umsg Valid signal
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxIrValid,           // Rx Interrupt valid signal
  /* Channel 1 reserved for WRITE RESPONSE ONLY */
  input  /*var*/  logic      [17:0] ffs_vl18_LP32ui_lp2sy_C1RxHdr,             // System to LP header (Channel 1)
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C1RxWrValid,           // RxData valid signal (Channel 1)
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C1RxIrValid,           // Rx Interrupt valid signal (Channel 1)

  /*Channel 0 reserved for READ REQUESTS ONLY */        
  output /*var*/  logic      [60:0] ffs_vl61_LP32ui_sy2lp_C0TxHdr,             // System to LP header 
  output /*var*/  logic             ffs_vl_LP32ui_sy2lp_C0TxRdValid,           // TxRdHdr valid signals 
  /*Channel 1 reserved for WRITE REQUESTS ONLY */       
  output /*var*/  logic      [60:0] ffs_vl61_LP32ui_sy2lp_C1TxHdr,             // System to LP header
  output /*var*/  logic     [511:0] ffs_vl512_LP32ui_sy2lp_C1TxData,           // System to LP data 
  output /*var*/  logic             ffs_vl_LP32ui_sy2lp_C1TxWrValid,           // TxWrHdr valid signal
  output /*var*/  logic             ffs_vl_LP32ui_sy2lp_C1TxIrValid,           // Tx Interrupt valid signal
  /* Tx push flow control */
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0TxAlmFull,           // Channel 0 almost full
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C1TxAlmFull,           // Channel 1 almost full

  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_InitDnForSys           // System layer is aok to run
);

/* User AFU goes here
*/

// BWA-MEM Smith-Waterman AFU Instantiation
bwa_mem_sw bwa_mem_sw(
  .clk	                              (vl_clk_LPdomain_32ui),
  .reset_n                            (ffs_vl_LP32ui_lp2sy_SoftReset_n),

  .rb2cf_C0RxHdr                      (ffs_vl18_LP32ui_lp2sy_C0RxHdr),
  .rb2cf_C0RxData                     (ffs_vl512_LP32ui_lp2sy_C0RxData),
  .rb2cf_C0RxWrValid                  (ffs_vl_LP32ui_lp2sy_C0RxWrValid),
  .rb2cf_C0RxRdValid                  (ffs_vl_LP32ui_lp2sy_C0RxRdValid),
  .rb2cf_C0RxCfgValid                 (ffs_vl_LP32ui_lp2sy_C0RxCgValid),
  .rb2cf_C0RxUMsgValid                (ffs_vl_LP32ui_lp2sy_C0RxUgValid),
  .rb2cf_C0RxIntrValid                (ffs_vl_LP32ui_lp2sy_C0RxIrValid),
  .rb2cf_C1RxHdr                      (ffs_vl18_LP32ui_lp2sy_C1RxHdr),
  .rb2cf_C1RxWrValid                  (ffs_vl_LP32ui_lp2sy_C1RxWrValid),
  .rb2cf_C1RxIntrValid                (ffs_vl_LP32ui_lp2sy_C1RxIrValid),

  .cf2ci_C0TxHdr                      (ffs_vl61_LP32ui_sy2lp_C0TxHdr),
  .cf2ci_C0TxRdValid                  (ffs_vl_LP32ui_sy2lp_C0TxRdValid),
  .cf2ci_C1TxHdr                      (ffs_vl61_LP32ui_sy2lp_C1TxHdr),
  .cf2ci_C1TxData                     (ffs_vl512_LP32ui_sy2lp_C1TxData),
  .cf2ci_C1TxWrValid                  (ffs_vl_LP32ui_sy2lp_C1TxWrValid),
  .cf2ci_C1TxIntrValid                (ffs_vl_LP32ui_sy2lp_C1TxIrValid),
  .ci2cf_C0TxAlmFull                  (ffs_vl_LP32ui_lp2sy_C0TxAlmFull),
  .ci2cf_C1TxAlmFull                  (ffs_vl_LP32ui_lp2sy_C1TxAlmFull),

  .ci2cf_InitDn                      (ffs_vl_LP32ui_lp2sy_InitDnForSys)
);

endmodule
