import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskUtils {
  static MaskTextInputFormatter maskFormatterTelefone() =>
      MaskTextInputFormatter(mask: '(##) #?####-####');

  static MaskTextInputFormatter maskFormatterTelefoneOitoDigitos() =>
      MaskTextInputFormatter(
          mask: '(##) ####-####', filter: {"#": RegExp(r'[0-9]')});
}
