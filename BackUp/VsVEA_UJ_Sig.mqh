//+------------------------------------------------------------------+
//|                 VerysVeryInc.MetaTrader4.VsVEA_USDJPY_Signal.mqh |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MQH.VsVEA.USDJPY.Sig - Ver.0.11.3.7 Update:2017.12.27"
#property strict

//--- Includes (Ver.0.2.0) ---//
#include <stderror.mqh>
#include <stdlib.mqh>
// (Ver.0.2.0)
#include <VsVEA_UJ_Lib.mqh>


//--- Extern (Ver.0.2.3) ---//
// VsVEA_RSI (Ver.0.1.1)
extern int RSIPeriod=14;
// VsVEA_Sto (Ver.0.2.3)
extern int KPeriod=5;
extern int DPeriod=3;
extern int Slowing=3;
// VsVEA_HL (Ver.0.2.4)
extern int HLPeriod=20;


//--- Imports (Ver.0.2.0) ---//
#import "VsVEA_UJ_Sig.ex4"

//*** VsV.Signal ***//
//+------------------------------------------------------------------+
//|  VsVFX_BL Signal (Ver.0.11.3.2)  -> (Ver.0.11.3.3)               |
//+------------------------------------------------------------------+
void VsVFX_BL_Sig(double &sTime, double &sPrice,
					double &rTime, double &rPrice);
// (Ver.0.11.3.2) double VsVFX_BL_Sig(double sTime);


//+------------------------------------------------------------------+
//|  VsVFX_SAR Signal (Ver.0.11.3.4)                                 |
//+------------------------------------------------------------------+
int VsVFX_SAR_Sig(double &vSAR000, double &vSAR001,
				double &vLow001, double &vHigh001);


//+------------------------------------------------------------------+
//|  VsVFX_MACD Signal (Ver.0.11.3.5)                                |
//+------------------------------------------------------------------+
void VsVFX_MACD_Sig(double &mdC, double &mdCC,
		double &vMACD0, double &vMACD001, double &vMACD002,
		double &vMACDSig0, double &vMACDSig001, double &vMACDSig002);


//+------------------------------------------------------------------+
//|  VsVFX_Sto Signal (Ver.0.11.3.6)                                 |
//+------------------------------------------------------------------+
void VsVFX_Sto_Sig(double &stoC, double &stoCC, double &stoP,
		double &vSto0, double &vSto001,
		double &vStoSig0, double &vStoSig001);


//+------------------------------------------------------------------+
//|  VsVFX_RSI Signal (Ver.0.11.3.7)                                 |
//+------------------------------------------------------------------+
void VsVFX_RSI_Sig(double &rsiC, double &rsiCC, double &rsiP,
		double &vRSI0, double &vRSI001);


//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order (Ver.0.11.3.1)               |
//+------------------------------------------------------------------+
int USDJPY_EntrySignal(int magic);


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


//+------------------------------------------------------------------+
//|  HL_Band Entry Signal for Open Order (Ver.0.2.3) -> (Ver.0.2.4)  |
//+------------------------------------------------------------------+
int HL_EntrySignal(int magic);


//+------------------------------------------------------------------+
//|  HL_Band Exit Signal for Open Order (Ver.0.2.3) -> (Ver.0.2.4)   |
//+------------------------------------------------------------------+
int HL_ExitSignal(int magic);


#import

//+------------------------------------------------------------------+