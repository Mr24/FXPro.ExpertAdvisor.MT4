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
#property description "VsV.MQH.VsVEA.Library - Ver.0.2.1 Update:2017.02.15"
#property strict

//--- Includes ---//
#include <stderror.mqh>
#include <stdlib.mqh>
#include <VsVEA_Library.mqh>


//--- Extern (Ver.0.1.1) ---//
extern int RSIPeriod=14;


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