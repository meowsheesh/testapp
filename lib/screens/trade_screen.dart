import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_widget.dart';
import 'package:testapp/screens/first_screen.dart';
import 'package:testapp/strings.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  late final PlatformWebViewController controller;

  @override
  void initState() {
    super.initState();
    balance = 10000;
    pair = 'EURUSD';

    controller = PlatformWebViewController(
      WebKitWebViewControllerCreationParams(allowsInlineMediaPlayback: true),
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setPlatformNavigationDelegate(
        PlatformNavigationDelegate(
          const PlatformNavigationDelegateCreationParams(),
        )
          ..setOnProgress((int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          })
          ..setOnPageStarted((String url) {
            debugPrint('Page started loading: $url');
          })
          ..setOnPageFinished((String url) {
            debugPrint('Page finished loading: $url');
          })
          ..setOnWebResourceError((WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          })
          ..setOnNavigationRequest((NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          })
          ..setOnUrlChange((UrlChange change) {
            debugPrint('url change to ${change.url}');
          }),
      )
      ..addJavaScriptChannel(JavaScriptChannelParams(
        name: 'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      ))
      ..setOnPlatformPermissionRequest(
            (PlatformWebViewPermissionRequest request) {
          debugPrint(
            'requesting permissions for ${request.types.map((WebViewPermissionResourceType type) => type.name)}',
          );
          request.grant();
        },
      )
      ..loadHtmlString(widgetCode(pair));
    //
    // // #docregion platform_features
    // if (wcontroller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (wcontroller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
    //
    // controller = wcontroller;
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {});
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            width: 350,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff333749),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffC8C8C8)),
                ),
                Text(
                  formatNumber(balance),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: PlatformWebViewWidget(
                PlatformWebViewWidgetCreationParams(controller: controller),
              ).build(context),
              ),
          NewWidget(controller: controller, notifyParent: refresh, )
        ],
      ),
    );
  }
}
