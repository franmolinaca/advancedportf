function inverseRatioSharpe = getInverseRatioSharpe(w, portfolioPool, returnMatrix, covMatrix)
% Calculate the inverse Sharpe ratio of the portfolio
% 
% Usage: inverseRatioSharpe = getInverseRatioSharpe(w, portfolioPool, returnMatrix, covMatrix)
% 
% Inputs:    w ................ Weight vector of the portfolio
% 			 portfolioPool .... The pool of portfolio
%            returnMatrix ..... Return matrix of the portfoilo
%            covMatrix ........ Covariance matrix of the portfolio
% 
% Output:    inverseRatioSharpe ......... The inverse of Sharpe ratio
% 

portfolioReturn = sum( w .* returnMatrix );
portfolioVotality = sqrt(w.' * covMatrix * w);

ratioSharpe = portfolioReturn / portfolioVotality;
inverseRatioSharpe = ratioSharpe * (-1);

end
