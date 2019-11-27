function returnMatrix = getReturnMatrix(assetPool, tickerNameLst)
% Calculate the return matrix of a portfolio
% 
% Usage: returnMatrix = getReturnMatrix(assetPool, tickerNameLst)
% 
% Inputs:    assetPool ......... Asset Pool
%            tickerNameLst ..... List of ticker names of asset in the pool
% 
% Output:    returnMatrix ......... Return Matrix
% 

% Expected return of the asset pool

returnMatrix = zeros(length(tickerNameLst), 1);

for idx = 1 : length(tickerNameLst)
	symbol = char(tickerNameLst(idx));
	returnMatrix(idx, 1) = mean(assetPool.(symbol));
end

end