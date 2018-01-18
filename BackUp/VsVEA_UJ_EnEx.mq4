//+------------------------------------------------------------------+
//|              VerysVeryInc.MetaTrader4.VsVEA_USDJPY_EntryExit.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.VsVEA.USDJPY.EnEx - Ver.0.11.8.1 Update:2018.01.18"
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

//--- TL ---//
extern double NewTL;

//--- CCI.Woody ---//
extern double TrendCCI, TrendCCI01;
extern double EntryCCI, EntryCCI01;
extern double cTimeBar;
extern bool Zero_Cross;

//--- Entry & Exit Story ---//
extern double EnSt;
extern double ExSt;


//+------------------------------------------------------------------+
//|  NewTL Entry Signal for Open Order(Ver.0.11.6.1)                 |
//+------------------------------------------------------------------+
int NewTL_EntrySignal(int magic) export
{
//--- Open Position Check ---//
	// (0.11.6.0.OK) pos = VsVCurrentOrders(VSV_OPENPOS, magic);

/*
//--- 1. Base.TrendLine --//
	//*--- Support.Time & Price
	sTime0	= iCustom( NULL, 0, "VsVFX_BL", 5, 0 );
	sPrice0	= iCustom( NULL, 0, "VsVFX_BL", 4, 0 );
	//*--- Resistance.Time & Price
	rTime0	= iCustom( NULL, 0, "VsVFX_BL", 7, 0 );
	rPrice0	= iCustom( NULL, 0, "VsVFX_BL", 6, 0 );
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
	/* (0.11.6.0.OK)
	NewTL = iCustom( NULL, 0, "VsVFX_TL", 0, 0 );
	Print( "NewTL:" + DoubleToStr( NewTL, Digits ) );
	*/

	//*--- 2-7. CCI.Woody ---//
	TrendCCI = iCustom( NULL, 0, "VsVFX_CCI", 4, 0 );
	TrendCCI01 = iCustom( NULL, 0, "VsVFX_CCI", 4, 1 );
	EntryCCI = iCustom( NULL, 0, "VsVFX_CCI", 5, 0 );
	EntryCCI01 = iCustom( NULL, 0, "VsVFX_CCI", 5, 1 );
	cTimeBar = iCustom( NULL, 0, "VsVFX_CCI", 3, 0 );

//--- 99. Buy or Sell Signal ---//
	int ret = 0;

	//*--- Buy ---//
	if( tLots==1 && Ask>=HLMid01
		// (0.11.7.2.OK) && mdCheck==1 // (0.11.7.1.OK) && mdCheckC00==1
		// (0.11.7.1.OK) && rsiPos>=50
		// (0.11.7.1.OK) && stoPos>0
	)
	{
		if( EntryCCI01<0 && EntryCCI>=0 ) ret=1;
		/* (Ver.0.11.7.2.OK)
		if( rsiPos>=50 && stoCheck>0 && stoPos>0 && stoPos<=3 ) ret = 1;
		if( stoCheck>0 && stoPos>0 && stoPos<=3 && rsiPos>=50 ) ret = 1;
		*/
	}
	//*--- Sell ---//
	if( tLots==-1 && Bid<=HLMid01
		// (0.11.7.2.OK) && mdCheck==-1 // (0.11.7.1.OK) && mdCheckC00==-1
		// (0.11.7.1.OK) && rsiPos<=50
		// (0.11.7.1.OK) && stoPos<0
	)
	{
		if( EntryCCI01>0 && EntryCCI<=0) ret=-1;
		/* (Ver.0.11.7.1.OK)
		if( rsiPos<=0 && stoCheck<0
			&& stoPos<0 && stoPos!=-2 && stoPos!=-3 ) ret=-1;
		if( stoPos<0 && stoPos!=-2 && stoPos!=-3
			&& rsiPos<=0 && stoCheck<0 ) ret=-1;
		*/
	}

	/* (Ver.0.11.6.5.OK)
	//*--- Buy ---//
	if( tLots==1 && Ask>=HLMid01 && mdCheck==1 && mdCheckC00==1 ) ret = 1;
	//*--- Sell ---//
	if( tLots==-1 && Bid<=HLMid01 && mdCheck==-1 && mdCheckC00==-1 ) ret=-1;
	*/


//--- Return Ret Value ---//
	return(ret);
}

