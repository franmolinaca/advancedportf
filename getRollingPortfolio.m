% Yifan
% Nov 2019

function [tangencyPortfolioWeight, strategyOutcome] = ...
	getRollingPortfolio(tickerLst, initDate, endDate, poolSize, investmentTerm)

% Fetch data from web
indexData = getIndexReturn(tickerLst, initDate, endDate);
riskfreeRateData = getRiskfreeRate(initDate, endDate);

% Calculate excess return
excessReturnData = join(indexData, riskfreeRateData);

for idx = 1 : length(tickerLst)
	symbol = char(tickerLst(idx));
	excessReturnData.(symbol) = excessReturnData.(symbol) - excessReturnData.RiskFreeRate;
end

excessReturnData = table2timetable(excessReturnData);

% Create tagency-portfolio-weight-matrix and strategy-outcome-matrix

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
