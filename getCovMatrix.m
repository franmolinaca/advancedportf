function covMatrix = getCovMatrix(assetPool, tickerNameLst)
% Calculate covariance matrix of a portfolio consisting of asset in a list of tickers
% 
% Usage: covMatrix = getCovMatrix(assetPool, tickerNameLst)
% 
% Inputs:    assetPool 
%            tickerNameLst
% 
% Output:    covMatrix
% 

covMatrix = zeros(length(tickerNameLst), length(tickerNameLst));

for row = 1 : length(tickerNameLst)
	for col = 1 : length(tickerNameLst)
		symbolRow = char( tickerNameLst(row) );
		symbolCol = char( tickerNameLst(col) );

		covRowCol = cov( assetPool.(symbolRow), assetPool.(symbolCol) );
		covMatrix(row, col) = covRowCol(1, 2);
	end
end

end
