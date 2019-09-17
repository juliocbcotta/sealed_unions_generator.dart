import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:sealed_unions_annotations/sealed_unions_annotations.dart';
import 'package:source_gen/source_gen.dart';

class SealedUnionsGenerator extends GeneratorForAnnotation<Seal> {
  const SealedUnionsGenerator();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final rootElement = element as ClassElement;
    final sealedMethods = rootElement.methods.where((method) {
      return method.isAbstract &&
          method.isPublic &&
          method.returnType.isVoid &&
          findAnnotation(method.metadata, 'Sealed') != null;
    });

    return declareSeal(rootElement, sealedMethods);
  }

  String declareSeal(
      ClassElement rootElement, Iterable<MethodElement> sealedMethods) {
    final className = rootElement.displayName;
    final generatedClassName = findGeneratedClassName(rootElement.metadata);
    final unions = sealedMethods.map((method) => method.name);
    final sealedClassesNames = sealedMethods
        .map((method) => declareSealedClassName(className, method))
        .join(',');
    final functionalType = getFunctionalTypeForFactory(unions.length);
    final union = 'Union${unions.length}';

    final sealedClasses = sealedMethods.map((method) {
      final methodParameters = declareMethodParams(method.parameters, true);
      final sealedProperties =
          declareSealedPropertiesFromMethodParams(method.parameters);
      final sealedName = declareSealedClassName(className, method);
      return '''
      class $sealedName {
          $sealedProperties
        $sealedName($methodParameters);
      }
      ''';
    }).join('\n');

    int index = 0;
    final factories = sealedMethods.map((method) {
      final methodName = method.displayName;
      final sealedClassName = declareSealedClassName(className, method);
      final methodOrder = declareMethodOrder(index++);
      final methodParameters = declareMethodParams(method.parameters, false);

      final sealedConstructorArguments = method.parameters.map((param) {
        return param.isNamed ? '${param.name} : ${param.name}' : param.name;
      }).join(', ');
      return '''
            factory ${generatedClassName}.$methodName($methodParameters) =>
        ${generatedClassName}._(_factory.$methodOrder($sealedClassName($sealedConstructorArguments)));
      ''';
    }).join('\n');

    return '''class ${generatedClassName} extends ${union}Impl<$sealedClassesNames> {
    static final ${functionalType}<$sealedClassesNames> _factory = const ${functionalType}<$sealedClassesNames>();
      
        ${generatedClassName}._(${union}<$sealedClassesNames> union) : super(union);
      
      $factories

    }
    
    $sealedClasses
    
    ''';
  }

  String getFunctionalTypeForFactory(int length) {
    switch (length) {
      case 0:
        return "Nullet";
      case 1:
        return "Singlet";
      case 2:
        return "Doublet";
      case 3:
        return "Triplet";
      case 4:
        return "Quartet";
      case 5:
        return "Quintet";
      case 6:
        return "Sextet";
      case 7:
        return "Septet";
      case 8:
        return "Octet";
      case 9:
        return "Nonet";
    }
    return "";
  }

  String declareMethodParams(
      List<ParameterElement> parameters, bool constructor) {
    final buffer = StringBuffer();
    final firstNamed =
        parameters.firstWhere((param) => param.isNamed, orElse: () {
      return null;
    });
    final firstOptional = parameters
        .firstWhere((param) => param.isOptionalPositional, orElse: () {
      return null;
    });
    ParameterElement previous = null;
    parameters.forEach((param) {
      if (previous != null && !param.isNamed && previous.isNamed) {
        buffer.writeln('}');
      }
      if (previous != null &&
          !param.isOptionalPositional &&
          previous.isOptionalPositional) {
        buffer.writeln(']');
      }

      if (firstNamed == param) {
        buffer.writeln('{');
      }
      if (firstOptional == param) {
        buffer.writeln('[');
      }

      if (findAnnotation(param.metadata, 'Required') != null) {
        buffer.writeln('@required ');
      }
      if (constructor) {
        buffer.write(' this.${param.displayName} ');
      } else {
        buffer.write(' ${param.type.displayName}  ${param.displayName} ');
      }
      if (param.defaultValueCode != null) {
        buffer.write(' = ' + param.defaultValueCode);
      }
      if (param != parameters.last) {
        buffer.write(', ');
      }
      previous = param;
    });
    if (previous != null && previous.isNamed) {
      buffer.writeln('}');
    }
    if (previous != null && previous.isOptionalPositional) {
      buffer.writeln(']');
    }

    return buffer.toString();
  }

  String declareSealedPropertiesFromMethodParams(
      List<ParameterElement> parameters) {
    return parameters.map((param) {
      final paramName = param.displayName;
      final paramType = param.type.displayName;
      return '''
        final $paramType $paramName;
    ''';
    }).join('\n');
  }

  String declareSealedClassName(String className, MethodElement method) {
    final methodName = method.displayName.replaceAll('_', '');
    return '_' +
        className +
        methodName[0].toUpperCase() +
        methodName.substring(1);
  }

  ElementAnnotation findAnnotation(
      List<ElementAnnotation> metadata, String annotationName) {
    return metadata.firstWhere(
        (annotation) =>
            annotation.computeConstantValue().type.displayName ==
            annotationName,
        orElse: () => null);
  }

  String findGeneratedClassName(List<ElementAnnotation> metadata) {
    final annotation = findAnnotation(metadata, 'Seal');

    return annotation == null
        ? null
        : annotation.constantValue.getField('generatedName').toStringValue();
  }

  String declareMethodOrder(int index) {
    switch (index) {
      case 0:
        return 'first';
      case 1:
        return 'second';
      case 2:
        return 'third';
      case 3:
        return 'fourth';
      case 4:
        return 'fifth';
      case 5:
        return 'sixth';
      case 6:
        return 'seventh';
      case 7:
        return 'eighth';
      case 8:
        return 'ninth';
    }
    return '';
  }
}
