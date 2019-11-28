function [portfolioReturn, portfolioVotality, riskfreeRate, ratioSharpe] = ...
	getStrategyOutcome(investPool, tickerNameLst, w, tradingDays)

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
