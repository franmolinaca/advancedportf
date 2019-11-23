function excessReturnData = getExcessReturnData(returnData, tickerNameLst, riskfreeRateData)

excessReturnData = join(returnData, riskfreeRateData);

for idx = 1 : length(tickerNameLst)
	symbolName = char(tickerNameLst(idx));
	excessReturnData.(symbolName) = excessReturnData.(symbolName) - excessReturnData.RiskFreeRate;
end

excessReturnData = table2timetable(excessReturnData);

end
