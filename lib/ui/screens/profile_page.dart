import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_event.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_state.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:kedatonkomputer/helper/app_consts.dart';
import 'package:kedatonkomputer/helper/shared_preferences.dart';
import 'package:kedatonkomputer/ui/screens/edit_profile.dart';
import 'package:kedatonkomputer/ui/screens/login.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var accountBloc = AuthBloc();
  var isStarting = true;
  AccountModel account;

  @override
  void initState() {
    accountBloc.add(LoadProfileInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: accountBloc,
      listener: (context, state) {
        if(state is ProfileInfoLoaded) {
          setState(() {
            isStarting = false;
            account = state.data;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile")
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: isStarting ? Center(child: LoadingCustom()) : ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    account != null ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(account?.name ?? ""),
                              TextCustom(account?.phoneNumber ?? ""),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings), 
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => EditProfilePage(account: account)
                          )).then((value) => accountBloc.add(LoadProfileInfo()))
                        )
                      ],
                    ) : Container(),
                    Divider(height: 32),
                    Box(
                      borderRadius: 8,
                      borderColor: Colors.grey[300],
                      padding: 16,
                      child: BoldText("Hubungi via Whatsapp"),
                      onPressed: () {
                        var url = Uri(
                          scheme: "https",
                          host: "api.whatsapp.com",
                          path: "send",
                          queryParameters: {
                            "phone": account?.admin ?? ""
                          }
                        );
                        launchURL(url.toString());
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Box(
                  color: Colors.red,
                  padding: 16,
                  borderRadius: 8,
                  boxShadow: [AppBoxShadow.type3],
                  child: TextCustom("Logout", color: Colors.white, textAlign: TextAlign.center),
                  onPressed: () {
                    SharedPreferencesHelper.clear();
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => LoginPage()
                    ));
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}