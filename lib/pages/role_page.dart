import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_ngajar/provider/user_provider.dart';
import 'package:pwa_ngajar/shared/theme.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String password = "bms";
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xff3A6EA5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/rolepage.png',
                height: 260,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Kamu adalah...",
                style: heading1.copyWith(
                    color: whiteColor, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 600,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: whiteColor,
                          title: Text(
                            "Masukkan Password",
                            style: heading3.copyWith(
                                fontWeight: bold, color: darkColor),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                cursorColor: primaryBlue,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryBlue),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: darkColor),
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                          backgroundColor: primaryBlue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        if (passwordController.text ==
                                            password) {
                                          Navigator.pop(context);
                                          print(passwordController.text);
                                          userProvider.setIsGuru(true);
                                          Navigator.pushNamed(context, '/main');
                                        }
                                      },
                                      child: Text(
                                        "Submit",
                                        style: heading4.copyWith(
                                            color: whiteColor),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Guru",
                        style: heading2.copyWith(
                            color: darkColor, fontWeight: bold),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 600,
                child: ElevatedButton(
                    onPressed: () {
                      userProvider.setIsGuru(false);
                      Navigator.pushNamed(context, '/main');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Siswa",
                        style: heading2.copyWith(
                            color: darkColor, fontWeight: bold),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
