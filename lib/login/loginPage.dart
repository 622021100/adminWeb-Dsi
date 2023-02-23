import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:web_admin/componants/app_colors.dart';
import 'package:web_admin/login/profileModel.dart';
import 'package:web_admin/mainHome.dart';

import '../componants/constant.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final _text = TextEditingController();
  bool passwordVisible = false;

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 25,
                  child: SizedBox(
                    width: 450,
                    height: 600,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          imageTop1(),
                          const SizedBox(
                            height: 25,
                          ),
                          textHeader1(),
                          textHeader2(),
                          const SizedBox(
                            height: 20,
                          ),
                          callLogin(),
                          const SizedBox(
                            height: 20,
                          ),
                          textBottom1(),
                          const SizedBox(
                            height: 2,
                          ),
                          textBottom2(),
                          const SizedBox(
                            height: 25,
                          ),
                          imageBottom(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container lineDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: const Divider(
        indent: 50,
        endIndent: 50,
        thickness: 1,
      ),
    );
  }
  
  Image imageTop1() {
    return Image.asset(
      "assets/images/B.png",
      scale: 7,
    );
  }

  Image imageBottom() {
    return Image.asset(
      "assets/images/dec1.png",
      scale: 12,
    );
  }

  Text textBottom2() {
    return const Text(
      "ส่วนวิเคราะห์ข้อมูลอาชญากรรมและการข่าว",
      style: TextStyle(fontSize: 12),
    );
  }

  Text textBottom1() {
    return const Text(
      "กองเทคโนโลยีและศูนย์ข้อมูลการตรวจสอบ",
      style: TextStyle(fontSize: 12),
    );
  }

  Text textHeader2() {
    return const Text(
      "จัดการข้อมูลการแจ้งเบาะแสทางการข่าว",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12),
    );
  }

  Text textHeader1() {
    return const Text(
      "กรอกอีเมลและรหัสผ่านเพื่อเข้าสู่ระบบ",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12),
    );
  }

  SizedBox callLogin() {
    return SizedBox(
      width: 300,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              username(),
              const SizedBox(
                height: 12,
              ),
              password(),
              const SizedBox(
                height: 25,
              ),
              loginButton()
            ],
          ),
        ),
      ),
    );
  }

  TextFormField password() {
    return TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "กรุณากรอกข้อมูลให้ครบ";
                }
                if (value.length < 6 || value.length > 6) {
                  return "ตรวจสอบรหัสผ่านอีกครั้ง";
                }
              },
              obscureText: _obscureText,
              onSaved: (String? password) {
                profile.password = password!;
              },
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: kAppbar,
                prefixIcon: const Icon(
                  Icons.lock_rounded,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                    onPressed: _toggle,
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: Colors.grey,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide.none),
                hintText: 'รหัสผ่าน',
              ),
            );
  }

  TextFormField username() {
    return TextFormField(
              validator: MultiValidator([
                RequiredValidator(errorText: "กรุณากรอกข้อมูลให้ครบ"),
                EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
              ]),
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? email) {
                profile.email = email!;
              },
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: AppColor.nBlueLite,
                prefixIcon: const Icon(
                  Icons.person_rounded,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide.none),
                hintText: 'อีเมล',
              ),
            );
  }

  SizedBox loginButton() {
    return SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.nBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36)),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: profile.email,
                              password: profile.password)
                          .then((value) {
                        formKey.currentState?.reset();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const MainHome();
                        }));
                      });
                    } on FirebaseAuthException catch (e) {
                      Fluttertoast.showToast(
                          textColor: AppColor.nBlue,
                          msg: e.message!,
                          gravity: ToastGravity.CENTER);
                    }
                  }
                },
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
  }
}