//+------------------------------------------------------------------+
//|  NewTL Exit Signal for Open Order (Ver.0.11.6.1)->(Ver.0.11.6.5) |
//+------------------------------------------------------------------+
int NewTL_ExitSignal(double NewTL00, int magic) export
// (Ver.0.11.6.4.OK) int NewTL_ExitSignal(int magic) export
{
//--- Open Position Check ---//
	// (0.11.6.0.OK) pos = VsVCurrentOrders(VSV_OPENPOS, magic);

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
	Print( "NewTL00:" + DoubleToStr( NewTL00, Digits ) );

	//*--- 2-7. CCI.Woody ---//
	TrendCCI = iCustom( NULL, 0, "VsVFX_CCI", 4, 0 );
	TrendCCI01 = iCustom( NULL, 0, "VsVFX_CCI", 4, 1 );
	EntryCCI = iCustom( NULL, 0, "VsVFX_CCI", 5, 0 );
	EntryCCI01 = iCustom( NULL, 0, "VsVFX_CCI", 5, 1 );
	cTimeBar = iCustom( NULL, 0, "VsVFX_CCI", 3, 0 );

//--- 99. Buy or Sell Signal ---//
	int ret_exit = 0;

	//*--- Buy ---//
	if( tLots==1 && Ask>= HLMid01
		// (0.11.7.2.OK) && mdCheck==1
		// (0.11.7.1.OK) && rsiPos==50
		// (0.11.7.1.OK) && stoPos>0
	)
	{
		if( EntryCCI>=0 && TrendCCI>=0 && cTimeBar>=0 ) ret_exit=-1;
		/* (Ver.0.11.7.2.OK)
		if( rsiPos>=50 && stoCheck>0 && stoPos>0 && stoPos<=3 ) ret_exit = -1;
		if( stoCheck>0 && stoPos>0 && stoPos<=3 && rsiPos>=50 ) ret_exit = -1;
		*/
	}
	//*--- Sell ---//
	if( tLots==-1 && Bid<= HLMid01
		// (0.11.7.2.OK) & mdCheck==-1
		// (0.11.7.1.OK) && rsiPos==-50
		// (0.11.7.1.OK) && stoPos<0
	)
	{
		if( EntryCCI<=0 && TrendCCI<=0 && cTimeBar<=0 ) ret_exit=1;
		/* (Ver.0.11.7.2.OK)
		if( rsiPos<=0 && stoCheck<0
			&& stoPos<0 && stoPos!=-2 && stoPos!=-3 ) ret_exit = 1;
		if( stoPos<0 && stoPos!=-2 && stoPos!=-3
			&& rsiPos<=0 && stoCheck<0 ) ret_exit = 1;
		*/
	}

	/* (Ver.0.11.6.5.OK)
	//*--- Buy ---//
	if( tLots==1 && Ask>= HLMid01 && stoPos>0 && rsiPos==50 )
		ret_exit = -1;
	//*--- Sell ---//
	if( tLots==-1 && Bid<= HLMid01 && stoPos<0 && rsiPos==-50 )
		ret_exit = 1;
	*/

//--- Return Ret_Exit Value ---//
	return(ret_exit);

}

