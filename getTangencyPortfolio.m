function w = getTangencyPortfolio(portfolioPool, tickerNameLst)
% Calculate the weight vector for the tangency portfolio of the pool
% 
% Usage:     w = getTangencyPortfolio(portfolioPool, tickerNameLst)
% 
% Inputs:    portfolioPool ... Pool of portfolio
%            tickerNameLst ... List of ticker names of asset in the pool
% 
% Output:    w ............... Weight vector of the tangency portfolio
% 

returnMatrix = getReturnMatrix(portfolioPool, tickerNameLst);

covMatrix = getCovMatrix(portfolioPool, tickerNameLst);

% Construct tangency portfolio
objFun = @(w) getInverseRatioSharpe(w, portfolioPool, returnMatrix, covMatrix);

w0 = [zeros(length(tickerNameLst)-1, 1); 1];

w = fmincon(objFun, w0, ...
	-eye(length(tickerNameLst)), zeros(length(tickerNameLst), 1), ...
	ones(length(tickerNameLst), 1).', 1);

end
