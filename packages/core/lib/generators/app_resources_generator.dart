import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:flutter_gen_core/generators/generator_helper.dart';
import 'package:flutter_gen_core/settings/pubspec.dart';
import 'package:flutter_gen_core/utils/error.dart';

String generateAppResources(File pubspecFile, DartFormatter formatter, FlutterGen flutterGen) {
  // TODO(brads):  add any validation needed here with error messaging prior to generation
  if (flutterGen.appResources == null || flutterGen.appResources?.enabled == false) {
    throw const InvalidSettingsException('The value of "flutter_gen/app_resources" is missing or enabled is set to false.');
  }
  final appResourcesConfig = flutterGen.appResources!;
  final buffer = StringBuffer();
  buffer.writeln(header);
  buffer.writeln(ignore);
  buffer.writeln();
  buffer.writeln('import \'package:common_app_utils/common_app_utils.dart\';');
  buffer.writeln();
  buffer.writeln('class ${appResourcesConfig.className} {');
  // field declarations
  buffer.writeln('static ${appResourcesConfig.className}? _instance;');

  if (appResourcesConfig.generateRuntimeEnv) {
    buffer.write(_writeStaticFinalVariableDeclaration(
      'RuntimeEnvironment',
      'env',
      comment: 'reference to environment variables',
      late: true,
    ));
  }

  if (flutterGen.assets.enabled) {
    buffer.write(_writeStaticFinalVariableDeclaration(
      'AppGraphics',
      'graphics',
      comment: 'graphics resources',
      late: true,
    ));
  }

  if (flutterGen.colors.enabled) {
    buffer.write(
        _writeStaticFinalVariableDeclaration('AppColors', 'colors', comment: 'color resources', varValue: 'AppColors.instance'));
  }

  if (flutterGen.strings != null && flutterGen.strings!.enabled) {
    buffer.write(_writeStaticFinalVariableDeclaration('AppStrings', 'strings',
        comment: 'string resources', varValue: 'AppStrings.instance'));
  }
  // TODO(brads):  add support for - Dimensions, Constants, TextStyles, ...

  buffer.writeln('');
  buffer.writeln('${appResourcesConfig.className}._();');
  buffer.writeln();

  // constructor and method declarations

  buffer.writeln('}');
  return formatter.format(buffer.toString());
}

String _writeStaticFinalVariableDeclaration(
  String varType,
  String varName, {
  String? comment,
  bool late = false,
  String? varValue,
}) {
  final buffer = StringBuffer();
  buffer.writeln('');
  if (comment != null) {
    final escComment = comment.replaceAll("'", r"\'").replaceAll(r'$', r'\$');
    buffer.writeln('/// $escComment');
  }
  final modifiers = (late) ? 'static late final' : 'static final';
  final variable = (varValue == null) ? '$modifiers $varType $varName;' : '$modifiers $varType $varName = $varValue;';
  buffer.writeln(variable);
  return buffer.toString();
}
