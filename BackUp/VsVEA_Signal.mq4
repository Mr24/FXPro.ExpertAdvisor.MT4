//+------------------------------------------------------------------+
//|                        VerysVeryInc.MetaTrader4.VsVEA_Signal.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.VsVEA.Library - Ver.0.2.3 Update:2017.02.15"
#property strict

//--- Includes ---//
#include <VsVEA_Signal.mqh>


//+------------------------------------------------------------------+
//|  RSI Entry Signal for Open Order (Ver.0.1.2) -> (Ver.0.2.2)      |
//+------------------------------------------------------------------+
int RSI_EntrySignal(int magic) export
{
//--- Open Position Check ---//
	double pos=VsVCurrentOrders(VSV_OPENPOS, magic);

//--- RSI ---//
	//--- RSI.Live ---//
	double rsil=iRSI(NULL, 0, RSIPeriod, PRICE_CLOSE, 0); // (Ver.0.1.10)
	
	//--- RSI.1Before ---//
	double rsib=iRSI(NULL, 0, RSIPeriod, PRICE_CLOSE, 1);

//--- Buy or Sell Signal ---/
	int ret=0;
	
	//--- Buy ---//
	// if(pos<=0 && rsil<30) ret=1; // (Ver.0.1.10)
	if(pos<=0)
	{
		if(rsib<50 && rsil>50) ret=1;	
	}
	
	//--- Sell ---//
	// if(pos>=0 && rsil>70) ret=-1; // (Ver.0.1.10)
	if(pos>=0)
	{
		if(rsib>50 && rsil<50) ret=-1;	
	}
	

//--- Return Ret Valuee ---//
	return(ret);

}

//***//


//+------------------------------------------------------------------+
//|  RSI Exit Signal for Open Order (Ver.0.1.1) -> (Ver.0.2.2)       |
//+------------------------------------------------------------------+
int RSI_ExitSignal(int magic) export
{
//--- Open Position Check ---//
	double pos=VsVCurrentOrders(VSV_OPENPOS, magic);

//--- RSI ---//
	//--- RSI.Live ---//
	double rsil=iRSI(NULL, 0, RSIPeriod, PRICE_CLOSE, 0);

//--- Buy or Sell Exit Signal ---/
	int ret_exit=0;

	//--- Buy ---//
	if(pos<=0 && rsil<40) ret_exit=1;

	//--- Sell ---//
	if(pos>=0 && rsil>60) ret_exit=-1;

//--- Return Ret Valuee ---//
	return(ret_exit);

}

//***//


//+------------------------------------------------------------------+
//|  Sto Entry Signal for Open Order (Ver.0.2.2) -> (Ver.0.2.3)      |
//+------------------------------------------------------------------+
int Sto_EntrySignal(int magic) export
{
//--- Open Position Check ---//
	double pos=VsVCurrentOrders(VSV_OPENPOS, magic);

//--- Stochastic ---//
	//--- Sto.Main.Live ---//
	double stoMainL=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_MAIN, 0);
	//--- Sto.Main.1Before ---//
	double stoMainB=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_MAIN, 1);
	
	//--- Sto.Signal.Live ---//
	double stoSigL=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_SIGNAL, 0);
	//--- Sto.Signal.1Before ---//
	double stoSigB=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_SIGNAL, 1);


//--- Buy or Sell Exit Signal ---/
	int ret_exit=0;

	//--- Buy ---//
	if(pos<=0)
	{
		if(stoMainL<50 && stoMainB<=stoSigB && stoMainL>stoSigL) ret_exit=1;
	}

	//--- Sell ---//
	if(pos>=0)
	{
		if(stoMainL>50 && stoMainB>=stoSigB && stoMainL<stoSigL) ret_exit=-1;
	}

//--- Return Ret Valuee ---//
	return(ret_exit);

}

//***//


//+------------------------------------------------------------------+
//|  Sto Exit Signal for Open Order (Ver.0.2.2) -> (Ver.0.2.3)       |
//+------------------------------------------------------------------+
int Sto_ExitSignal(int magic) export
{
//--- Open Position Check ---//
	double pos=VsVCurrentOrders(VSV_OPENPOS, magic);

//--- Stochastic ---//
	//--- Sto.Main.Live ---//
	double stoMainL=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_MAIN, 0);
	//--- Sto.Main.1Before ---//
	double stoMainB=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_MAIN, 1);
	
	//--- Sto.Signal.Live ---//
	double stoSigL=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_SIGNAL, 0);
	//--- Sto.Signal.1Before ---//
	double stoSigB=iStochastic(NULL, 0, KPeriod, DPeriod, Slowing, MODE_SMA, 0, MODE_SIGNAL, 1);


//--- Buy or Sell Exit Signal ---/
	int ret_exit=0;

	//--- Buy ---//
	if(pos<=0)
	{
		if(stoMainL<50 && stoMainB<=stoSigB && stoMainL>stoSigL) ret_exit=1;
	}

	//--- Sell ---//
	if(pos>=0)
	{
		if(stoMainL>50 && stoMainB>=stoSigB && stoMainL<stoSigL) ret_exit=-1;
	}

//--- Return Ret Valuee ---//
	return(ret_exit);

}


//+------------------------------------------------------------------+