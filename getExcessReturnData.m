function excessReturnData = getExcessReturnData(returnData, tickerNameLst, riskfreeRateData)
% Calculate the excess return of a portfolio
% 
% Usage: excessReturnData = getExcessReturnData(returnData, tickerNameLst, riskfreeRateData)
% 
% Inputs:    returnData ......... Data of return of the portfolio
%            tickerNameLst ...... List of ticker names of asset in the pool
%            riskfreeRateData ... Data of the risk-free rate
% 
% Output:    excessReturnData ... Data of excess return
% 

excessReturnData = join(returnData, riskfreeRateData);

for idx = 1 : length(tickerNameLst)
	symbolName = char(tickerNameLst(idx));
	excessReturnData.(symbolName) = excessReturnData.(symbolName) - excessReturnData.RiskFreeRate;
end

excessReturnData = table2timetable(excessReturnData);

end
