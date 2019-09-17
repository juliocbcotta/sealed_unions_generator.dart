library sealed_unions_annotations;

class Seal {
  final String generatedName;

  const Seal(this.generatedName) : assert(generatedName != null);
}

class Sealed {
  const Sealed();
}
