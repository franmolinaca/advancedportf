% Yifan
% Nov 2019

function returnMatrix = getReturnMatrix(assetPool, tickerNameLst)

% Expected return of the asset pool

returnMatrix = zeros(length(tickerNameLst), 1);

for idx = 1 : length(tickerNameLst)
	symbol = char(tickerNameLst(idx));
	returnMatrix(idx, 1) = mean(assetPool.(symbol));
end

end