@TestOn('vm')
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:flutter_gen_core/flutter_generator.dart';
import 'package:flutter_gen_core/generators/app_resources_generator.dart';
import 'package:flutter_gen_core/generators/assets_generator.dart';
import 'package:flutter_gen_core/generators/colors_generator.dart';
import 'package:flutter_gen_core/generators/fonts_generator.dart';
import 'package:flutter_gen_core/generators/strings_generator.dart';
import 'package:flutter_gen_core/settings/config.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

Future<void> clearTestResults() async {}

/// Assets
Future<void> expectedAssetsGen(
    String pubspec, String generated, String fact) async {
  await FlutterGenerator(File(pubspec), assetsName: basename(generated))
      .build();

  final pubspecFile = File(pubspec);
  final config = loadPubspecConfig(pubspecFile);
  final formatter = DartFormatter(
      pageWidth: config.pubspec.flutterGen.lineLength, lineEnding: '\n');

  final actual = generateAssets(
      AssetsGenConfig.fromConfig(pubspecFile, config), formatter);
  final expected =
      formatter.format(File(fact).readAsStringSync().replaceAll('\r\n', '\n'));

  expect(
    File(generated).readAsStringSync(),
    isNotEmpty,
  );
  expect(actual, expected);
}

/// Colors
Future<void> expectedColorsGen(
    String pubspec, String generated, String fact) async {
  await FlutterGenerator(File(pubspec), colorsName: basename(generated))
      .build();

  final pubspecFile = File(pubspec);
  final config = loadPubspecConfig(pubspecFile);
  final formatter = DartFormatter(
      pageWidth: config.pubspec.flutterGen.lineLength, lineEnding: '\n');

  final actual =
      generateColors(pubspecFile, formatter, config.pubspec.flutterGen.colors);
  final expected =
      formatter.format(File(fact).readAsStringSync().replaceAll('\r\n', '\n'));

  expect(
    File(generated).readAsStringSync(),
    isNotEmpty,
  );
  expect(actual, expected);
}

/// Fonts
Future<void> expectedFontsGen(
    String pubspec, String generated, String fact) async {
  await FlutterGenerator(File(pubspec), fontsName: basename(generated)).build();

  final pubspecFile = File(pubspec);
  final config = loadPubspecConfig(pubspecFile);
  final formatter = DartFormatter(pageWidth: config.pubspec.flutterGen.lineLength, lineEnding: '\n');

  final actual = generateFonts(formatter, config.pubspec.flutter.fonts, config.pubspec.flutterGen.fonts);
  final expected = formatter.format(File(fact).readAsStringSync().replaceAll('\r\n', '\n'));

  expect(
    File(generated).readAsStringSync(),
    isNotEmpty,
  );
  expect(actual, expected);
}

/// Strings
Future<void> expectedStringsGen(String pubspec, String generated, String fact) async {
  await FlutterGenerator(File(pubspec), stringsName: basename(generated)).build();

  final pubspecFile = File(pubspec);
  final config = loadPubspecConfig(pubspecFile);
  final formatter = DartFormatter(pageWidth: config.pubspec.flutterGen.lineLength, lineEnding: '\n');

  final actual = generateStrings(pubspecFile, formatter, config.pubspec.flutterGen.strings!);
  final expected = formatter.format(File(fact).readAsStringSync().replaceAll('\r\n', '\n'));

  expect(
    File(generated).readAsStringSync(),
    isNotEmpty,
  );
  expect(actual, expected);
}

/// AppResources
Future<void> expectedAppResourcesGen(String pubspec, String generated, String fact) async {
  await FlutterGenerator(File(pubspec), appResourcesName: basename(generated)).build();

  final pubspecFile = File(pubspec);
  final config = loadPubspecConfig(pubspecFile);
  final formatter = DartFormatter(pageWidth: config.pubspec.flutterGen.lineLength, lineEnding: '\n');

  final actual = generateAppResources(pubspecFile, formatter, config.pubspec.flutterGen);
  // final expected = formatter.format(File(fact).readAsStringSync().replaceAll('\r\n', '\n'));
  print('actual:\n$actual');

  // expect(File(generated).readAsStringSync(), isNotEmpty,);
  // expect(actual, expected);
}
