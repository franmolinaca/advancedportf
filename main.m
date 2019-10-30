% Description blabla
%
% fran.mocas@gmail.com, 2019-11-30

% NOTATION: f ... func
disp('Request historical YTD Bitcoin price and plot Close, High and Low');
initDate = '1-Jan-2018';
symbol = 'BTC-USD';
btcusd = getMarketDataViaYahoo(symbol, initDate);
btcusdts = timeseries([btcusd.Close, btcusd.High, btcusd.Low], datestr(btcusd(:,1).Date));
btcusdts.DataInfo.Units = 'USD';
btcusdts.Name = symbol;
plot(btcusdts);
legend({'Close', 'High', 'Low'});