//+------------------------------------------------------------------+
//|              VerysVeryInc.MetaTrader4.VsVEA_USDJPY_EntryExit.mqh |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MQH.VsVEA.USDJPY.EnEx - Ver.0.11.7.1 Update:2018.01.13"
#property strict

//--- Includes (Ver.0.2.0) ---//
#include <stderror.mqh>
#include <stdlib.mqh>
// (Ver.0.2.0)
#include <VsVEA_UJ_Lib.mqh>


//--- Imports (Ver.0.11.6.0) ---//
#import "VsVEA_UJ_EnEx.ex4"


//*** VsV.Entry.Exit ***//
//+------------------------------------------------------------------+
//|  NewTL Entry Signal for Open Order (Ver.0.11.6.1)                |
//+------------------------------------------------------------------+
int NewTL_EntrySignal(int magic);


//+------------------------------------------------------------------+
//|  NewTL Exit Signal for Open Order (Ver.0.11.6.1)->(Ver.0.11.6.5) |
//+------------------------------------------------------------------+
int NewTL_ExitSignal(double NewTL00, int magic);
// (Ver.0.11.6.4.OK) int NewTL_ExitSignal(int magic);


//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order (Ver.0.11.6.2)               |
//+------------------------------------------------------------------+
int USDJPY_EntrySignal(int magic);


//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order (Ver.0.11.6.2)               |
//+------------------------------------------------------------------+
int USDJPY_ExitSignal(int magic);


#import

//+------------------------------------------------------------------+