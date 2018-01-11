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
#property description "VsV.MT4.VsVEA.USDJPY.Sig - Ver.0.11.6.1 Update:2018.01.10"
#property strict

//--- Includes ---//
#include <VsVEA_UJ_Sig.mqh>

//--- Base.TL ---//
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

//--- Stochastic & Sto.Center ---//
extern double vSto, vSto01;
extern double vStoSig, vStoSig01;
extern double stoCheck;   	// Sto & Signal.Up.Down.Check
extern double stoCheckC50;  // Sto & Singnal & C-50.Up&Down.Check
extern double stoPos;   	// Sto & Signal & C-50.CurrentPosition

//--- RSI & RSI.Center ---//
extern double vRSI, vRSI01;
extern double rsiCheck;   // RSI Up.Down.Check
extern double rsiCheckC50;  // RSI & C-50.Up&Down.Check
extern double rsiPos;   // RSI & C-50 & 30.70.Over & 40.60.Range.CurrentPosition

//--- HL ---//
extern double HLMid, HLMid01;


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
//|  VsVFX_Sto Signal (Ver.0.11.3.6)                                 |
//+------------------------------------------------------------------+
void VsVFX_Sto_Sig(double &stoC, double &stoCC, double &stoP,
		double &vSto0, double &vSto001,
		double &vStoSig0, double &vStoSig001) export
{
//--- 2. TrendLine ---//
	//*--- 2-3. TrendLine : Stochastic.Up&Down.TrendCheck
	//*--- Stochastic.Trend.Up ---//
	if( vSto001 <= vStoSig001 && vSto0 > vStoSig0 ) stoC = 1;
	//*--- Stochastic.Trend.Down ---//
	if( vSto001 >= vStoSig001 && vSto0 < vStoSig0 ) stoC = -1;

	//*--- Stochastic.Center.x.Up ---//
	if( vSto001 < 50 && vSto0 > 50 && vSto0 > vStoSig0 ) stoCC = 1;
	//*--- Stochastic.Center.x.Down ---//
	if( vSto001 > 50 && vSto0 < 50 && vSto0 < vStoSig0 ) stoCC = -1;

	//*--- Stochastic.Position ---//
	//*--- Sto.Center.x ---//
	if( vSto001 < 50 && vSto001 >= vStoSig001
		&& vSto0 > 50 && vSto0 > vStoSig0 ) stoP = 1;
	if( vSto001 > 50 && vSto001 <= vStoSig001
		&& vSto0 < 50 && vSto0 < vStoSig0 ) stoP = -1;

	//*--- vSto01 > 50 & vSto > 50 ---//
	//*--- 50.UpUp
	if( vSto001 > 50 && vSto001 >= vStoSig001
		&& vSto0 > 50 && vSto0 > vStoSig0 ) stoP = 2;
	//*--- 50.DownDown
	if( vSto001 > 50 && vSto001 <= vStoSig001
		&& vSto0 > 50 && vSto0 < vStoSig0 ) stoP = -2;
	//*--- 50.xUp
	if( vSto001 > 50 && vSto001 <= vStoSig001
		&& vSto0 > 50 && vSto0 > vStoSig0 ) stoP = 3;
	//*--- 50.xDown
	if( vSto001 > 50 && vSto001 >= vStoSig001
		&& vSto0 > 50 && vSto0 < vStoSig0 ) stoP = -3;

	//*--- vSto01 < 50 & vSto < 50 ---//
	//*--- -50.UpUp
	if( vSto001 < 50 && vSto001 >= vStoSig001
		&& vSto0 < 50 && vSto0 > vStoSig0 ) stoP = 4;
	//*--- -50.DownDown
	if( vSto001 < 50 && vSto001 <= vStoSig001
		&& vSto0 < 50 && vSto0 < vStoSig0 ) stoP = -4;
	//*--- -50.xUp
	if( vSto001 < 50 && vSto001 <= vStoSig001
		&& vSto0 < 50 && vSto0 > vStoSig0 ) stoP = 5;
	//*--- -50.xDown
	if( vSto001 < 50 && vSto001 >= vStoSig001
		&& vSto0 < 50 && vSto0 < vStoSig0 ) stoP = -5;
}

