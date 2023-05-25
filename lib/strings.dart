String widgetCode(String pair){
    String widgetCode = '''
      <!-- TradingView Widget BEGIN -->
      <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0">
      <div class="tradingview-widget-container">
        <div id="tradingview_0345b"></div>
        <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
        <script type="text/javascript">
          new TradingView.widget(
            {
              "autosize": true,
              "symbol": "FX:${pair}",
              "interval": "1",
              "timezone": "Etc/UTC",
              "theme": "dark",
              "style": "1",
              "locale": "en",
              "toolbar_bg": "#f1f3f6",
              "enable_publishing": false,
              "hide_top_toolbar": true,
              "hide_legend": true,
              "save_image": false,
              "container_id": "tradingview_0345b"
            }
          );
        </script>
      </div>
      <!-- TradingView Widget END -->
    ''';
    return widgetCode;
}

String formatCurrencyPair(String currencyPair) {
    if (currencyPair.length == 6) {
        String baseCurrency = currencyPair.substring(0, 3);
        String quoteCurrency = currencyPair.substring(3);
        return '$baseCurrency/$quoteCurrency';
    }
    return currencyPair; // Return the original string if it doesn't match the expected format
}

String formatNumberWithCommas(int number) {
    String numberString = number.toString();
    String formattedString = '';

    for (int i = 0; i < numberString.length; i++) {
        if (i > 0 && (numberString.length - i) % 3 == 0) {
            formattedString += ',';
        }
        formattedString += numberString[i];
    }

    return formattedString;
}

String formatNumber(int number) {
    String numberString = number.toString();
    String formattedString = '';

    int count = 0;
    for (int i = numberString.length - 1; i >= 0; i--) {
        formattedString = numberString[i] + formattedString;
        count++;

        if (count % 3 == 0 && i > 0) {
            formattedString = ' ' + formattedString;
        }
    }

    return formattedString;
}

List<Map> traders = [
    {
        'id': 1,
        'country': '🇺🇸',
        'name': 'Oliver',
        'depo': '\$2367',
        'prof': '\$336755'
    },
    {
        'id': 2,
        'country': '🇨🇦',
        'name': 'Jack',
        'depo': '\$1175',
        'prof': '\$148389'
    },
    {
        'id': 3,
        'country': '🇧🇷',
        'name': 'Harry',
        'depo': '\$1000',
        'prof': '\$113888'
    },
    {
        'id': 4,
        'country': '🇰🇷',
        'name': 'Jacob',
        'depo': '\$999',
        'prof': '\$36755'
    },
    {
        'id': 5,
        'country': '🇩🇪',
        'name': 'Charley',
        'depo': '\$888',
        'prof': '\$18389'
    },
    {
        'id': 6,
        'country': '🇧🇷',
        'name': 'Thomas',
        'depo': '\$777',
        'prof': '\$12000'
    },
    {
        'id': 7,
        'country': '🇫🇷',
        'name': 'George',
        'depo': '\$666',
        'prof': '\$11111'
    },
    {
        'id': 8,
        'country': '🇦🇺',
        'name': 'Oskar',
        'depo': '\$555',
        'prof': '\$9988'
    },
    {
        'id': 9,
        'country': '🇮🇳',
        'name': 'James',
        'depo': '\$444',
        'prof': '\$8877'
    },
    {
        'id': 10,
        'country': '🇪🇸',
        'name': 'William',
        'depo': '\$333',
        'prof': '\$6652'
    },
];