function plotResults(sectorStratOutcome_12m,sectorStratOutcome_3m,countryStratOutcome_12m,countryStratOutcome_3m,...
    sectorPortfolioWeight_12m,sectorPortfolioWeight_3m,countryPortfolioWeight_12m,countryPortfolioWeight_3m,...
    sectorTickerNameLst, countryTickerNameLst)
    % Plot final results

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
        
       
% ----- countrysector 12m ----- %
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
        
        % ----- countrysector 3m ----- %
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
        
        