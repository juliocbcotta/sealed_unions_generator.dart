// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// SealedUnionsGenerator
// **************************************************************************

class WeatherState extends Union3Impl<_WeatherModelInitial,
    _WeatherModelLoading, _WeatherModelLoaded> {
  static final Triplet<_WeatherModelInitial, _WeatherModelLoading,
          _WeatherModelLoaded> _factory =
      const Triplet<_WeatherModelInitial, _WeatherModelLoading,
          _WeatherModelLoaded>();

  WeatherState._(
      Union3<_WeatherModelInitial, _WeatherModelLoading, _WeatherModelLoaded>
          union)
      : super(union);

  factory WeatherState.initial() =>
      WeatherState._(_factory.first(_WeatherModelInitial()));

  factory WeatherState.loading() =>
      WeatherState._(_factory.second(_WeatherModelLoading()));

  factory WeatherState.loaded(int temperature) =>
      WeatherState._(_factory.third(_WeatherModelLoaded(temperature)));
}

class _WeatherModelInitial {
  _WeatherModelInitial();
}

class _WeatherModelLoading {
  _WeatherModelLoading();
}

class _WeatherModelLoaded {
  final int temperature;

  _WeatherModelLoaded(this.temperature);
}
