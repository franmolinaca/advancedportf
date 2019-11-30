sfunction [tangencyPortfolioWeight, strategyOutcome] = getRollingPortfolio(excessReturnData, ...
	tickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm)

% Calculate the investment outcome of the strategy
% 
% Usage:     [portfolioReturn, portfolioVotality, riskfreeRate, ratioSharpe] = 
%            	getStrategyOutcome(investPool, tickerNameLst, w, tradingDays)
% 
% Inputs:    excessReturnData ............ Data of excess return
%    		 tickerNameLst ............... List of ticker names used
% 			 initDate .................... Beginning date
%        	 endDate ..................... Ending date
% 			 tradingDays ................. Trading days in a year
%   		 poolSize .................... Size of the portfolio pool in years
%  			 investTerm .................. Term of investment in years
% 
% Output:    tangencyPortfolioWeight ..... Weight of the tangency portfolio
% 			 strategyOutcome ............. Outcome of the investment strategy
% 

% Create tagency-portfolio-weight-matrix and strategy-outcome-matrix
nrow = length(tickerNameLst);
ncol = ( round( years( datetime(endDate) - datetime(initDate) ) ) - poolSize ) / investTerm;

tangencyPortfolioWeight = zeros(nrow, ncol);
strategyOutcome = zeros(4, ncol);

% Tangency Portfolio
poolInit = datetime(initDate);
poolEnd = poolInit + years(poolSize);

for idx = 1 : ncol
	portfolioPool = excessReturnData(timerange(poolInit, poolEnd), :);
	
	w = getTangencyPortfolio(portfolioPool, tickerNameLst);

	tangencyPortfolioWeight(:, idx) = w;

	investInit = poolEnd;
	investEnd = investInit + years(investTerm);

	investPool = excessReturnData(timerange(investInit, investEnd), :);

	[portfolioReturn, portfolioVotality, riskfreeRate, ratioSharpe] = ...
		getStrategyOutcome(investPool, tickerNameLst, w, tradingDays);
    
	strategyOutcome(:, idx) = [portfolioReturn; portfolioVotality; riskfreeRate; ratioSharpe];

	% Roll portfolio pool forward
	poolInit = poolInit + years(investTerm);
	poolEnd = poolInit + years(poolSize);
end

end