//+------------------------------------------------------------------+
//|  VsVFX_RSI Signal (Ver.0.11.3.7)                                 |
//+------------------------------------------------------------------+
void VsVFX_RSI_Sig(double &rsiC, double &rsiCC, double &rsiP,
		double &vRSI0, double &vRSI001) export
{
//--- 2. TrendLine ---//
	//*--- 2-4. TrendLine : RSI.Up&Down.TrendCheck
	//*--- RSI.Trend.Up ---//
	if( vRSI0 > vRSI001 ) rsiC = 1;
	//*--- RSI.Trend.Down ---//
	if( vRSI0 < vRSI001 ) rsiC = -1;

	//*--- RSI.Center.x.Up ---//
	if( vRSI001 < 50 && vRSI0 > 50 && vRSI0 > vRSI001 ) rsiCC = 1;
	//*--- RSI.Center.x.Down ---//
	if( vRSI001 > 50 && vRSI0 < 50 && vRSI0 < vRSI001 ) rsiCC = -1;

	//*--- RSI.Position ---//
	//*--- RSI.Center.x ---//
	if( vRSI001 < 50 && vRSI0 > 50 && vRSI0 > vRSI001 ) rsiP = 50;
	if( vRSI001 > 50 && vRSI0 < 50 && vRSI0 < vRSI001 ) rsiP = -50;

	//*--- RSI.Resistance.Range ---//
	//*--- 56.UpUp : 50 < vRSI01 <= 60 && 50 < vRSI <= 60
	if( vRSI001 > 50 && vRSI001 <= 60
		&& vRSI0 > 50 && vRSI0 <= 60 && vRSI0 > vRSI001 ) rsiP = 56;
	//*--- 67.UpUp : 60 < vRSI01 <= 70 && 60 < vRSI <= 70
	if( vRSI001 > 60 && vRSI001 <= 70
		&& vRSI0 > 60 && vRSI0 <= 70 && vRSI0 > vRSI001 ) rsiP = 67;
	//*--- 77.UpUp : 70 < vRSI01 <= 100 && 70 < vRSI <= 100
	if( vRSI001 > 70 && vRSI001 <= 100
		&& vRSI0 > 70 && vRSI0 <= 100 && vRSI0 > vRSI001 ) rsiP = 77;
	//*--- 60.xUp : 50 < vRSI01 <= 60 && 60 < vRSI <= 70
	if( vRSI001 > 50 && vRSI001 <= 60
		&& vRSI0 > 60 && vRSI0 <= 70 && vRSI0 > vRSI001 ) rsiP = 60;
	//*--- 70.xUp : 60 < vRSI01 <= 70 && 70 < vRSI <= 100
	if( vRSI001 > 60 && vRSI001 <= 70
		&& vRSI0 > 70 && vRSI0 <= 100 && vRSI0 > vRSI001 ) rsiP = 70;

	//*--- -56.DownDown : 50 < vRSI01 <= 60 && 50 < vRSI <= 60
	if( vRSI001 > 50 && vRSI001 <= 60
		&& vRSI0 > 50 && vRSI0 <= 60 && vRSI0 < vRSI001 ) rsiP = -56;
	//*--- -67.DownDown : 60 < vRSI01 <= 70 && 60 < vRSI <= 70
	if( vRSI001 > 60 && vRSI001 <= 70
		&& vRSI0 > 60 && vRSI0 <= 70 && vRSI0 < vRSI001 ) rsiP = -67;
	//*--- -77.DownDown : 70 < vRSI01 <= 100 && 70 < vRSI <= 100
	if( vRSI001 > 70 && vRSI001 <= 100
		&& vRSI0 > 70 && vRSI0 <= 100 && vRSI0 < vRSI001 ) rsiP = -77;
	//*--- -60.xDown : 60 < vRSI01 <= 70 && 50 < vRSI <= 60
	if( vRSI001 > 60 && vRSI001 <= 70
		&& vRSI0 > 50 && vRSI0 <= 60 && vRSI0 < vRSI001 ) rsiP = -60;
	//*--- -70.xDown : 70 < vRSI01 <= 100 && 60 < vRSI <= 70
	if( vRSI001 > 70 && vRSI001 <= 100
		&& vRSI0 > 60 && vRSI0 <= 70 && vRSI0 < vRSI001 ) rsiP = -70;

	//*--- RSI.Support.Range ---//
	//*--- 45.UpUp : 40 <= vRSI01 < 50 && 40 <= vRSI < 50
	if( vRSI001 >= 40 && vRSI001 < 50
		&& vRSI0 >= 40 && vRSI0 < 50 && vRSI0 > vRSI001 ) rsiP = 45;
	//*--- 34.UpUp : 30 <= vRSI01 < 40 && 30 <= vRSI < 40
	if( vRSI001 >= 30 && vRSI001 < 40
		&& vRSI0 >= 30 && vRSI0 < 40 && vRSI0 > vRSI001 ) rsiP = 34;
	//*--- 33.UpUp : 0 <= vRSI01 < 30 && 0 <= vRSI < 30
	if( vRSI001 >= 0 && vRSI001 < 30
		&& vRSI0 >= 0 && vRSI0 < 30 && vRSI0 > vRSI001 ) rsiP = 33;
	//*--- 40.xUp : 30 <= vRSI01 < 40 && 40 <= vRSI < 50
	if( vRSI001 >= 30 && vRSI001 < 40
		&& vRSI0 >= 40 && vRSI0 < 50 && vRSI0 > vRSI001 ) rsiP = 40;
	//*--- 30.xUp : 0 <= vRSI01 < 30 && 30 <= vRSI < 40
	if( vRSI001 >= 0 && vRSI001 < 30
		&& vRSI0 >= 30 && vRSI0 < 40 && vRSI0 > vRSI001 ) rsiP = 30;

	//*--- -45.DownDown : 40 <= vRSI01 < 50 && 40 <= vRSI < 50
	if( vRSI001 >= 40 && vRSI001 < 50
		&& vRSI0 >= 40 && vRSI0 < 50 && vRSI0 < vRSI001 ) rsiP = -45;
	//*--- -34.DownDown : 30 <= vRSI01 < 40 && 30 <= vRSI < 40
	if( vRSI001 >= 30 && vRSI001 < 40
		&& vRSI0 >= 30 && vRSI0 < 40 && vRSI0 < vRSI001 ) rsiP = -34;
	//*--- -33.DownDown : 0 <= vRSI01 < 30 && 0 <= vRSI < 30
	if( vRSI001 >= 0 && vRSI001 < 30
		&& vRSI0 >= 0 && vRSI0 < 30 && vRSI0 < vRSI001 ) rsiP = -33;
	//*--- -40.xDown : 40 <= vRSI01 < 50 && 30 <= vRSI < 40
	if( vRSI001 >= 40 && vRSI001 < 50
		&& vRSI0 >= 30 && vRSI0 < 40 && vRSI0 < vRSI001 ) rsiP = -40;
	//*--- -30.xDown : 30 <= vRSI01 < 40 && 0 <= vRSI < 30
	if( vRSI001 >= 30 && vRSI001 < 40
		&& vRSI0 >= 0 && vRSI0 < 30 && vRSI0 < vRSI001 ) rsiP = -30;
}

