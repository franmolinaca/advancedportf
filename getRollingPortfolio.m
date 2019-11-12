% Yifan
% Nov 2019

function [tangencyPortfolioWeight, strategyOutcome] = ...
	getRollingPortfolio(excessReturnData, tickerLst, initDate, endDate, ...
						poolSize, investmentTerm)

nrow = length(tickerLst);
ncol = ( round( years( datetime(endDate) - datetime(initDate) ) ) - poolSize ) * 1 / investmentTerm + 1;
tangencyPortfolioWeight = zeros(nrow, ncol);

strategyOutcome = zeros(3, ncol);


% Tangency Portfolio
poolInit = datetime(initDate);
poolEnd = poolInit + years(poolSize);

for idx = 1 : ncol
	portfolioPool = excessReturnData(timerange(poolInit, poolEnd), :);
	
	w = getTangencyPortfolio(portfolioPool, tickerLst);

	tangencyPortfolioWeight(:, idx) = w;

	investInit = poolEnd;
	investEnd = investInit + years(investmentTerm);

	[portfolioReturn, portfolioVotality, riskfreeRate] = getStrategyOutcome(portfolioPool, tickerLst, w);
	strategyOutcome(:, idx) = [portfolioReturn; portfolioVotality; riskfreeRate];

	% Roll portfolio pool forward
	poolInit = poolInit + years(investmentTerm);
	poolEnd = poolInit + years(poolSize);
end

end
