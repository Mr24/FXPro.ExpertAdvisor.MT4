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
#property description "VsV.MT4.VsVEA.Library - Ver.0.2.1 Update:2017.02.15"
#property strict

//--- Includes ---//
#include <VsVEA_Library.mqh>

//--- ArrowColor (Ver.0.0.3) ---//
color ArrowColor[6]={Blue, Red, Blue, Red, Blue, Red};


//*** VsV.Order ***//
//+------------------------------------------------------------------+
//| VsVCurrentOrders Function : +Buy,-Sell (Ver.0.0.5)               |
//+------------------------------------------------------------------+
double VsVCurrentOrders(int type, int magic) export
{
	double lots=0.0;

//--- Order Check ---//
	for(int i=0; i<OrdersTotal(); i++)
	{
		if(OrderSelect(i, SELECT_BY_POS)==false) break;
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
				Print( "[CurrentOrdersError] : Illegel Order Type("
					+ IntegerToString(type) +")" );
			break;
		}

		if(lots!=0) break;
	}

//--- Return lots Volume ---//
	return (lots);
}

//***//


//+------------------------------------------------------------------+
//| VsVOrderSend Function : (Ver.0.0.5)                              |
//+------------------------------------------------------------------+
bool VsVOrderSend(int type, double lots, double price, int slippage,
				  double sl, double tp, string comment, int magic) export
{
	price=NormalizeDouble(price, Digits);
	sl=NormalizeDouble(sl,Digits);
	tp=NormalizeDouble(tp,Digits);

	double starttime = GetTickCount();

	while(true)
	{
		if(GetTickCount()-starttime>VsVOrderWaitingTime*1000)
		{
			Alert("OrderSend Timeout. Check the Experts logs!!");
			return(false);
		}

		if(IsTradeAllowed()==true)
		{
			RefreshRates();
			if(OrderSend(Symbol(), type, lots, price, slippage, sl, tp,
				comment, magic, 0, ArrowColor[type])!=-1) return(true);
			int err=GetLastError();
			Print("[OrderSendError] : ", err, " ", ErrorDescription(err));
			
			if(err==ERR_INVALID_PRICE) break;
			if(err==ERR_INVALID_STOPS) break;
		}
		Sleep( 100 );
	}
	return(false);
}

//***//


//+------------------------------------------------------------------+
//| VsVOrderClose Function : (Ver.0.0.5)                             |
//+------------------------------------------------------------------+
double VsVOrderClose(int slippage, int magic) export
{
	int ticket=0;
	int type=OrderType();

	for(int i=0; i<OrdersTotal(); i++)
	{
		if(OrderSelect(i,SELECT_BY_POS)==false) break;
		if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue;

		if(type==OP_BUY || type==OP_SELL)
		{
			ticket=OrderTicket();
			break;
		}
	}
	if(ticket==0) return(false);

	double starttime =GetTickCount();
	while(true)
	{
		if(GetTickCount()-starttime>VsVOrderWaitingTime*1000)
		{
			Alert("OrderClose Timeout. Check the Experts Logs!!");
			return(false);
		}

		if(IsTradeAllowed()==true)
		{
			RefreshRates();
			if(OrderClose(ticket, OrderLots(),
				OrderClosePrice(), slippage, ArrowColor[type])==true) return(true);
			int err=GetLastError();
			Print( "[OrderCloseError] : ", err, " ", ErrorDescription(err) );

			if(err==ERR_INVALID_PRICE) break;
		}
		Sleep( 100 );
	}
	return(false);
}

//***//


//+------------------------------------------------------------------+
//| VsVOrderModify Function : Open Position Only (Ver.0.0.6)         |
//+------------------------------------------------------------------+
bool VsVOrderModify(double sl, double tp, int magic) export
{
	int ticket=0;
	int type=OrderType();

	for(int i=0; i<OrdersTotal(); i++)
	{
		if(OrderSelect(i, SELECT_BY_POS)==false) break;
		if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue;

		if(type==OP_BUY || type==OP_SELL)
		{
			ticket=OrderTicket();
			break;
		}
	}
	if(ticket==0) return(false);

	sl=NormalizeDouble(sl, Digits);
	tp=NormalizeDouble(tp, Digits);

	if(sl==0) sl=OrderStopLoss();
	if(tp==0) tp=OrderTakeProfit();

	if(OrderStopLoss()==sl && OrderTakeProfit()==tp) return(false);

	double starttime=GetTickCount();
	while(true)
	{
		if(GetTickCount()-starttime>VsVOrderWaitingTime*1000)
		{
			Alert("OrderModify Timeout. Check the Experts Logs!!");
			return(false);
		}

		if(IsTradeAllowed()==true)
		{
			if(OrderModify(ticket, 0, sl, tp, 0,
							ArrowColor[type])==true) return(true);
			int err=GetLastError();
			Print( "[OrderModifyError] : ", err, " ", ErrorDescription(err) );

			if(err==ERR_NO_RESULT) break;
			if(err==ERR_INVALID_STOPS) break;
		}
		Sleep( 100 );
	}
	return(false);
}

//***//

//*** Order End ***//


//*** VsV.Calculate ***//
//+------------------------------------------------------------------+
//| Calculate open positions (Ver.0.0.7)                             |
//+------------------------------------------------------------------+
int CalculateCurrentOrders(string Symbol, int magic) export
{
	int buys=0, sells=0;

//--- Current Orders ---//
	for(int i=0; i<OrdersTotal(); i++)
	{
		if(OrderSelect( i, SELECT_BY_POS, MODE_TRADES)==false) break;

		if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
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
//| Calculate optimal lot size (Ver.0.0.8)                           |
//+------------------------------------------------------------------+
double LotsOptimized() export
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

//+------------------------------------------------------------------+