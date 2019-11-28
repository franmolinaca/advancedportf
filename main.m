% main program for Advanced portfolio management comparison between sector
% or country diversified rolling portfolios.

% main.m has following components
% 1 define global variable used through the program
% 2 get data on risk-free rate and index return & data prep
% 3 get weight for the tangency portfolio and simulate the investment outcome
% 4 plot

% =============== 1 GLOBAL VARIABLE =============== %

	% start and end date of the sample
	initDate = '1-Jan-2008';
	endDate = '1-Jan-2019';

	% trading days in a year
	tradingDays = 252.75;

	% size of portfolio optimization pool in years
	poolSize = 4;

	% investment term in years
	investTerm_12m = 1;
	investTerm_3m = 0.25;

	% sector diversification
	sectorTickerLst = {'QQQ', 'VNQ', 'XLF', 'XLV', 'XLP', 'XLU', 'XLE', 'XLI', 'IBB', 'ITA'};
	sectorTickerNameLst = {'QQQ', 'VNQ', 'XLF', 'XLV', 'XLP', 'XLU', 'XLE', 'XLI', 'IBB', 'ITA'};

	% country diversification
	countryTickerLst = {'^N225', '^HSI', '^N100', '^NSEI', 'XMD.TO', '^AXJO', '^GDAXI', '^GSPC'};
	countryTickerNameLst = {'N225', 'HSI', 'N100', 'NSEI', 'XMDTO', 'AXJO', 'GDAXI', 'GSPC'};

% =============== 2 DATA PREP =============== %
	riskfreeRateData = getRiskfreeRateData(initDate, endDate, tradingDays);

	% writetable(riskfreeRateData, 'riskfreeRateData.dat');

	sectorReturnData = getIndexReturnData(sectorTickerLst, sectorTickerNameLst, initDate, endDate);
	countryReturnData = getIndexReturnData(countryTickerLst, countryTickerNameLst, initDate, endDate);

	% writetable(sectorReturnData, 'sectorReturnData.dat');
	% writetable(countryReturnData, 'countryReturnData.dat');

	sectorExcessReturnData = getExcessReturnData(sectorReturnData, ...
		sectorTickerNameLst, riskfreeRateData);
	countryExcessReturnData = getExcessReturnData(countryReturnData, ...
		countryTickerNameLst, riskfreeRateData);

	save main.mat

% =============== 3 INVESTMENT STRATEGY =============== %

	[sectorPortfolioWeight_12m, sectorStratOutcome_12m] = getRollingPortfolio(sectorExcessReturnData, ...
		sectorTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_12m);

	[countryPortfolioWeight_12m, countryStratOutcome_12m] = getRollingPortfolio(countryExcessReturnData, ...
		countryTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_12m);

	[sectorPortfolioWeight_3m, sectorStratOutcome_3m] = getRollingPortfolio(sectorExcessReturnData, ...
		sectorTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_3m);

	[countryPortfolioWeight_3m, countryStratOutcome_3m] = getRollingPortfolio(countryExcessReturnData, ...
		countryTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_3m);

% =============== 6 PLOT =============== %

plotResults(sectorStratOutcome_12m,sectorStratOutcome_3m,countryStratOutcome_12m,countryStratOutcome_3m,...
    sectorPortfolioWeight_12m,sectorPortfolioWeight_3m,countryPortfolioWeight_12m,countryPortfolioWeight_3m,...
    sectorTickerNameLst,countryTickerNameLst)
% Declaration of authorship
% We hereby certify that
% We have written the program ourselves except for clearly marked pieces of code 
% We have tested the program and it ran without crashing
% Leonardo Aldeghi, Francisco Molina, Yifan Zhu
