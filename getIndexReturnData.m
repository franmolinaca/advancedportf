function indexReturnData = getIndexReturnData(tickerLst, tickerNameLst, initDate, endDate)
% Get return data for asset in a list of tickers with initial date and end specified
% 
% Usage: indexReturnData = getIndexReturnData(tickerLst, initDate, endDate)
% 
% Inputs:    tickerLst ......... List of the relevent tickers
%            initDate  ......... Beginning date of the data
%            endDate  .......... Ending date of the data
%
% Output:    indexReturnData ... Data of return of the given index
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

	indexReturnData = rmmissing(indexData);

	for idx = 1 : length(tickerNameLst)
		symbolName = char(tickerNameLst(idx));
		indexReturnData.(symbolName)(2:end) = log( indexReturnData.(symbolName)(2:end) ./ indexReturnData.(symbolName)(1:end-1) ) .* 100;
	end

	indexReturnData(1, :) = [];

end