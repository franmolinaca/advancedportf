% Yifan
% Nov 2019

function excessReturnData = getExcessReturnData(tickerLst, initDate, endDate)

% Fetch data from web
indexData = getIndexReturn(tickerLst, initDate, endDate);
riskfreeRateData = getRiskfreeRate(initDate, endDate);

% Calculate excess return
excessReturnData = join(indexData, riskfreeRateData);

for idx = 1 : length(tickerLst)
	symbol = char(tickerLst(idx));
	excessReturnData.(symbol) = excessReturnData.(symbol) - excessReturnData.RiskFreeRate;
end

excessReturnData = table2timetable(excessReturnData);

end
