% main program for advanced portfolio management

% main.m has following components
% 1 define global variable used through the program
% 2 call function 'getRollingPortfolio' to get weight, return, and Sharpe ratio of tangency portfolio
% 3 plot

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

% =============== 3 INVESTMENT STRATEGY =============== %

[sectorPortfolioWeight_12m, sectorStratOutcome_12m] = getRollingPortfolio(sectorExcessReturnData, ...
	sectorTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_12m);

[countryPortfolioWeight_12m, countryStratOutcome_12m] = getRollingPortfolio(countryExcessReturnData, ...
	countryTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_12m);

[sectorPortfolioWeight_3m, sectorStratOutcome_3m] = getRollingPortfolio(sectorExcessReturnData, ...
	sectorTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_3m);

[countryPortfolioWeight_3m, countryStratOutcome_3m] = getRollingPortfolio(countryExcessReturnData, ...
	countryTickerNameLst, initDate, endDate, tradingDays, poolSize, investTerm_3m);

% =============== 4 PLOT =============== %

% % sector 12m
% plot(sectorStratOutcome_12m(1, :));
% legend('Annual Return')

% plot(sectorStratOutcome_12m(4, :));
% legend('Sharpe Ratio')

% bar(sectorPortfolioWeight_12m.', 'stacked')
% ylim([0 1])
% legend(sectorTickerNameLst, 'Location', 'eastoutside')

% % country 12m
% plot(countryStratOutcome_12m(1, :));
% legend('Annual Return')

% plot(countryStratOutcome_12m(4, :));
% legend('Sharpe Ratio')

% bar(countryPortfolioWeight_12m.', 'stacked')
% ylim([0 1])
% legend(countryTickerNameLst, 'Location', 'eastoutside')

% % sector 3m
% plot(sectorStratOutcome_3m(1, :));
% legend('Annual Return')

% plot(sectorStratOutcome_3m(4, :));
% legend('Sharpe Ratio')

% bar(sectorPortfolioWeight_3m.', 'stacked')
% ylim([0 1])
% legend(sectorTickerNameLst, 'Location', 'eastoutside')

% % country 3m
% plot(countryStratOutcome_3m(1, :));
% legend('Annual Return')

% plot(countryStratOutcome_3m(4, :));
% legend('Sharpe Ratio')

% bar(countryPortfolioWeight_3m.', 'stacked')
% ylim([0 1])
% legend(countryTickerNameLst, 'Location', 'eastoutside')





