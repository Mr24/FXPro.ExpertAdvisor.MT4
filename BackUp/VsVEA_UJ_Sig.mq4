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
#property description "VsV.MT4.VsVEA.USDJPY.Sig - Ver.0.11.3.5 Update:2017.12.27"
#property strict

//--- Includes ---//
#include <VsVEA_UJ_Sig.mqh>

extern double pos;
extern double sTime0, sPrice0;
extern double rTime0, rPrice0;

//--- SAR ---//
extern int tLot;
extern double vSAR, vSAR01;
extern double vLow, vLow01;
extern double vHigh, vHigh01;
extern double tLots;    // TrendCheckLots

//--- MACD & MACD.Center ---//
extern double vMACD, vMACD01, vMACD02;
extern double vMACDSig, vMACDSig01, vMACDSig02;
extern double mdCheck;    // MACD & Signal.Up&Down.Check
extern double mdCheckC00; // MACD & Signal & C-0.Up&Down.Check


//+------------------------------------------------------------------+
//|  VsVFX_BL Signal (Ver.0.11.3.2) -> (Ver.0.11.3.3)                |
//+------------------------------------------------------------------+
void VsVFX_BL_Sig(double &sTime, double &sPrice,
					double &rTime, double &rPrice) export
// (Ver.0.11.3.2) double VsVFX_BL_Sig(double sTime) export
{
//--- 1. Base.TrendLine ---//
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
//|  VsVFX_SAR Signal (Ver.0.11.3.4)                                 |
//+------------------------------------------------------------------+
int VsVFX_SAR_Sig(double &vSAR000, double &vSAR001,
				double &vLow001, double &vHigh001) export
{
//--- 2. TrendLine ---//
	//*--- 2-1. TrendLine : SAR.Up&Down.TrendCheck
	//*--- TL.Trend.Down
	if( vSAR001<=vLow001 && vSAR001 < vHigh001 && vSAR000 >= vHigh001 ) tLot = -1;
	//*--- TL.Trend.Up
	if( vSAR001 >= vHigh001 && vSAR001 > vLow001 && vSAR000 <= vLow001 ) tLot = 1;

	return(tLot);
}

//+------------------------------------------------------------------+
//|  VsVFX_MACD Signal (Ver.0.11.3.5)                                |
//+------------------------------------------------------------------+
void VsVFX_MACD_Sig(double &mdC, double &mdCC,
		double &vMACD0, double &vMACD001, double &vMACD002,
		double &vMACDSig0, double &vMACDSig001, double &vMACDSig002) export
{
//--- 2. TrendLine ---//
	//*--- 2-2. TrendLine : MACD.Up&Down.TrendCheck
	//*--- MACD.Trend.Up ---//
	if( vMACD002 <= vMACDSig002 && vMACD001 > vMACDSig001 ) mdC = 1;
	//*--- MACD.Trend.Down ---//
	if( vMACD002 >= vMACDSig002 && vMACD001 < vMACDSig001 ) mdC = -1;

	//*--- MACD.Center.Up ---//
	if( vMACD001 < 0 && vMACD0 > vMACDSig0 && vMACD0 > 0) mdCC = 1;
	//*--- MACD.Center.Down ---//
	if( vMACD001 > 0 && vMACD0 < vMACDSig0 && vMACD0 < 0) mdCC = -1;
}

//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order(Ver.0.11.3.4)->(Ver.0.11.3.5)|
//+------------------------------------------------------------------+
int USDJPY_EntrySignal(int magic) export
{
//--- Open Position Check ---//
	pos = VsVCurrentOrders(VSV_OPENPOS, magic);

/*
//--- 1. Base.TrendLine --//
	//*--- Support.Time & Price
	sTime0	= iCustom( NULL, 0, "VsVFX_BL", 5, 0 );
	sPrice0	= iCustom( NULL, 0, "VsVFX_BL", 4, 0 );
	//*--- Resistance.Time & Price
	rTime0	= iCustom( NULL, 0, "VsVFX_BL", 7, 0 );
	rPrice0	= iCustom( NULL, 0, "VsVFX_BL", 6, 0 );

	int rTime00	= (int)rTime0;

	// (Ver.0.11.3.1) return(rTime00);
*/

//--- 2. TrendLine ---//
	//*--- 2-1. SAR ---//
	vSAR = iCustom( NULL, 0, "VsVFX_SAR", 0, 0 );
	vSAR01 = iCustom( NULL, 0, "VsVFX_SAR", 0, 1 );

	vLow01 = iCustom( NULL, 0, "VsVFX_SAR", 1, 1 );
	vHigh01 = iCustom( NULL, 0, "VsVFX_SAR", 2, 1 );

	//*--- 2-1.1. tLots ---//
	tLots = VsVFX_SAR_Sig( vSAR, vSAR01, vLow01, vHigh01 );

	//*--- 2-2. MACD ---//
	mdCheckC00  = 0.0;
	vMACD   = iCustom( NULL, 0, "VsVMACD", 0, 0 );
	vMACD01 = iCustom( NULL, 0, "VsVMACD", 0, 1 );
	vMACD02 = iCustom( NULL, 0, "VsVMACD", 0, 2 );

	vMACDSig  = iCustom( NULL, 0, "VsVMACD", 1, 0 );
	vMACDSig01  = iCustom( NULL, 0, "VsVMACD", 1, 1 );
	vMACDSig02  = iCustom( NULL, 0, "VsVMACD", 1, 2 );

	//*--- 2-2.1. mdCheck & mdCheckC00 ---//
	VsVFX_MACD_Sig( mdCheck, mdCheckC00,
                  vMACD, vMACD01, vMACD02,
                  vMACDSig, vMACDSig01, vMACDSig02);


//--- 99. Buy or Sell Signal ---//
	int ret = 0;
	// ret = tLots;

	//*--- Buy ---//

	//*--- Sell ---//


//--- Return Ret Value ---//
	return(ret);
}

//+------------------------------------------------------------------+