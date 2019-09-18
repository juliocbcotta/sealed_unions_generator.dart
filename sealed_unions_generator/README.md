# sealed_unions_generator

Sealed Unions Generator uses basic annotations to generate the boiler plate for your state models.
## How to use

pubspec.yaml of your plugin

```yaml
dependencies:
  sealed_unions_annotations: ^0.0.1
    
    
dev_dependencies:
  build_runner: ^1.6.5
  sealed_unions_generator: ^0.0.1
```

You write this 
```dart
import 'package:sealed_unions_annotations/sealed_unions_annotations.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'weather_model.g.dart';
@Seal('WeatherState')
abstract class WeatherModel {
  @Sealed()
  void initial();
  @Sealed()
  void loading();
  @Sealed()
  void loaded(int temperature);

}
```

You run the command
```shell
flutter pub run build_runner build      
```

and the project writes this:
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// SealedUnionsGenerator
// **************************************************************************

class WeatherState extends Union3Impl<WeatherStateInitial, WeatherStateLoading,
    WeatherStateLoaded> {
  static final Triplet<WeatherStateInitial, WeatherStateLoading,
          WeatherStateLoaded> _factory =
      const Triplet<WeatherStateInitial, WeatherStateLoading,
          WeatherStateLoaded>();

  WeatherState._(
      Union3<WeatherStateInitial, WeatherStateLoading, WeatherStateLoaded>
          union)
      : super(union);

  factory WeatherState.initial() =>
      WeatherState._(_factory.first(WeatherStateInitial()));

  factory WeatherState.loading() =>
      WeatherState._(_factory.second(WeatherStateLoading()));

  factory WeatherState.loaded(int temperature) =>
      WeatherState._(_factory.third(WeatherStateLoaded(temperature)));
}

class WeatherStateInitial {
  WeatherStateInitial();
}

class WeatherStateLoading {
  WeatherStateLoading();
}

class WeatherStateLoaded {
  final int temperature;

  WeatherStateLoaded(this.temperature);
}


```


The command will create `WeatherState` class and that class will have factories to control the state.
You *won't* access your class `WeatherModel`, but the generated one to control the state.
This is a downside of this project and I have not found a solution for this.

Use `WeatherState.initial()`, `WeatherState.loading()` and `WeatherState.loaded(1)` directly as there is no point to hide it
behind `WeatherState` since you will need to use `WeatherState.join(A,B,C)`.
