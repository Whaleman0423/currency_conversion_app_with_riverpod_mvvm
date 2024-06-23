part of './values.dart';

/// 整個 App 的風格資料, 用以簡化程式碼並統一 UI
///
/// * bottomNavigationBarTheme
ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomTransitionBuilder(),
      TargetPlatform.iOS: CustomTransitionBuilder(),
      TargetPlatform.macOS: CustomTransitionBuilder(),
      TargetPlatform.windows: CustomTransitionBuilder(),
      TargetPlatform.linux: CustomTransitionBuilder(),
    },
  ),
);

class CustomTransitionBuilder extends PageTransitionsBuilder {
  const CustomTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 返回沒有轉場特效的頁面
    return child;
  }
}
