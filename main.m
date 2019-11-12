% Yifan
% Nov 2019

% =============== GLOBAL VARIABLE =============== %

initDate = '1-Jan-2009';
endDate = '1-Jan-2019';

% Size of portfolio optimization pool
poolSize = 4; % in years

% Investment term
investmentTerm = 1; % in years

tickerLst = {'QQQ', 'VNQ', 'XLF', 'XLV', 'XLP', 'XLU', 'XLE', 'XLI', 'IBB', 'ITA'};    % 'XLC' starts in 2018

% =============== DATA PREP =============== %

excessReturnData = getExcessReturnData(tickerLst, initDate, endDate);

% =============== Investment Strategy =============== %

[tangencyPortfolioWeight, strategyOutcome] = ...
	getRollingPortfolio(excessReturnData, tickerLst, initDate, endDate, ...
						poolSize, investmentTerm);


