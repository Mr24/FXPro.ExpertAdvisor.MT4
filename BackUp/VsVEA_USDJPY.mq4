//+------------------------------------------------------------------+
//|                        VerysVeryInc.MetaTrader4.VsVEA_USDJPY.mq4 |
//|                  Copyright(c) 2016, VerysVery Inc. & Yoshio.Mr24 |
//|                                         https://github.com/Mr24/ |
//|                                                 Since:2016.09.24 |
//|                                Released under the Apache license |
//|                       https://opensource.org/licenses/Apache-2.0 |
//|                                                            &     |
//+------------------------------------------------------------------+
//|                                                ExportLevels2.mq4 |
//|                      Copyright © 2006, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright(c) 2016 -, VerysVery Inc. && Yoshio.Mr24"
#property link      "https://github.com/VerysVery/"
#property description "VsV.MT4.ExpertAdvisor.VsVEA_USDJPY - Ver.0.11.2 Update:2017.02.25"

//--- Includes ---//
#include <VsVEA_UJ_Lib.mqh>


//--- Define Value (Ver.0.11.2) ---//
#define MAGICEA 20170225
#define COMMENT "VsVEA_USDJPY"


//--- Initial (Ver.0.11.1) ---//
extern int SupportTime, ResistanceTime;
extern double sTime0, sPrice0, SupprotPrice;
extern double rTime0, rPrice0, ResistancePrice;

//+------------------------------------------------------------------+
//|  Entry Signal for Open Order (Ver.0.11.2)       				 |
//+------------------------------------------------------------------+
int USDJPY_EntrySignal(int magic)
// double USDJPY_EntrySignal(int magic)
{
//--- 1. Base.TrendLine ---//
	//*--- Support.Time & Price
	sTime0  = iCustom( NULL, 0, "VsVFX_BL", 5, 0 );
	sPrice0 = iCustom( NULL, 0, "VsVFX_BL", 4, 0 );

	SupportTime  = (int)sTime0;
	SupprotPrice = sPrice0;

	//*--- Resistance.Time & Price
	rTime0  = iCustom( NULL, 0, "VsVFX_BL", 7, 0 );
	rPrice0 = iCustom( NULL, 0, "VsVFX_BL", 6, 0 );

	ResistanceTime  = (int)rTime0;
	ResistancePrice = rPrice0;

	// (OK) 
	// return(SupportTime);
	// return(SupprotPrice);
	return(ResistanceTime);
	// return(ResistancePrice);

}

//***//


//+------------------------------------------------------------------+
//|  Exit Signal for Open Order (Ver.0.11.2)                         |
//+------------------------------------------------------------------+
int USDJPY_ExitSignal(int magic)
{
	return(0);
}

//***//


//+------------------------------------------------------------------+
//| Check for Open Order Conditions (Ver.0.11.2)                     |
//+------------------------------------------------------------------+
void CheckForOpen()
{
//--- Entry Signal ---//
	// int sig_entry = USDJPY_EntrySignal(MAGICEA);
	double sig_entry = USDJPY_EntrySignal(MAGICEA);

//--- Buy Entry ---//
	if(sig_entry>0)
	{
		Print( Time[(int)sig_entry] ); 				  // Check:Time
		// Print( DoubleToStr( sig_entry, Digits ) ); // Check:Price
	}
//--- Sell Entry ---//
	if(sig_entry<0)
	{
		// Print( ... );
	}
}

//***//


//+------------------------------------------------------------------+
//| Check for Close Order Conditions (Ver.0.11.2)                    |
//+------------------------------------------------------------------+
void CheckForClose()
{

}

//***//


//+------------------------------------------------------------------+
//| OnTick Open & Close Order (Ver.0.11.2)                           |
//+------------------------------------------------------------------+
void OnTick()
{
//--- Calculate Open & Close Orders by Current Symbol ---//
	CheckForOpen();
	// if(CalculateCurrentOrders(Symbol(), MAGICEA)==0) CheckForOpen();
	// else 											 CheckForClose();
}

//+------------------------------------------------------------------+