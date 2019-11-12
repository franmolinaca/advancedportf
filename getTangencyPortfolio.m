% Yifan
% Nov 2019

function w = getTangencyPortfolio(portfolioPool, tickerLst)

returnMatrix = getReturnMatrix(portfolioPool, tickerLst);

covMatrix = getCovMatrix(portfolioPool, tickerLst);

% Construct tangency portfolio
objFun = @(w) getRatioSharpe(w, portfolioPool, returnMatrix, covMatrix);

w0 = [zeros(length(tickerLst)-1, 1); 1];

w = fmincon(objFun, w0, ...
	-eye(length(tickerLst)), zeros(length(tickerLst), 1), ...
	ones(length(tickerLst), 1).', 1);

end
