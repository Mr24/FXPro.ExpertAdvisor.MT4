//+------------------------------------------------------------------+
//|                               VerysVeryInc.MetaTrader4.VsVEA.mq4 |
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
//|                                                          RSI.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.ExpertAdvisor - Ver.0.0.5 Update:2017.02.13"

//--- Define Value ---//
#define MAGICEA 20170213

//--- Initial Value ---//
double AcitvePrice=0.00;
double ActiveLots=0.00;


//--- Inputs ---//
input double DecreaseFactor=3;
input int Slippage=3;


//+------------------------------------------------------------------+
//| Calculate open positions (Ver.0.0.3)                             |
//+------------------------------------------------------------------+
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
//***//


//+------------------------------------------------------------------+
//| Calculate optimal lot size (Ver.0.0.3)                           |
//+------------------------------------------------------------------+
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

//***//


//+------------------------------------------------------------------+
//| Check for open order conditions (Ver.0.0.4)                      |
//+------------------------------------------------------------------+
void CheckForOpen()
{

}

//***//


//+------------------------------------------------------------------+
//| Check for close order conditions (Ver.0.0.5)                     |
//+------------------------------------------------------------------+
void CheckForClose()
{

}

//***//


//+------------------------------------------------------------------+
//| Calculate optimal lot size (Ver.0.0.3)                           |
//+------------------------------------------------------------------+
void OnTick()
{
	// AcitvePrice = AccountBalance(); // (Ver.0.0.2)
	// ActiveLots = MathFloor( AcitvePrice/10 )/100; // 0.14(Ver.0.0.2)
	// ActiveLots = MathFloor( AcitvePrice/100 )/10; // 0.10(Ver.0.0.2)
	// ActiveLots=NormalizeDouble( MathFloor(AccountFreeMargin()/10.0)/100.0, 2 ); // 0.14
	// ActiveLots=NormalizeDouble( MathFloor(AccountFreeMargin()/100.0)/10.0, 2 ); // 0.10
	ActiveLots = LotsOptimized();

	Print( "ActiveLots=", ActiveLots );
	// Print("AcitvePrice=", AcitvePrice); // (Ver.0.0.2);
}

//+------------------------------------------------------------------+