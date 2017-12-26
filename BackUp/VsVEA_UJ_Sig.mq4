//+------------------------------------------------------------------+
//|                 VerysVeryInc.MetaTrader4.VsVEA_USDJPY_Signal.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.VsVEA.USDJPY.Sig - Ver.0.11.3.3 Update:2017.12.26"
#property strict

//--- Includes ---//
#include <VsVEA_UJ_Sig.mqh>

extern double pos;
extern double sTime0, sPrice0;
extern double rTime0, rPrice0;

//+------------------------------------------------------------------+
//|  VsVFX_BL Signal (Ver.0.11.3.2) -> (Ver.0.11.3.3)                |
//+------------------------------------------------------------------+
void VsVFX_BL_Sig(double &sTime, double &sPrice,
					double &rTime, double &rPrice) export
// (Ver.0.11.3.2) double VsVFX_BL_Sig(double sTime) export
{
//--- 1. Base.TrendLine --//
	//*--- Support.Time & Price
	sTime 	= iCustom( NULL, 0, "VsVFX_BL", 5, 0 );
	sPrice 	= iCustom( NULL, 0, "VsVFX_BL", 4, 0 );
	// (Ver.0.11.3.2) sTime0	= iCustom( NULL, 0, "VsVFX_BL", 5, 0 );
	// (Ver.0.11.3.2) sPrice0	= iCustom( NULL, 0, "VsVFX_BL", 4, 0 );
	//*--- Resistance.Time & Price
	rTime	= iCustom( NULL, 0, "VsVFX_BL", 7, 0 );
	rPrice	= iCustom( NULL, 0, "VsVFX_BL", 6, 0 );

	// (Ver.0.11.3.2) return(sTime0);
}

//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order (Ver.0.11.3.1)               |
//+------------------------------------------------------------------+
int USDJPY_EntrySignal(int magic) export
{
//--- Open Position Check ---//
	pos=VsVCurrentOrders(VSV_OPENPOS, magic);

//--- 1. Base.TrendLine --//
	//*--- Support.Time & Price
	sTime0	= iCustom( NULL, 0, "VsVFX_BL", 5, 0 );
	sPrice0	= iCustom( NULL, 0, "VsVFX_BL", 4, 0 );
	//*--- Resistance.Time & Price
	rTime0	= iCustom( NULL, 0, "VsVFX_BL", 7, 0 );
	rPrice0	= iCustom( NULL, 0, "VsVFX_BL", 6, 0 );

	int rTime00	= (int)rTime0;

	return(rTime00);
}

//+------------------------------------------------------------------+