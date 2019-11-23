function riskfreeRateData = getRiskfreeRateData(initDate, endDate, tradingDays)
% Get risk-free rate data for a given time period
% 
% Usage: riskfreeRateData = getRiskfreeRate(initDate, endDate)
% 
% Inputs:    initDate
%            endDate
% 
% Output:    riskfreeRateData
% 

	url = 'https://fred.stlouisfed.org/'; % Federal Reserve Economic Data

	series = 'DTB3'; % 3-month treasury bill secondary market rate

	c = fred(url);
	d = fetch(c,series);
	close(c);

	dDate = datestr(d.Data(:, 1));
	dDate = datetime(dDate);
	dRate = d.Data(:, 2) ./ tradingDays;

	riskfreeRateData = table(dDate, dRate);

	marketDate = (datetime(initDate) : datetime(endDate)).';
	marketDate = table(marketDate);

	riskfreeRateData = outerjoin(marketDate, riskfreeRateData, ...
		'Type', 'left', ...
		'MergeKeys', true, ...
		'LeftKeys', 'marketDate', ...
		'RightKeys', 'dDate');
	riskfreeRateData.Properties.VariableNames = {'Date', 'RiskFreeRate'};

	riskfreeRateData = fillmissing(riskfreeRateData, 'previous');
	riskfreeRateData = fillmissing(riskfreeRateData, 'nearest');

	% writetable(riskfreeRateData, 'riskfreeRateData.dat');

end
