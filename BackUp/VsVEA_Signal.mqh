//+------------------------------------------------------------------+
//|                        VerysVeryInc.MetaTrader4.VsVEA_Signal.mqh |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MQH.VsVEA.Library - Ver.0.2.0 Update:2017.02.15"
#property strict

//--- Includes ---//
#include <stderror.mqh>
#include <stdlib.mqh>
#include <VsVEA_Library.mqh>


//--- Define Value (Ver.0.0.2) ---//
// #define VSV_OPENPOS		6

//--- Extern (Ver.0.1.1) ---//
// (Ver.0.0.3)
// extern int VsVOrderWaitingTime=10;
// (Ver.0.0.8)
// extern double DecreaseFactor=3;
// (Ver.0.1.0)
extern int RSIPeriod=14;
// (Ver.0.1.11)
// extern int Slippage=3;


//--- Imports (Ver.0.2.0) ---//
#import "VsVEA_Signal.ex4"

//*** VsV.Signal End ***//
//+------------------------------------------------------------------+
//|  Entry Signal for Open Order (Ver.0.1.0)                         |
//+------------------------------------------------------------------+
int EntrySignal(int magic);


//+------------------------------------------------------------------+
//|  Exit Signal for Open Order (Ver.0.1.1)                          |
//+------------------------------------------------------------------+
int ExitSignal(int magic);


#import

//+------------------------------------------------------------------+