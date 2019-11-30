% main program for advanced portfolio management
% comparison between sector or country diversified rolling portfolios

% main.m has following components
% 1 define global variable used through the program
% 2 get data on risk-free rate and index return & data prep
% 3 get weight for the tangency portfolio and simulate the investment outcome
% 4 plot
% 5 conclusion

% ============================== Declaration of authorship ============================== %
% We hereby certify that
% We have written the program ourselves except for clearly marked pieces of code 
% We have tested the program and it ran without crashing
% Leonardo Aldeghi, Francisco Molina, Yifan Zhu
% ======================================================================================= %

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

	save main.mat;

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

	% ----- sector 12m ----- %
		fig_sector_12m = figure('Name', 'Sector Diversification 12m', 'NumberTitle', 'off');

		fig_pos = get(gcf, 'Position');
		fig_pos(1) = 0.5 * fig_pos(1); 
		fig_pos(3) = 1.5 * fig_pos(3); 
		set(gcf, 'Position', fig_pos);

		% plot return and sharpe ratio
		subplot(1, 2, 1);

		yyaxis left;
		plot(sectorStratOutcome_12m(1, :));
		ylabel('Annual Return %');
		yyaxis right;
		plot(sectorStratOutcome_12m(4, :));
		ylabel('Sharpe Ratio');
		title('Sector Diversification 12m: Return & Sharpe Ratio');
		xlabel('Investment Period');
		legend('Annual Return', 'Sharpe Ratio');

		% plot weight
		subplot(1, 2, 2);

		bar(sectorPortfolioWeight_12m.', 'stacked');
		ylim([0 1]);
		title('Sector Diversification 12m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(sectorTickerNameLst, 'Location', 'eastoutside');

		saveas(gcf,'Sector_12m.png');

	% ----- country 12m ----- %
		fig_country_12m = figure('Name', 'Country Diversification 12m', 'NumberTitle', 'off');

		fig_pos = get(gcf, 'Position');
		fig_pos(1) = 0.5 * fig_pos(1); 
		fig_pos(3) = 1.5 * fig_pos(3); 
		set(gcf, 'Position', fig_pos);
		
		% plot return and sharpe ratio
		subplot(1, 2, 1);

		yyaxis left;
		plot(countryStratOutcome_12m(1, :));
		ylabel('Annual Return %');
		yyaxis right;
		plot(countryStratOutcome_12m(4, :));
		ylabel('Sharpe Ratio');
		title('Country Diversification 12m: Return & Sharpe Ratio');
		xlabel('Investment Period');
		legend('Annual Return', 'Sharpe Ratio');

		% plot weight
		subplot(1, 2, 2);

		bar(countryPortfolioWeight_12m.', 'stacked');
		ylim([0 1]);
		title('Country Diversification 12m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(countryTickerNameLst, 'Location', 'eastoutside');

		saveas(gcf,'Country_12m.png');

	% ----- sector 3m ----- %
		fig_sector_3m = figure('Name', 'Sector Diversification 3m', 'NumberTitle', 'off');

		fig_pos = get(gcf, 'Position');
		fig_pos(1) = 0.5 * fig_pos(1); 
		fig_pos(3) = 2 * fig_pos(3); 
		set(gcf, 'Position', fig_pos);

		% plot return and sharpe ratio
		subplot(1, 2, 1);

		yyaxis left;
		plot(sectorStratOutcome_3m(1, :));
		ylabel('Annual Return %');
		yyaxis right;
		plot(sectorStratOutcome_3m(4, :));
		ylabel('Sharpe Ratio');
		title('Sector Diversification 3m: Return & Sharpe Ratio');
		xlabel('Investment Period');
		legend('Annual Return', 'Sharpe Ratio');

		% plot weight
		subplot(1, 2, 2);

		bar(sectorPortfolioWeight_3m.', 'stacked');
		ylim([0 1]);
		title('Sector Diversification 3m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(sectorTickerNameLst, 'Location', 'eastoutside');

		saveas(gcf,'Sector_3m.png');

	% ----- country 3m ----- %
		fig_country_3m = figure('Name', 'Country Diversification 3m', 'NumberTitle', 'off');

		fig_pos = get(gcf, 'Position');
		fig_pos(1) = 0.5 * fig_pos(1); 
		fig_pos(3) = 2.0 * fig_pos(3); 
		set(gcf, 'Position', fig_pos);

		% plot return and sharpe ratio
		subplot(1, 2, 1);

		yyaxis left;
		plot(countryStratOutcome_3m(1, :));
		ylabel('Annual Return %');
		yyaxis right;
		plot(countryStratOutcome_3m(4, :));
		ylabel('Sharpe Ratio');
		title('Country Diversification 3m: Return & Sharpe Ratio');
		xlabel('Investment Period');
		legend('Annual Return', 'Sharpe Ratio');

		% plot weight
		subplot(1, 2, 2);

		bar(countryPortfolioWeight_3m.', 'stacked');
		ylim([0 1]);
		title('Country Diversification 3m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(countryTickerNameLst, 'Location', 'eastoutside');

		saveas(gcf,'Country_3m.png');       
	       
	% ----- country & sector 12m ----- %
		fig_countrysector_12m = figure('Name', 'Diversification comparison 12m', 'NumberTitle', 'off');

		fig_pos = get(gcf, 'Position');
		fig_pos(1) = 0.5 * fig_pos(1); 
		fig_pos(3) = 1.5 * fig_pos(3); 
		set(gcf, 'Position', fig_pos);

		% plot return and sharpe ratio
		subplot(2, 2, [1,2]);

		yyaxis left;
		plot(sectorStratOutcome_12m(1, :));
	    hold on
	    plot(countryStratOutcome_12m(1, :));
		ylabel('Annual Return %');
		yyaxis right;
		plot(sectorStratOutcome_12m(4, :));
	    hold on
	    plot(countryStratOutcome_12m(4, :));
		ylabel('Sharpe Ratio');
		title('Sector vs. Country Diversification 12m: Return & Sharpe Ratio');
		xlabel('Investment Period');
		legend('Sector Annual Return','Country Annual Return', 'Sector Sharpe Ratio', 'Country Sharpe Ratio', 'Location', 'eastoutside');

		% plot weight
		subplot(2, 2, 3);

		bar(sectorPortfolioWeight_12m.', 'stacked');
		ylim([0 1]);
		title('Sector Diversification 12m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(sectorTickerNameLst, 'Location', 'eastoutside');
	    
		% plot weight
		subplot(2, 2, 4);

		bar(countryPortfolioWeight_12m.', 'stacked');
		ylim([0 1]);
		title('Country Diversification 12m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(countryTickerNameLst, 'Location', 'eastoutside');
	    
	    saveas(gcf,'CountrySector_12m.png');
	        
	% ----- country & sector 3m ----- %
		fig_countrysector_3m = figure('Name', 'Diversification comparison 3m', 'NumberTitle', 'off');

		fig_pos = get(gcf, 'Position');
		fig_pos(1) = 0.5 * fig_pos(1); 
		fig_pos(3) = 1.5 * fig_pos(3); 
		set(gcf, 'Position', fig_pos);

		% plot return and sharpe ratio
		subplot(2, 2, [1,2]);

		yyaxis left;
		plot(sectorStratOutcome_3m(1, :));
	    hold on
	    plot(countryStratOutcome_3m(1, :));
		ylabel('Annual Return %');
		yyaxis right;
		plot(sectorStratOutcome_3m(4, :));
	    hold on
	    plot(countryStratOutcome_3m(4, :));
		ylabel('Sharpe Ratio');
		title('Sector vs. Country Diversification 3m: Return & Sharpe Ratio');
		xlabel('Investment Period');
		legend('Sector Annual Return','Country Annual Return', 'Sector Sharpe Ratio', 'Country Sharpe Ratio', 'Location', 'eastoutside');

		% plot weight
		subplot(2, 2, 3);

		bar(sectorPortfolioWeight_3m.', 'stacked');
		ylim([0 1]);
		title('Sector Diversification 3m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(sectorTickerNameLst, 'Location', 'eastoutside');
	    
		% plot weight
		subplot(2, 2, 4);

		bar(countryPortfolioWeight_3m.', 'stacked');
		ylim([0 1]);
		title('Country Diversification 3m: Weight of the tangency portfolio');
		xlabel('Investment Period');
		ylabel('Weight');
		legend(countryTickerNameLst, 'Location', 'eastoutside');
	    
	    saveas(gcf,'CountrySector_3m.png');

% =============== 5 CONCLUSION =============== %

	% Calculate average sharpe ratio

	asr_sector_12m = mean(sectorStratOutcome_12m(4, :));
	asr_country_12m = mean(countryStratOutcome_12m(4, :));
	asr_sector_3m = mean(sectorStratOutcome_3m(4, :));
	asr_country_3m = mean(countryStratOutcome_3m(4, :));

