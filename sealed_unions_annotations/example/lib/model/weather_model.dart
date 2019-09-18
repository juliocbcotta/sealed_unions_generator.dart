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