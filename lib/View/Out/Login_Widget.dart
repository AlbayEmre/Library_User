part of "login.dart";

class _EmailTextFormField extends StatelessWidget {
  const _EmailTextFormField({
    super.key,
    required TextEditingController emailController,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
  })  : _emailController = emailController,
        _emailFocusNode = emailFocusNode,
        _passwordFocusNode = passwordFocusNode;

  final TextEditingController _emailController;
  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email Adress",
        prefixIcon: Icon(IconlyLight.message),
      ),
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      validator: (value) {
        return MyValidators.EmailValidator(value);
      },
    );
  }
}

class _PasswordTextFormField extends StatelessWidget {
  _PasswordTextFormField(
      {super.key,
      required TextEditingController passwordController,
      required FocusNode passwordFocusNode,
      required VoidCallback function})
      : _passwordController = passwordController,
        _passwordFocusNode = passwordFocusNode,
        _function = function;

  final TextEditingController _passwordController;
  final FocusNode _passwordFocusNode;
  final VoidCallback _function;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: Icon(IconlyLight.password),
      ),
      onFieldSubmitted: (value) async {
        _function;
      },
      validator: (value) {
        return MyValidators.PasswordValidator(value);
      },
    );
  }
}
