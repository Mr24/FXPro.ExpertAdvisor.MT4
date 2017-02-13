//+------------------------------------------------------------------+
//|                       VerysVeryInc.MetaTrader4.VsVEA_Library.mgh |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MGH.VsVEA.Library - Ver.0.0.2 Update:2017.02.13"
#property strict

//--- Includes ---//
#include <stderror.mqh>
#include <stdlib.mqh>


//--- Define Value (Ver.0.0.2) ---//
#define VSV_OPENPOS		6


//--- Imports ---//
#import "VsVEA_Library.ex4"


//+------------------------------------------------------------------+
//| VsVCurrentOrders Function : +Buy,-Sell (Ver.0.0.1)               |
//+------------------------------------------------------------------+
double VsVCurrentOrders(int type, int magic);

#import

//+------------------------------------------------------------------+