class Validators {
  static isEmpty(String value, String name) {
    if (value.isEmpty) return 'El campo $name no puede estar vacio';
    return null;
  }
}

