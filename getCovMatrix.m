% Yifan
% Nov 2019

function covMatrix = getCovMatrix(portfolioPool, tickerLst)

% Covariance matrix of the portfolio pool

covMatrix = zeros(length(tickerLst), length(tickerLst));

for row = 1 : length(tickerLst)
	for col = 1 : length(tickerLst)
		symbolRow = char( tickerLst(row) );
		symbolCol = char( tickerLst(col) );

		covRowCol = cov( portfolioPool.(symbolRow), portfolioPool.(symbolCol) );
		covMatrix(row, col) = covRowCol(1, 2);
	end
end

end
