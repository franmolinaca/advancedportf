% Yifan
% Nov 2019

% =============== GLOBAL VARIABLE =============== %

% Start and end date of the sample
initDate = '1-Jan-2009';
endDate = '1-Jan-2019';

% Size of portfolio optimization pool in years
poolSize = 4;

% Investment term in years
investmentTerm = 1;

% Sector diversification
tickerLst = {'QQQ', 'VNQ', 'XLF', 'XLV', 'XLP', 'XLU', 'XLE', 'XLI', 'IBB', 'ITA'};    % 'XLC' starts in 2018

% Country diversification


% =============== Investment Strategy =============== %

[tangencyPortfolioWeight, strategyOutcome] = ...
	getRollingPortfolio(tickerLst, initDate, endDate, poolSize, investmentTerm);


