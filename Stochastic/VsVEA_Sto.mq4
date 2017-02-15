//+------------------------------------------------------------------+
//|                           VerysVeryInc.MetaTrader4.VsVEA_Sto.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//|                                                            &     |
//+------------------------------------------------------------------+
//|                                                   Stochastic.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.ExpertAdvisor - Ver.0.2.12 Update:2017.02.15"

//--- Includes ---//
#include <VsVEA_Library.mqh>


//--- Define Value ---//
#define MAGICEA 20170213
// #define COMMENT "VsVEA_RSI"	// (Ver.0.1.12)
#define COMMENT "VsVEA_Sto"

//--- Initial Value ---//
double AcitvePrice=0.00;
double ActiveLots=0.00;


//--- Inputs ---//
// input int Slippage=3; // (Ver.0.1.5)


//+------------------------------------------------------------------+
//|  Entry Signal for open order (Ver.0.1.11) -> (Ver.0.1.12)        |
//+------------------------------------------------------------------+
/*
int EntrySignal(int magic)
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

//***/


//+------------------------------------------------------------------+
//|  Exit Signal for open order (Ver.0.1.11) -> (Ver.0.1.12)         |
//+------------------------------------------------------------------+
/*
int ExitSignal(int magic)
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

//***/


//+------------------------------------------------------------------+
//| Check for open order conditions (Ver.0.1.5) -> (Ver.0.1.10)      |
//+------------------------------------------------------------------+
void CheckForOpen()
{
//--- Entry Signal ---//
	int sig_entry=EntrySignal(MAGICEA);


//--- Buy Entry ---//
	if(sig_entry>0)
	{
		// VsVOrderClose(Slippage, MAGICEA); // (ver.0.1.5)
		VsVOrderSend(OP_BUY, LotsOptimized(), Ask, Slippage, 0, 0, COMMENT, MAGICEA);
	}
//--- Sell Entry ---//
	if(sig_entry<0)
	{
		// VsVOrderClose(Slippage, MAGICEA); // (Ver.0.1.5)
		VsVOrderSend(OP_SELL, LotsOptimized(), Bid, Slippage, 0, 0, COMMENT, MAGICEA);
	}
}

//***//


//+------------------------------------------------------------------+
//| Check for close order conditions (Ver.0.1.5) -> (Ver.0.1.11)     |
//+------------------------------------------------------------------+
void CheckForClose()
{
	//--- Exit Signal ---//
	// int sig_entry=EntrySignal(MAGICEA); // (Ver.0.1.5)
	int sig_exit=ExitSignal(MAGICEA);


//--- Buy Exit ---//
	// if(sig_entry>0) // (Ver.0.1.5)
	if(sig_exit>0)
	{
		VsVOrderClose(Slippage, MAGICEA);
	}
//--- Sell Exit ---//
	// if(sig_entry<0) // (Ver.0.1.5)
	if(sig_exit<0)
	{
		VsVOrderClose(Slippage, MAGICEA);
	}
}

//***//


//+------------------------------------------------------------------+
//| Calculate optimal lot size (Ver.0.1.7) -> (Ver.0.1.10)           |
//+------------------------------------------------------------------+
void OnTick()
{
//--- Calculate Open Orders by Current Symbol ---//
	// if(CalculateCurrentOrders(Symbol())==0) CheckForOpen();	// (Ver.0.0.3)
	if(CalculateCurrentOrders(Symbol(), MAGICEA)==0) CheckForOpen();
	// else									CheckForOpen();		// (Ver.0.1.7)
	else									CheckForClose();

}

//+------------------------------------------------------------------+