import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/core/ui/vakinha_state.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_button.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_textformfileds.dart';
import 'package:vakinha_burger_mobile/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState
    extends VakinhaState<RegisterPage, RegisterController> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColorDark,
                    ),
                  ),
                  Text('Preencha os campos abaixo para criar seu cadastro',
                      style: context.textTheme.bodyText1),
                  const SizedBox(
                    height: 30,
                  ),
                  VakinhaTextFormField(
                    label: 'Nome',
                    controller: nameController,
                    validator: Validatorless.required('Nome Obrigat´prio'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  VakinhaTextFormField(
                      label: 'E-mail',
                      controller: emailController,
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail Obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ])),
                  const SizedBox(
                    height: 30,
                  ),
                  VakinhaTextFormField(
                    label: 'Senha',
                    obscureText: true,
                    controller: passwordController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha Obrigatório'),
                        Validatorless.min(
                            6, 'Senha deve conter pelo menos 6 caracteres'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  VakinhaTextFormField(
                    label: 'Confirma Senha',
                    obscureText: true,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Confirma Senha Obrigatório'),
                        Validatorless.compare(passwordController,
                            'Senha diferente de confirma senha'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: VakinhaButton(
                      onPressed: () {
                        final formValid =
                            formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          controller.register(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      label: 'CADASTRAR',
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
