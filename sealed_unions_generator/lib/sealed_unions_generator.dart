import 'package:build/build.dart';

import 'package:source_gen/source_gen.dart';

import 'src/sealed_unions_generator.dart';




/// Builder used to generate plugin classes.
/// [source_gen] based : https://github.com/dart-lang/source_gen/
Builder sealedUnionsBuilder(BuilderOptions options) => SharedPartBuilder(
    const [SealedUnionsGenerator()], 'sealed_unions_builder');