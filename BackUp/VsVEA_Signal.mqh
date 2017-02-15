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
#property description "VsV.MQH.VsVEA.Library - Ver.0.2.3 Update:2017.02.15"
#property strict

//--- Includes (Ver.0.2.0) ---//
#include <stderror.mqh>
#include <stdlib.mqh>
// (Ver.0.2.0)
#include <VsVEA_Library.mqh>


//--- Extern (Ver.0.2.3) ---//
// VsVEA_RSI (Ver.0.1.1)
extern int RSIPeriod=14;
// VsVEA_Sto (Ver.0.2.3)
extern int KPeriod=5;
extern int DPeriod=3;
extern int Slowing=3;


//--- Imports (Ver.0.2.0) ---//
#import "VsVEA_Signal.ex4"

//*** VsV.Signal ***//
//+------------------------------------------------------------------+
//|  RSI Entry Signal for Open Order (Ver.0.1.0) -> (Ver.0.2.2)      |
//+------------------------------------------------------------------+
int RSI_EntrySignal(int magic);


//+------------------------------------------------------------------+
//|  RSI Exit Signal for Open Order (Ver.0.1.1) -> (Ver.0.2.2)       |
//+------------------------------------------------------------------+
int RSI_ExitSignal(int magic);


//+------------------------------------------------------------------+
//|  Sto Entry Signal for Open Order (Ver.0.2.2) -> (Ver.0.2.3)      |
//+------------------------------------------------------------------+
int Sto_EntrySignal(int magic);


//+------------------------------------------------------------------+
//|  Sto Exit Signal for Open Order (Ver.0.2.2) -> (Ver.0.2.3)       |
//+------------------------------------------------------------------+
int Sto_ExitSignal(int magic);


#import

//+------------------------------------------------------------------+