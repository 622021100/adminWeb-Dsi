import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:web_admin/mainHome.dart';
import 'package:web_admin/web_admin/componants/constant.dart';
import 'package:web_admin/web_admin/login/profile.dart';
import 'package:web_admin/web_admin/newFloder/common/app_colors.dart';
import 'package:web_admin/web_admin/newFloder/pages/home_page.dart';

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
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          imageTop1(),
                          const SizedBox(
                            height: 12,
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

  Image imageTop2() {
    return Image.asset(
      "assets/images/nameapp.png",
      scale: 12,
    );
  }

  Image imageTop1() {
    return Image.asset(
      "assets/images/logo2.png",
      scale: 7,
    );
  }

  Image imageBottom() {
    return Image.asset(
      "assets/images/dec1.png",
      scale: 8,
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

  // Container buttonLogin() {
  //   return Container(
  //     width: 300,
  //     height: 50,
  //     child: ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: kButton,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
  //         ),
  //         onPressed: () async {
  //           if (formKey.currentState!.validate()) {
  //             formKey.currentState!.save();
  //             try {
  //               await FirebaseAuth.instance
  //                   .signInWithEmailAndPassword(
  //                       email: profile.email, password: profile.password)
  //                   .then((value) {
  //                 formKey.currentState?.reset();
  //                 Navigator.pushReplacement(context,
  //                     MaterialPageRoute(builder: (context) {
  //                   return const MainAdminPage();
  //                 }));
  //               });
  //             } on FirebaseAuthException catch (e) {
  //               Fluttertoast.showToast(
  //                   msg: e.message!, gravity: ToastGravity.CENTER);
  //             }
  //           }
  //         },
  //         child: const Text("เข้าสู่ระบบ")),
  //   );
  // }
  Container callLogin() {
    return Container(
      width: 300,
      key: formKey,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
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
                  fillColor: kAppbar,
                  prefixIcon: const Icon(
                    Icons.person_rounded,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide.none),
                  hintText: 'อีเมล',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "กรุณากรอกข้อมูลให้ครบ";
                  }
                  if (value.length < 6 || value.length > 6) {
                    return "รหัสผ่านไม่ถูกต้อง";
                  }
                },
                // MultiValidator([
                //   RequiredValidator(errorText: "กรุณากรอกข้อมูลให้ครบ"),
                // ]),
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
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.kNavy,
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
                            textColor: AppColor.kBlue,
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
              )
            ],
          ),
        ),
      ),
      // child: Form(
      //   child: Column(
      //     children: [
      //       TextFormField(
      //         validator: MultiValidator([
      //           RequiredValidator(errorText: "กรุณากรอกข้อมูลให้ครบถ้วน"),
      //           EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
      //         ]),
      //         keyboardType: TextInputType.emailAddress,
      //         onSaved: (String? email) {
      //           profile.email = email!;
      //         },
      //         decoration: InputDecoration(
      //           filled: true,
      //           enabled: true,
      //           fillColor: kAppbar,
      //           prefixIcon: const Icon(
      //             Icons.person_rounded,
      //             color: Colors.grey,
      //           ),
      //           border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(36),
      //               borderSide: BorderSide.none),
      //           hintText: 'อีเมล',
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       TextFormField(
      //         validator: MultiValidator([
      //           RequiredValidator(errorText: "กรุณากรอกข้อมูลให้ครบถ้วน"),
      //         ]),
      //         keyboardType: TextInputType.text,
      //         onSaved: (String? password) {
      //           profile.password = password!;
      //         },
      //         obscureText: passwordVisible,
      //         decoration: InputDecoration(
      //           filled: true,
      //           enabled: true,
      //           fillColor: kAppbar,
      //           prefixIcon: const Icon(
      //             Icons.lock_rounded,
      //             color: Colors.grey,
      //           ),
      //           suffixIcon: IconButton(
      //               onPressed: () {
      //                 setState(() {
      //                   passwordVisible = !passwordVisible;
      //                 });
      //               },
      //               icon: Icon(
      //                 passwordVisible
      //                     ? Icons.visibility_rounded
      //                     : Icons.visibility_off_rounded,
      //                 color: Colors.grey,
      //               )),
      //           border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(36),
      //               borderSide: BorderSide.none),
      //           hintText: 'รหัสผ่าน',
      //         ),
      //       ),
      //       const SizedBox(height: 15,),
      //       Container(
      //         width: 300,
      //         height: 50,
      //         child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: kButton,
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(36)),
      //             ),
      //             onPressed: () async {
      //               if (formKey.currentState!.validate()) {
      //                 formKey.currentState!.save();
      //                 try {
      //                   await FirebaseAuth.instance
      //                       .signInWithEmailAndPassword(
      //                           email: profile.email,
      //                           password: profile.password)
      //                       .then((value) {
      //                     formKey.currentState?.reset();
      //                     Navigator.pushReplacement(context,
      //                         MaterialPageRoute(builder: (context) {
      //                       return const HomeAdmin();
      //                     }));
      //                   });
      //                 } on FirebaseAuthException catch (e) {
      //                   Fluttertoast.showToast(
      //                       msg: e.message!, gravity: ToastGravity.CENTER);
      //                 }
      //               }
      //             },
      //             child: const Text("เข้าสู่ระบบ")),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
//   Container buildPassword() {
//     return Container(
//       width: 300,
//       key: formKeypassword,
//       child: TextFormField(
//         keyboardType: TextInputType.text,
//         onSaved: (String? password) {
//           profile.password = password!;
//         },
//         obscureText: passwordVisible,
//         controller: _password,
//         decoration: InputDecoration(
//           filled: true,
//           enabled: true,
//           fillColor: kAppbar,
//           // labelText: 'password',
//           prefixIcon: const Icon(
//             Icons.lock_rounded,
//             color: Colors.grey,
//           ),
//           suffixIcon: IconButton(
//               onPressed: () {
//                 setState(() {
//                   passwordVisible = !passwordVisible;
//                 });
//               },
//               icon: Icon(
//                 passwordVisible
//                     ? Icons.visibility_rounded
//                     : Icons.visibility_off_rounded,
//                 color: Colors.grey,
//               )),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(36),
//               borderSide: BorderSide.none),
//           hintText: 'รหัสผ่าน',
//           errorText: _validatePassword ? 'กรุณากรอกข้อมูลให้ครบถ้วน' : null,
//         ),
//       ),
//     );
//   }
}
