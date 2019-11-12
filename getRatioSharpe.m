% Yifan
% Nov 2019

function ratioSharpe = getRatioSharpe(w, portfolioPool, returnMatrix, covMatrix)

portfolioReturn = sum( w .* returnMatrix );
portfolioVotality = sqrt(w.' * covMatrix * w);

riskfreeRate = mean(portfolioPool.RiskFreeRate);

ratioSharpe = (portfolioReturn - riskfreeRate) / portfolioVotality;

end
