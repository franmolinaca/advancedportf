function w = getTangencyPortfolio(portfolioPool, tickerNameLst)
% Calculate the weight of tangency portfolio for a given portfolio pool with asset in a list of tickers
% 
% Usage:     w = getTangencyPortfolio(portfolioPool, tickerNameLst)
% Inputs:    portfolioPool 
%            tickerNameLst
% 
% Output:    w
% 

returnMatrix = getReturnMatrix(portfolioPool, tickerNameLst);

covMatrix = getCovMatrix(portfolioPool, tickerNameLst);

% Construct tangency portfolio
objFun = @(w) getRatioSharpe(w, portfolioPool, returnMatrix, covMatrix);

w0 = [zeros(length(tickerNameLst)-1, 1); 1];

w = fmincon(objFun, w0, ...
	-eye(length(tickerNameLst)), zeros(length(tickerNameLst), 1), ...
	ones(length(tickerNameLst), 1).', 1);

end
