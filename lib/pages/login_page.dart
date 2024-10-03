import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/models/cart.dart';
import 'package:online_shop/models/user.dart';
import 'package:online_shop/admin_pages/admin_page.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:online_shop/pages/signUp_page.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Admin credentials
  final String adminId = "7s7mb4tc-74s2-4sym-sym4-ssfefef7845";
  final String adminUsername = "admin";
  final String adminPassword = "admin";

  LoginPage({super.key});

  void login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final userBox = Hive.box<User>('userBox');
      final user = userBox.get(usernameController.text);

      if (usernameController.text == adminUsername && passwordController.text == adminPassword) {
        user?.isAdmin = false;
        if (user != null) {
          user.isAdmin = true;
          userBox.put(user.username, user);
        } else {
          final newUser = User(
            id: adminId,
            username: adminUsername,
            password: adminPassword,
            isAdmin: true,
          );
          userBox.put(adminUsername, newUser);
        }
        print("Admin logged in ${user?.isAdmin}");

        final loggedInUserBox = await Hive.openBox('loggedInUserBox');
        loggedInUserBox.put('loggedInUsername', adminUsername);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  AdminPage(userId: adminId)),
        );
      } else {
        if (user != null && user.password == passwordController.text) {
          print("User logged in: ${user.username}");

          final loggedInUserBox = await Hive.openBox('loggedInUserBox');
          loggedInUserBox.put('loggedInUsername', user.username);

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                  create: (context) => Cart(user.id),
                  child: HomePage(userId: user.id),
              )
              )
          );
        } else {
          print("Invalid username or password!");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Login'),
      ),
      body: LayoutBuilder(
        builder: (context, constrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              child: IntrinsicHeight(

                // start
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: const Column(
                          children: [
                            // text
                            Text(
                              'Welcome to shop!',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            // username field
                            Form(
                              key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: usernameController,
                                      decoration: const InputDecoration(
                                          labelText: 'Username',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),

                                          // border color when the field is not focused
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white24
                                              )
                                          ),

                                          // border color when the field focused
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                              )
                                          )
                                      ),
                                      validator: (value) {
                                        if(value == null || value.isEmpty) {
                                          return 'Please enter your username';
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    // password field
                                    TextFormField(
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                          labelText: 'Password',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),

                                          // border color when the field is not focused
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white24
                                              )
                                          ),

                                          // border color when the field focused
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                              )
                                          )
                                      ),
                                      validator: (value) {
                                        if(value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                    // "Forgot password?" text
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0, right:16.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            print('Forgot Password Tapped');
                                          },
                                          child: const Text(
                                            'Forgot password?',
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    // login button
                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: ElevatedButton(
                                          onPressed: () => login(context),
                                          child: const Text('LOGIN')
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            const SizedBox(height: 45),
                            const Text('Or Sign Up Using'),
                            // google, vk,


                            // sign up
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('Don\'t have any account?'),
                                    Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle forgot password action here (e.g., navigate to a forgot password screen)
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const SignupPage())
                                          );
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20)
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
