% Yifan
% Nov 2019

function returnMatrix = getReturnMatrix(portfolioPool, tickerLst)

% Expected return of the portfolio pool

returnMatrix = zeros(length(tickerLst), 1);

for idx = 1 : length(tickerLst)
	symbol = char(tickerLst(idx));
	returnMatrix(idx, 1) = mean(portfolioPool.(symbol));
end

end