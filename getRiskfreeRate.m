% Yifan
% Nov 2019

function riskfreeRateData = getRiskfreeRate(initDate, endDate)
	series = 'DTB3';
	tradingDays = 252.75;

	url = 'https://fred.stlouisfed.org/';
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

	writetable(riskfreeRateData, 'riskfreeRateData.dat');

end
