//+------------------------------------------------------------------+
//|                       VerysVeryInc.MetaTrader4.VsVEA_Library.mqh |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MQH.VsVEA.Library - Ver.0.2.1 Update:2017.02.15"
#property strict

//--- Includes (Ver.0.2.0) ---//
#include <stderror.mqh>
#include <stdlib.mqh>
#include <VsVEA_Signal.mqh>


//--- Define Value (Ver.0.0.2) ---//
#define VSV_OPENPOS		6

//--- Extern (Ver.0.1.1) ---//
// (Ver.0.0.3)
extern int VsVOrderWaitingTime=10;
// (Ver.0.0.8)
extern double DecreaseFactor=3;
// (Ver.0.1.0)
// extern int RSIPeriod=14;
// (Ver.0.1.11)
extern int Slippage=3;


//--- Imports (Ver.0.0.1) ---//
#import "VsVEA_Library.ex4"

//*** VsV.Order ***//
//+------------------------------------------------------------------+
//| VsVCurrentOrders Function : +Buy,-Sell (Ver.0.0.1)               |
//+------------------------------------------------------------------+
double VsVCurrentOrders(int type, int magic);


//+------------------------------------------------------------------+
//| VsVOrderSend Function : (Ver.0.0.3)                              |
//+------------------------------------------------------------------+
bool VsVOrderSend(int type, double lots, double price, int slippage,
				  double sl, double tp, string comment, int magic);


//+------------------------------------------------------------------+
//| VsVOrderClose Function : (Ver.0.0.4)                             |
//+------------------------------------------------------------------+
double VsVOrderClose(int slippage, int magic);


//+------------------------------------------------------------------+
//| VsVOrderModify Function : Open Position Only (Ver.0.0.6)         |
//+------------------------------------------------------------------+
bool VsVOrderModify(double sl, double tp, int magic);

//*** VsV.Order End ***//


//*** VsV.Calculate ***//
//+------------------------------------------------------------------+
//| Calculate open positions (Ver.0.0.7)                             |
//+------------------------------------------------------------------+
int CalculateCurrentOrders(string Symbol, int magic);


//+------------------------------------------------------------------+
//| Calculate optimal lot size (Ver.0.0.8)                           |
//+------------------------------------------------------------------+
double LotsOptimized();

#import

//+------------------------------------------------------------------+