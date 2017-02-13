//+------------------------------------------------------------------+
//|                       VerysVeryInc.MetaTrader4.VsVEA_Library.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.VsVEA.Library - Ver.0.0.2 Update:2017.02.13"
#property strict

//--- Includes ---//
#include <VsVEA_Library.mqh>


//+------------------------------------------------------------------+
//| VsVCurrentOrders Function : +Buy,-Sell (Ver.0.0.1)               |
//+------------------------------------------------------------------+
double VsVCurrentOrders(int type, int magic)
{
	double lots=0.0;

//--- Order Check ---//
	for(int i=0; i<OrdersTotal(); i++)
	{
		if(OrderSelect( i, SELECT_BY_POS)==false) break;
		if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue;

		switch(type)
		{
			//--- OPEN : Buy & Sell ---//
			case OP_BUY:
				if(OrderType()==OP_BUY) lots+=OrderLots();
			break;
			case OP_SELL:
				if(OrderType()==OP_SELL)lots-=OrderLots();
			break;

			//--- LIMIT : Buy & Sell --//
			case OP_BUYLIMIT:
				if(OrderType()==OP_BUYLIMIT) lots+=OrderLots();
			break;
			case OP_SELLLIMIT:
				if(OrderType()==OP_SELLLIMIT) lots-=OrderLots();
			break;

			//--- STOP : Buy & Sell --//
			case OP_BUYSTOP:
				if(OrderType()==OP_BUYSTOP) lots+=OrderLots();
			break;
			case OP_SELLSTOP:
				if(OrderType()==OP_SELLSTOP) lots-=OrderLots();
			break;

			//--- VsV.Setup ---//
			//--- VsV.OPEN : Postion (Ver.0.0.2) --//
			case VSV_OPENPOS:
				if(OrderType()==OP_BUY) lots+=OrderLots();
				if(OrderType()==OP_SELL) lots-=OrderLots();
			break;


			//--- Default ---//
			default:
				Print( "[CurrentOrdersError] : Illegel Order Type("+ IntegerToString(type) +")" );
			break;
		}

		if(lots!=0) break;
	}

//--- Return lots Volume ---//
	return (lots);
}

//+------------------------------------------------------------------+