//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order(Ver.0.11.3.7)->(Ver.0.11.4.1)|
//+------------------------------------------------------------------+
/*
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
*

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

	//*--- 2-3. Stochastic ---//
	vSto  = iCustom( NULL, 0, "VsVSto", 0, 0 );
	vSto01  = iCustom( NULL, 0, "VsVSto", 0, 1 );

	vStoSig   = iCustom( NULL, 0, "VsVSto", 1, 0 );
	vStoSig01 = iCustom( NULL, 0, "VsVSto", 1, 1 );

	//*--- 2-3.1. stoCheck & stoCheckC50 & stoPos ---//
	VsVFX_Sto_Sig(stoCheck, stoCheckC50, stoPos,
		vSto, vSto01, vStoSig, vStoSig01);

	//*--- 2-4. RSI ---//
	vRSI  = iCustom( NULL, 0, "VsVFX_RSI", 0, 0 );
	vRSI01  = iCustom( NULL, 0, "VsVFX_RSI", 0, 1 );

	//*--- 2-4.1. rsiCheck & rsiCheckC50 & rsiPos ---//
	VsVFX_RSI_Sig(rsiCheck, rsiCheckC50, rsiPos, vRSI, vRSI01);

	//*--- 2-5. HL ---//
	HLMid = iCustom( NULL, 0, "VsVHL", 0, 0 );
	HLMid01 = iCustom( NULL, 0, "VsVHL", 0, 1 );

	//*--- 2-6. TL ---//

//--- 99. Buy or Sell Signal ---//
	int ret = 0;

	//*--- Buy ---//
	if( tLots==1 && Ask>=HLMid01 && mdCheck==1 && mdCheckC00==1 ) ret = 1;
	//*--- Sell ---//
	if( tLots==-1 && Bid<=HLMid01 && mdCheck==-1 && mdCheckC00==-1 ) ret=-1;


//--- Return Ret Value ---//
	return(ret);
}
*/

