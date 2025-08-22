import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.1.0.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///     :
/// );
abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.blackWhite,
    usedColors: 7,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 4,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 1.0,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 10,
      useM2StyleDividerInM3: true,
      thickBorderWidth: 2.0,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 12,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      alignedDropdown: true,
      appBarScrolledUnderElevation: 8.0,
      drawerElevation: 1.0,
      drawerWidth: 290.0,
      bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
      bottomNavigationBarMutedUnselectedIcon: false,
      searchBarElevation: 1.0,
      searchViewElevation: 1.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarElevation: 1.0,
      navigationBarHeight: 72.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
      navigationRailSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailElevation: 1.0,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colors: FlexColor.schemes[FlexScheme.blackWhite]!.light.defaultError.toDark(
      40,
      false,
    ),
    usedColors: 7,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 10,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 2.0,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 20,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      thickBorderWidth: 2.0,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 48,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      alignedDropdown: true,
      drawerElevation: 1.0,
      drawerWidth: 290.0,
      bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
      bottomNavigationBarMutedUnselectedIcon: false,
      searchBarElevation: 1.0,
      searchViewElevation: 1.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarElevation: 1.0,
      navigationBarHeight: 72.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
      navigationRailSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailElevation: 1.0,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
