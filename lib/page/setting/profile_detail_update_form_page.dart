import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/component/appbar/default_appbar.dart';
import 'package:realtime_chat_app/component/button/default_button.dart';
import 'package:realtime_chat_app/component/getwidget/custom_widget.dart';
import 'package:realtime_chat_app/firebase/firebase_app_service.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class ProfileDetailUpdateFormPage extends StatefulWidget {

  final String title;
  final String currentValue;
  final bool isNameField;

  const ProfileDetailUpdateFormPage({
    super.key,
    required this.title,
    required this.currentValue,
    required this.isNameField
  });

  @override
  State<ProfileDetailUpdateFormPage> createState() => _ProfileDetailUpdateFormPageState();
}

class _ProfileDetailUpdateFormPageState extends State<ProfileDetailUpdateFormPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fieldController.text = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final UserModel user = Provider.of<AppProvider>(context).user!;
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    Future<void> updateProfile() async {

      final newValue = _fieldController.text;

      setState(() {
        isLoading = true;
      });

      if(newValue == '') {

        CustomWidget().showToast(context: context, message: '${widget.title} cant be empty', backgroundColor: theme.colorScheme.onError, trailingIcon: Icons.error);

        setState(() {
          isLoading = false;
        });

        return;
      }

      final lowerCasedField = widget.title.toLowerCase();

      final (isUpdated, message) = await FirebaseAppService().updateUser(userId: user.id, field: lowerCasedField, newValue: newValue);

      if(isUpdated) {

        late UserModel updatedUser;

        if(widget.isNameField){

          updatedUser = user.copyWith(name: newValue);

        }else{

          updatedUser = user.copyWith(bio: newValue);

        }

        print(updatedUser.name);

        appProvider.setUser(updatedUser);

        print('updated username : ${user.name}');

        CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.primary, trailingIcon: Icons.check_circle);

      }else{

        CustomWidget().showToast(context: context, message: message, backgroundColor: theme.colorScheme.onError, trailingIcon: Icons.error);

      }

      setState(() {
        isLoading = false;
      });

      // print(newValue);

    }

    return Scaffold(
      appBar: DefaultAppbar(title: 'Update ${widget.title}'),
      body: BaseLayout(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: <Widget>[
              TextFormField(
                controller: _fieldController,
                decoration: InputDecoration(
                  labelText: widget.title,
                  hintText: 'Enter your ${widget.title}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary
                    )
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                )

              ),
              DefaultButton(
                label: 'Save',
                isLoading: isLoading,
                onPressed: updateProfile
              )
            ],
          ),
        ),
      )
    );
  }
}
