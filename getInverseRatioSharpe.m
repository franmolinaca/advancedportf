function inverseRatioSharpe = getInverseRatioSharpe(w, portfolioPool, returnMatrix, covMatrix)

portfolioReturn = sum( w .* returnMatrix );
portfolioVotality = sqrt(w.' * covMatrix * w);

ratioSharpe = portfolioReturn / portfolioVotality;
inverseRatioSharpe = ratioSharpe * (-1);

end
