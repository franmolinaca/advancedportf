function [portfolioReturn, portfolioVotality, riskfreeRate, ratioSharpe] = ...
	getStrategyOutcome(investPool, tickerNameLst, w, tradingDays)
% Calculate the investment outcome of the strategy
% 
% Usage:     [portfolioReturn, portfolioVotality, riskfreeRate, ratioSharpe] = 
%            	getStrategyOutcome(investPool, tickerNameLst, w, tradingDays)
% 
% Inputs:    investPool ......... Data of the pool to invest in
%            tickerNameLst ...... Ticker name of the asset in the pool
%            w .................. Weight vector
%            tradingDays ........ Trading days in a year
% 
% Output:    portfolioReturn .... Realized return
% 			 portfolioVotality .. Realized votality
%			 riskfreeRate ....... Risk-Free rate
%            ratioSharpe ........ Sharpe ratio of the outcome
% 

% Expected return matrix of the portfolio pool
returnMatrix = getReturnMatrix(investPool, tickerNameLst);

% Covariance matrix of the  portfolio pool
covMatrix = getCovMatrix(investPool, tickerNameLst);

% Calculate strategy outcome
portfolioReturn = sum( w .* returnMatrix ) * tradingDays;
portfolioVotality = sqrt(w.' * covMatrix * w) * sqrt(tradingDays);
riskfreeRate = mean(investPool.RiskFreeRate) * tradingDays;

ratioSharpe = portfolioReturn / portfolioVotality;

end
