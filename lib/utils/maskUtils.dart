import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskUtils {
  static MaskTextInputFormatter maskFormatterTelefoneNoveDigitos() =>
      MaskTextInputFormatter(
          mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  static MaskTextInputFormatter maskFormatterTelefoneOitoDigitos() =>
      MaskTextInputFormatter(
          mask: '(##) ####-####', filter: {"#": RegExp(r'[0-9]')});
}
