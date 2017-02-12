//+------------------------------------------------------------------+
//|                       VerysVeryInc.MetaTrader4.MovingAverege.mq4 |
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
#property description "VsV.MT4.ExpertAdvisor - Ver.0.0.2 Update:2017.02.12"


#define MAGICST 20170213

//--- Initial Value ---//
double AcitvePrice=0.00;
double ActiveLots=0.00;


//--- Inputs ---//


//+------------------------------------------------------------------+
//| Calculate optimal lot size                                       |
//+------------------------------------------------------------------+
void OnTick()
{
	AcitvePrice = AccountBalance();
	// ActiveLots = MathFloor( AcitvePrice/10 )/100; 	// 0.14
	ActiveLots = MathFloor( AcitvePrice/100 )/10;		// 0.10

	Print( "ActiveLots=", ActiveLots );
	// Print("AcitvePrice=", AcitvePrice);
}