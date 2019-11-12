% Yifan
% Nov 2019

function indexReturn = getIndexReturn(tickerLst, initDate, endDate)

	Date = (datetime(initDate) : datetime(endDate)).';
	indexData = table(Date);

	for idx = 1 : length(tickerLst)
		symbol = char(tickerLst(idx));
		disp(['Fetching data of ', symbol, ' from Yahoo! Finance ...']);
		
		indexInitDate = datestr(datetime(initDate) - 1);
		
		dataFetch = getMarketDataViaYahoo(symbol, indexInitDate);
		dataFetch = dataFetch(:, {'Date', 'AdjClose'});
		dataFetch.Properties.VariableNames = {'Date', symbol};

		indexData = outerjoin(indexData, dataFetch, 'Type', 'left', 'MergeKeys', true);
	end

	indexReturn = rmmissing(indexData);

	for idx = 1 : length(tickerLst)
		symbol = char(tickerLst(idx));
		indexReturn.(symbol)(2:end) = log( indexReturn.(symbol)(2:end) ./ indexReturn.(symbol)(1:end-1) ) .* 100;
	end

	indexReturn(1, :) = [];

	writetable(indexReturn, 'indexReturn.dat');

end