// this validator file is for Validating forms when user registers or a business registers.

String nameValidator(value) {
  if (value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String emailValidator(value) {
  bool email = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (email == false) {
    return "Email not valid, enter a real email";
  } else {
    return null;
  }
}

String passwdValidator(value) {
  if (value.length < 6) {
    return 'Password is too short, needs to be at least 6 letters';
  }
  return null;
}

String phoneValidator(value) {
  var potentialNumber = int.tryParse(value);
  if (potentialNumber == null) {
    return 'Enter a phone number';
  }
  return null;
}
