class MyValidators {
  static String? DisplayNameValidato(String? DisplayName) {
    if (DisplayName == null || DisplayName.isEmpty) {
      return "Display name can not be empty";
    }
    if (DisplayName.length < 3 || DisplayName.length > 20) {
      return "Display name must be beetween 3 and 20 chactarers";
    }
  }

  // ignore: non_constant_identifier_names
  static String? EmailValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter an Email";
    }
    //!Genel @gmail.com,exmaple ... gibi ifadeler için
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Please enter a valid Email";
    }
    return null;
  }

  static String? PasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter an Password";
    }
    if (value.length < 6) {
      return "Display password must be at least 6 characters long ";
    }
    return null;
  }

  static String? RepeatPasswordValidator(String? value, String? password) {
    if (value != password) {
      return "Password do not match";
    }

    return null;
  }
}
