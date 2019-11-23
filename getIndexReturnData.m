function indexReturn = getIndexReturnData(tickerLst, tickerNameLst, initDate, endDate)
% Get return data for asset in a list of tickers with initial date and end specified
% 
% Usage: indexReturn = getIndexReturn(tickerLst, initDate, endDate)
% 
% Inputs:    tickerLst
%            initDate
%            endDate
% 
% Output:    indexReturn
% 
	Date = (datetime(initDate) : datetime(endDate)).';
	indexData = table(Date);

	for idx = 1 : length(tickerLst)
		symbol = char(tickerLst(idx));
		symbolName = char(tickerNameLst(idx));
		disp(['Fetching data of ', symbolName, ' from Yahoo! Finance ...']);
		
		indexInitDate = datestr(datetime(initDate) - 1);
		
		dataFetch = getMarketDataViaYahoo(symbol, indexInitDate);
		dataFetch = dataFetch(:, {'Date', 'AdjClose'});
		dataFetch.Properties.VariableNames = {'Date', symbolName};

		indexData = outerjoin(indexData, dataFetch, 'Type', 'left', 'MergeKeys', true);
	end

	indexReturn = rmmissing(indexData);

	for idx = 1 : length(tickerNameLst)
		symbolName = char(tickerNameLst(idx));
		indexReturn.(symbolName)(2:end) = log( indexReturn.(symbolName)(2:end) ./ indexReturn.(symbolName)(1:end-1) ) .* 100;
	end

	indexReturn(1, :) = [];

end