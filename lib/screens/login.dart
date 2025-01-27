import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/member/member.dart';
import 'package:quiet_app/screens/sponsor/sponsor.dart';
import 'package:quiet_app/screens/volunteer/volunteer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleForgotPassword() {
    // Implement your logic for handling forgotten password
    if (kDebugMode) {
      print('Forgot password clicked');
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<void> _checkCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, navigate to appropriate page
      String userType = await _getUserType(user.email!);
      _navigateToHome(userType);
    }
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Handle successful login
      if (kDebugMode) {
        print('Login successful: ${userCredential.user}');
      }

      // Determine the type of user
      String userType = await _getUserType(userCredential.user!.email!);
      _navigateToHome(userType);
    } on FirebaseAuthException catch (e) {
      // Handle login error
      if (kDebugMode) {
        print('Login failed: $e');
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.message}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToHome(String userType) async {
    if (userType == 'unknown') {
      // Log the user out if the type is unknown
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed: User type not recognized')),
      );
    } else {
      // Navigate to the appropriate page based on user type
      Widget targetPage;
      if (userType == 'member') {
        targetPage = const MemberMain();
      } else if (userType == 'volunteer') {
        targetPage = const VolunteerMain();
      } else {
        targetPage = const SponsorMain();
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => targetPage),
      );
    }
  }

  Future<String> _getUserType(String email) async {
    // Implement logic to determine user type based on email
    if (email.endsWith('member.quiet.nl')) {
      return 'member';
    } else if (email.endsWith('volunteer.quiet.nl')) {
      return 'volunteer';
    } else if (email.endsWith('sponsor.quiet.nl')) {
      return 'sponsor';
    } else {
      // Handle other types of users or scenarios
      return 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryText,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return loginStack();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Stack loginStack() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -405.0,
          left: -267.0,
          child: Container(
            decoration: const BoxDecoration(
              color: primary,
              shape: BoxShape.circle,
            ),
            width: 750.0,
            height: 750.0,
          ),
        ),
        Positioned(
          top: 180,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Inloggen',
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: secondaryText, fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Welkom terug!',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0,
                        offset: const Offset(0, 3.0),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Gebruikersnaam',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: primaryText,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0,
                        offset: const Offset(0, 3.0),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Wachtwoord',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: _toggle,
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _handleForgotPassword,
                    child: const Text(
                      'Wachtwoord vergeten?',
                      style: TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primary),
                      foregroundColor: WidgetStateProperty.all(primaryText),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryText),
                          )
                        : const Text(
                            'Inloggen',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
