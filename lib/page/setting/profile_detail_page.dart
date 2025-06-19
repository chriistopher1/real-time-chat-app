
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat_app/client/HelperFunction.dart';
import 'package:realtime_chat_app/component/appbar/default_appbar.dart';
import 'package:realtime_chat_app/component/setting/profile_detail_card.dart';
import 'package:realtime_chat_app/layout/base-layout.dart';
import 'package:realtime_chat_app/model/user_model.dart';
import 'package:realtime_chat_app/provider/app_provider.dart';

class ProfileDetail extends StatelessWidget{

  const ProfileDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<AppProvider>(context).user!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: DefaultAppbar(title: 'Profile'),
      body: BaseLayout(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(user.profileImgUrl)
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () async {
                        final pickedImage = await HelperFunction.pickImageFromGallery();
                        // Use your pickedImage here
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              ProfileDetailCard(
                icon: Icons.person_outline,
                fieldTitle: 'Name',
                data: user.name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/profile-detail/update',
                    arguments: {
                      'title' : 'Name',
                      'currentValue' : user.name,
                      'isNameField': true
                    }
                  );
                },
              ),
              ProfileDetailCard(
                icon: Icons.info_outline,
                fieldTitle: 'Bio',
                data: user.bio,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/profile-detail/update',
                    arguments: {
                      'title': 'Bio',
                      'currentValue': user.bio,
                      'isNameField': false
                    }
                  );
                },
              ),
              ProfileDetailCard(
                icon: Icons.call_outlined,
                fieldTitle: 'Phone',
                data: user.phone,
                onTap: (){

                },
              )
            ],
          ),
        ),
      ),
    );
  }

}