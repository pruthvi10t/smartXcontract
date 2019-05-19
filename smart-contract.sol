pragma solidity 0.4.11;

contract ico{
    
    //Maximum coins available for sale
    uint public max_coins = 1000000;
    
    //Conversion rate USD->coins
    uint public usd_to_coin = 1000;
    
    //Total coins that have been bought by investors
    uint public total_coins_bought = 0;
    
    //mapping from investor to coins
    mapping(address=>uint) equity_coins;
    
    //mapping from investor to USD
    mapping(address=>uint) equity_usd;
    
    
    //Modifier to check the condition
    modifier can_buy_coins(uint usd_invested)
    {
        require(usd_invested*usd_to_coin + total_coins_bought <= max_coins);
        _;
    }
    
    
    //Function to get equity in coins for a given Investor
    function equity_in_coins(address investor) external constant returns(uint)
    {
        return equity_coins[investor];
    }
    
    //Function to get equity in USD for a given Investor
    function equity_in_usd(address investor) external constant returns(uint)
    {
        return equity_usd[investor];
    }
    
    //Function to Buy coins 
    function buy_coins(address investor,uint usd_invested) external can_buy_coins(usd_invested) 
    {
        uint coins_bought = usd_invested*usd_to_coin;
        equity_coins[investor] += coins_bought;
        equity_usd[investor] += equity_coins[investor]/1000;
        total_coins_bought += coins_bought;
    }
    
    //Function to sell coins
    function sell_coins(address investor,uint coins_sold) external
    {
        equity_coins[investor] -= coins_sold;
        equity_usd[investor] -= equity_coins[investor]/1000;
        total_coins_bought -= coins_sold;
    }
}