//+------------------------------------------------------------------+
//|  USDJPY Exit Signal for Open Order(Ver.0.11.3.2)->(Ver.0.11.4.2) |
//+------------------------------------------------------------------+
/*
int USDJPY_ExitSignal(int magic) export
{
//--- Open Position Check ---//
	pos = VsVCurrentOrders(VSV_OPENPOS, magic);

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

	//*--- 2-3. Stochastic ---//
	vSto  = iCustom( NULL, 0, "VsVSto", 0, 0 );
	vSto01  = iCustom( NULL, 0, "VsVSto", 0, 1 );

	vStoSig   = iCustom( NULL, 0, "VsVSto", 1, 0 );
	vStoSig01 = iCustom( NULL, 0, "VsVSto", 1, 1 );

	//*--- 2-3.1. stoCheck & stoCheckC50 & stoPos ---//
	VsVFX_Sto_Sig(stoCheck, stoCheckC50, stoPos,
		vSto, vSto01, vStoSig, vStoSig01);

	//*--- 2-4. RSI ---//
	vRSI  = iCustom( NULL, 0, "VsVFX_RSI", 0, 0 );
	vRSI01  = iCustom( NULL, 0, "VsVFX_RSI", 0, 1 );

	//*--- 2-4.1. rsiCheck & rsiCheckC50 & rsiPos ---//
	VsVFX_RSI_Sig(rsiCheck, rsiCheckC50, rsiPos, vRSI, vRSI01);

	//*--- 2-5. HL ---//
	HLMid = iCustom( NULL, 0, "VsVHL", 0, 0 );
	HLMid01 = iCustom( NULL, 0, "VsVHL", 0, 1 );

//--- 99. Buy or Sell Signal ---//
	int ret_exit = 0;

	//*--- Buy ---//
	if( tLots==1 && Ask>= HLMid01 && stoPos>0 && rsiPos==50 )
		ret_exit = -1;

	//*--- Sell ---//
	if( tLots==-1 && Bid<= HLMid01 && stoPos<0 && rsiPos==-50 )
		ret_exit = 1;

//--- Return Ret_Exit Value ---//
	return(ret_exit);

}
*/

//+------------------------------------------------------------------+