//+------------------------------------------------------------------+
//|                                             GridOrderManager.mqh |
//|                        Copyright 2018, Alexey Volchanskiy.       |
//|                              https://www.mql5.com/ru/users/vdev/ |
//+------------------------------------------------------------------+
#ifdef __MQL5__
    #include <Trade\Trade.mqh>
#endif
#include <Object.mqh>

class CAvOrder : public CObject
{

#ifdef __MQL4__
protected:
    const   int         m_ticket;
    const   string      m_symbol;
    const   int         m_magic;
    const   int         m_cmd;
    const   datetime    m_openTime;
    const   double      m_openPrice;
    CAvOrder(){ }

    double  m_stoploss;
    double  m_takeProfit;
    datetime m_closeTime;
    double  m_closePrice;
    double  m_profit;
    double  m_swap;
    double  m_comission;
    datetime m_expiration;
    string  m_comment;
    double  m_lot;
public:

    CAvOrder(int ticket, string symbol, int cmd, double lot, double price, datetime openTime, int magic = 0, double stoploss = 0,
        double takeprofit = 0, string comment = NULL, datetime expiration = 0, color arrow_color=CLR_NONE) : 
        m_ticket(ticket), m_symbol(symbol), m_magic(magic), m_cmd(cmd), m_openTime(openTime), m_openPrice(price)
    {
        SetParams(lot, stoploss, takeprofit, comment, expiration);
        #ifdef __MQL5__
            m_positionInfo = new CPositionInfo; 
        #endif
    
    }
    
    ~CAvOrder()
    { 
        #ifdef __MQL5__
            delete m_positionInfo; 
        #endif
    }
    
    bool RefreshAll()
    {
        if(!(Select()))
            return false;
        StopLoss(true);
        TakeProfit(true);
        CloseTime(true);
        ClosePrice(true);
        Profit(true);
        Swap(true);
        Comission(true);
        Expiration(true);
        Comment(true);
        Lots(true);
        return true;
    }
    
    bool Select()
    {
        return OrderSelect(m_ticket, SELECT_BY_TICKET);
    }
    
    double StopLoss(bool reread = false )
    {
        if(reread)
            m_stoploss = OrderStopLoss();
        return m_stoploss;   
    }

    double TakeProfit(bool reread = false )
    {
        if(reread)
            m_takeProfit = OrderTakeProfit();
        return m_takeProfit;   
    }
    
    datetime CloseTime(bool reread = false )
    {
        if(reread)
            m_closeTime = OrderCloseTime();
        return m_closeTime;   
    }

    double ClosePrice(bool reread = false )
    {
        if(reread)
            m_closePrice = OrderClosePrice();
        return m_closePrice;   
    }
    
    double Profit(bool reread = false )
    {
        if(reread)
            m_profit = OrderProfit();
        return m_profit;   
    }
    
    double Swap(bool reread = false )
    {
        if(reread)
            m_swap = OrderSwap();
        return m_swap;   
    }

    double Comission(bool reread = false )
    {
        if(reread)
            m_comission = OrderCommission();
        return m_comission;   
    }

    double Expiration(bool reread = false )
    {
        if(reread)
            m_expiration = OrderClosePrice();
        return m_expiration;   
    }

    double Comment(bool reread = false )
    {
        if(reread)
            m_comment = OrderComment();
        return m_comment;   
    }
    
    double Lots(bool reread = false )
    {
        if(reread)
            m_lot = OrderLots();
        return m_lot;   
    }

    void GetStableParams(int& ticket, string&  symbol, int& magic, int& cmd, datetime& openTime, double& openPrice)
    {
        ticket = m_ticket; 
        symbol = m_symbol;
        magic = m_magic;
        cmd = m_cmd;
        openTime = m_openTime;
        openPrice = m_openPrice;
    }
    
    void SetParams(double lot = 0, double stoploss = 0, double takeprofit = 0, string comment = NULL, datetime expiration = 0)
    {
        m_lot = lot;
        m_stoploss = stoploss;
        m_takeProfit = takeprofit;
        m_comment = comment;
        m_expiration = expiration;
    }

#endif
#ifdef __MQL5__
    CPositionInfo* m_positionInfo;
#endif


};