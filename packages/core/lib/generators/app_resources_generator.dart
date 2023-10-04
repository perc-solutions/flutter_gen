import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:flutter_gen_core/generators/generator_helper.dart';
import 'package:flutter_gen_core/settings/pubspec.dart';

String generateAppResources(
  File pubspecFile,
  DartFormatter formatter,
  FlutterGenAppResources appResourcesConfig,
) {
  // TODO(brads):  add any validation needed here with error messaging prior to validation

  final buffer = StringBuffer();
  buffer.writeln(header);
  buffer.writeln(ignore);
  buffer.writeln();
  buffer.writeln('class ${appResourcesConfig.className} {');
  buffer.writeln('${appResourcesConfig.className}._();');
  buffer.writeln();

  if (appResourcesConfig.generateRuntimeEnv) {
    buffer.write(_writeStaticFinalVariableDeclaration(
      'RuntimeEnvironment',
      'env',
      comment: 'reference to environment variables',
      late: true,
    ));
  }
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
  buffer.writeln('$variable');
  return buffer.toString();
}
