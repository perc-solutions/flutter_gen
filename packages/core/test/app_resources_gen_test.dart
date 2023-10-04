import 'package:test/test.dart';

import 'gen_test_helper.dart';

main() {
  group('Test AppResources generator', () {
    test('AppResources on pubspec.yaml', () async {
      const pubspec = 'test_resources/pubspec_resources_strings_from_yaml.yaml';
      const fact = 'test_resources/actual_data/app_resources-yaml.gen.dart';
      const generated = 'test_resources/lib/gen/app_resources-yaml.gen.dart';

      await expectedAppResourcesGen(pubspec, generated, fact);
    });
  });
}