//+------------------------------------------------------------------+
//|  USDJPY Entry Signal for Open Order(Ver.0.11.6.1)->(Ver.0.11.6.2)|
//+------------------------------------------------------------------+
int USDJPY_EntrySignal(int magic) export
{
//--- Open Position Check ---//
	pos = VsVCurrentOrders(VSV_OPENPOS, magic);

//--- 2. TrendLine ---//
	//*--- 2-6. TL ---//
	/* (Ver.0.11.6.4.OK)
	NewTL = iCustom( NULL, 0, "VsVFX_TL", 0, 0 );
	Print( "NewTL.En:" + DoubleToStr( NewTL, Digits ) );
	*/

	//*--- 2-7. Entry.Story ---//
	EnSt = iCustom( NULL, 0, "VsVFX_TL", 1, 0 );
	Print( "EnSt." + DoubleToStr( EnSt, 0 )	);


//--- 99. Buy or Sell Signal ---//
	int ret = 0;

	//*--- Buy ---//
	if(EnSt>0)
		if(pos<=0) ret = (int)EnSt;
	//*--- Sell ---//
	if(EnSt<0)
		if(pos>=0) ret = (int)EnSt;

	/* (Ver.0.11.6.3.OK)
	//*--- Buy ---//
	if(EnSt>0) ret = (int)EnSt;
	//*--- Sell ---//
	if(EnSt<0) ret = (int)EnSt;
	*/

	/* (Ver.0.11.6.2.OK)
	//*--- Buy ---//
	if(pos<=0) ret = NewTL_EntrySignal(magic);
	//*--- Sell ---//
	if(pos>=0) ret = NewTL_EntrySignal(magic);
	*/

	/* (Ver.0.11.6.1.OK)
	//*--- Buy ---//
	if( tLots==1 && Ask>=HLMid01 && mdCheck==1 && mdCheckC00==1 ) ret = 1;
	//*--- Sell ---//
	if( tLots==-1 && Bid<=HLMid01 && mdCheck==-1 && mdCheckC00==-1 ) ret=-1;
	*/


//--- Return Ret Value ---//
	return(ret);
}

//+------------------------------------------------------------------+
//|  USDJPY Exit Signal for Open Order(Ver.0.11.6.1)->(Ver.0.11.6.2) |
//+------------------------------------------------------------------+
int USDJPY_ExitSignal(int magic) export
{
//--- Open Position Check ---//
	pos = VsVCurrentOrders(VSV_OPENPOS, magic);

//--- 2. TrendLine ---//
	//*--- 2-6. TL ---//
	/* (Ver.0.11.6.4.OK)
	NewTL = iCustom( NULL, 0, "VsVFX_TL", 0, 0 );
	Print( "NewTL.Ex:" + DoubleToStr( NewTL, Digits ) );
	*/

	//*--- 2-7. Entry.Story ---//
	ExSt = iCustom( NULL, 0, "VsVFX_TL", 2, 0 );
	Print( "ExSt." + DoubleToStr( ExSt, 0 )	);

//--- 99. Buy or Sell Signal ---//
	int ret_exit = 0;

	//*--- Buy ---//
	if(ExSt<0)
		if(pos<=0) ret_exit = (int)ExSt;
	//*--- Sell ---//
	if(ExSt>0)
		if(pos>=0) ret_exit = (int)ExSt;

	/* (Ver.0.11.6.3.OK)
	//*--- Buy ---//
	if(ExSt<0) ret_exit = (int)ExSt;
	//*--- Sell ---//
	if(ExSt>0) ret_exit = (int)ExSt;
	*/

	/* (Ver.0.11.6.2.OK)
	//*--- Buy ---//
	if(pos<=0) ret_exit = NewTL_ExitSignal(magic);

	//*--- Sell ---//
	if(pos>=0) ret_exit = NewTL_ExitSignal(magic);
	*/

	/* (Ver.0.11.6.1.OK)
	//*--- Buy ---//
	if( tLots==1 && Ask>= HLMid01 && stoPos>0 && rsiPos==50 )
		ret_exit = -1;

	//*--- Sell ---//
	if( tLots==-1 && Bid<= HLMid01 && stoPos<0 && rsiPos==-50 )
		ret_exit = 1;
	*/

//--- Return Ret_Exit Value ---//
	return(ret_exit);

}

//+------------------------------------------------------------------+