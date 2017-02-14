//+------------------------------------------------------------------+
//|                       VerysVeryInc.MetaTrader4.MovingAverege.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//|                                                            &     |
//+------------------------------------------------------------------+
//|                                                          RSI.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.ExpertAdvisor - Ver.0.1.8 Update:2017.02.14"

//--- Includes ---//
#include <VsVEA_Library.mqh>


//--- Define Value ---//
#define MAGICEA 20170213
#define COMMENT "VsVEA_RSI"

//--- Initial Value ---//
double AcitvePrice=0.00;
double ActiveLots=0.00;


//--- Inputs ---//
// input double DecreaseFactor=3; // (Ver.0.0.1)
input int Slippage=3;
input int RSIPeriod=14;


//+------------------------------------------------------------------+
//| Calculate open positions (Ver.0.0.3) -> (Ver.0.1.7)              |
//+------------------------------------------------------------------+
/*
int CalculateCurrentOrders(string Symbol)
{
	int buys=0, sells=0;

//--- Current Orders ---//
	for(int i=0; i<OrdersTotal(); i++)
	{
		if(OrderSelect( i, SELECT_BY_POS, MODE_TRADES)==false) break;

		if(OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICEA)
		{
			if(OrderType()==OP_BUY) buys++;
			if(OrderType()==OP_SELL) sells++;
		}
	}

//--- Return Orders Volume ---//
	if(buys>0) return(buys);
	else return(-sells);

}
//***/


//+------------------------------------------------------------------+
//| Calculate optimal lot size (Ver.0.0.3) -> (Ver.0.1.8)            |
//+------------------------------------------------------------------+
/*
double LotsOptimized()
{
	double 	lot;
	int 	orders=OrdersHistoryTotal(); // History Orders Total
	int 	losses=0;	// Number of Losses Orders without a break

//--- Select Lot Size ---//
	// lot=NormalizeDouble( AccountFreeMargin()/1000.0, 2 );
	// lot=NormalizeDouble( MathFloor(AccountFreeMargin()/10.0)/100.0, 2 ); // 0.14
	lot=NormalizeDouble( MathFloor(AccountFreeMargin()/100.0)/10.0, 2 ); // 0.10
	// (Test) lot=NormalizeDouble( lot-MathFloor((lot*100.0)*2/DecreaseFactor)/100.0, 2 ); // 0.04

//--- Calculate Number of Losses Orders without a break ---//
	if(DecreaseFactor>0)
	{
		for(int i=orders-1;i>=0;i--)
		{
			if(OrderSelect( i, SELECT_BY_POS, MODE_HISTORY)==false)
			{
				Print( "Error in History!!" );
				break;
			}
			if(OrderSymbol()!=Symbol() || OrderType()>OP_SELL)
				continue;

			//--- OrderProfit() : Order's Net Profit ---//
			if(OrderProfit()>0) break;
			if(OrderProfit()<0) losses++;
		}

		//--- 2 Times Loss : Lot = Lot * (2/3 or 3/3) ---// 
		if(losses>1)
			lot=NormalizeDouble( lot-MathFloor((lot*100.0)*losses/DecreaseFactor)/100.0, 2 ); // 0.04
	}

//--- Return Lot Size ---//
	if(lot<0.01) lot=0.01;
	return(lot);
}

//***/


//+------------------------------------------------------------------+
//|  Entry Signal for open order (Ver.0.1.5)                         |
//+------------------------------------------------------------------+
int EntrySignal(int magic)
{
//--- Open Position Check ---//
	double pos=VsVCurrentOrders(VSV_OPENPOS, MAGICEA);

//--- RSI ---//
	double rsil=iRSI(NULL, 0, RSIPeriod, PRICE_CLOSE, 0);

//--- Buy or Sell Signal ---/
	int ret=0;
	
	//--- Buy ---//
	if(pos<=0 && rsil<30) ret=1;
	//--- Sell ---//
	if(pos>=0 && rsil<70) ret=-1;

//--- Return Ret Valuee ---//
	return(ret);

}

//***//


//+------------------------------------------------------------------+
//| Check for open order conditions (Ver.0.1.5)                      |
//+------------------------------------------------------------------+
void CheckForOpen()
{
//--- EntrySignal ---//
	int sig_entry=EntrySignal(MAGICEA);


//--- Buy Entry ---//
	if(sig_entry>0)
	{
		VsVOrderClose(Slippage, MAGICEA);
		VsVOrderSend(OP_BUY, LotsOptimized(), Ask, Slippage, 0, 0, COMMENT, MAGICEA);
	}
//--- Sell Entry ---//
	if(sig_entry<0)
	{
		VsVOrderClose(Slippage, MAGICEA);
		VsVOrderSend(OP_SELL, LotsOptimized(), Bid, Slippage, 0, 0, COMMENT, MAGICEA);
	}
}

//***//


//+------------------------------------------------------------------+
//| Check for close order conditions (Ver.0.1.5)                     |
//+------------------------------------------------------------------+
void CheckForClose()
{
	//--- EntrySignal ---//
	int sig_entry=EntrySignal(MAGICEA);


//--- Buy Entry ---//
	if(sig_entry>0)
	{
		VsVOrderClose(Slippage, MAGICEA);
	}
//--- Sell Entry ---//
	if(sig_entry<0)
	{
		VsVOrderClose(Slippage, MAGICEA);
	}
}

//***//


//+------------------------------------------------------------------+
//| Calculate optimal lot size (Ver.0.1.5) -> (Ver.0.1.7)            |
//+------------------------------------------------------------------+
void OnTick()
{
//--- Calculate Open Orders by Current Symbol ---//
	// if(CalculateCurrentOrders(Symbol())==0) CheckForOpen(); // (Ver.0.0.3)
	if(CalculateCurrentOrders(Symbol(), MAGICEA)==0) CheckForOpen();
	else									CheckForOpen();
	// else									CheckForClose();

}

//+------------------------------------------------------------------+