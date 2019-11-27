function covMatrix = getCovMatrix(assetPool, tickerNameLst)
% Calculate the covariance matrix of a portfolio
% 
% Usage: covMatrix = getCovMatrix(assetPool, tickerNameLst)
% 
% Inputs:    assetPool ......... Asset Pool
%            tickerNameLst ..... List of ticker names of asset in the pool
% 
% Output:    covMatrix ......... Covariance Matrix
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
