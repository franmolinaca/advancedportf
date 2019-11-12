% Yifan
% Nov 2019

function [portfolioReturn, portfolioVotality, riskfreeRate] = getStrategyOutcome(portfolioPool, tickerLst, w)

% Expected return matrix of the portfolio pool
returnMatrix = zeros(length(tickerLst), 1);

for idx = 1 : length(tickerLst)
	symbol = char(tickerLst(idx));
	returnMatrix(idx, 1) = mean(portfolioPool.(symbol));
end

% Covariance matrix of the  portfolio pool
covMatrix = zeros(length(tickerLst), length(tickerLst));

for row = 1 : length(tickerLst)
	for col = 1 : length(tickerLst)
		symbolRow = char( tickerLst(row) );
		symbolCol = char( tickerLst(col) );

		covRowCol = cov( portfolioPool.(symbolRow), portfolioPool.(symbolCol) );
		covMatrix(row, col) = covRowCol(1, 2);
	end
end

% Calculate strategy outcome
portfolioReturn = sum( w .* returnMatrix );
portfolioVotality = sqrt(w.' * covMatrix * w);
riskfreeRate = mean(portfolioPool.RiskFreeRate);

end
