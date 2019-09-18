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
