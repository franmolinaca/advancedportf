% Yifan
% Nov 2019

function [tangencyPortfolioWeight, strategyOutcome] = getRollingPortfolio(excessReturnData, ...
	tickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm)

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
	
	wg = getTangencyPortfolio(portfolioPool, tickerNameLst);

	tangencyPortfolioWeight(:, idx) = wg;

	investInit = poolEnd;
	investEnd = investInit + years(investTerm);

	investPool = excessReturnData(timerange(investInit, investEnd), :);

	[portfolioReturn, portfolioVotality, riskfreeRate, ratioSharpe] = ...
		getStrategyOutcome(investPool, tickerNameLst, wg, tradingDays);
    
	strategyOutcome(:, idx) = [portfolioReturn; portfolioVotality; riskfreeRate; ratioSharpe];

	% Roll portfolio pool forward
	poolInit = poolInit + years(investTerm);
	poolEnd = poolInit + years(poolSize);
end

end
