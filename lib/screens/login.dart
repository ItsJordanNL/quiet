import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/member/member.dart';
import 'package:quiet_app/screens/sponsor/sponsor.dart';
import 'package:quiet_app/screens/volunteer/volunteer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleForgotPassword() {
    // Implement your logic for handling forgotten password
    print('Forgot password clicked');
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

Future<void> _login() async {
  setState(() {
    _isLoading = true;
  });
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
    // Handle successful login
    print('Login successful: ${userCredential.user}');
    
    // Determine the type of user
    String userType = await _getUserType(userCredential.user!.email!);
    
    // Navigate to the appropriate page based on user type
    if (userType == 'member') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MemberMain()),
      );
    } else if (userType == 'volunteer') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const VolunteerMain()),
      );
      // Add your navigation logic here
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SponsorMain()),
      );
      // Handle other types of users or scenarios
      // Add your handling logic here
    }
  } on FirebaseAuthException catch (e) {
    // Handle login error
    print('Login failed: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: ${e.message}')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

Future<String> _getUserType(String email) async {
  // Implement logic to determine user type based on email
  // For example, if the email contains "member", return "member"
  // If the email contains "volunteer", return "volunteer"
  if (email.contains('member@quiet.nl')) {
    return 'member';
  } else if (email.contains('volunteer@quiet.nl')) {
    return 'volunteer';
  } else {
    // Handle other types of users or scenarios
    return 'other';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginStack();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Stack LoginStack() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -405.0,
          left: -267.0,
          child: Container(
            decoration: BoxDecoration(
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
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Inloggen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Welkom terug!',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0,
                        offset: Offset(0, 3.0),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Gebruikersnaam',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0,
                        offset: Offset(0, 3.0),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Wachtwoord',
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined),
                        onPressed: _toggle,
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _handleForgotPassword,
                    child: Text(
                      'Wachtwoord vergeten?',
                      style: TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Inloggen',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 134, 168, 39)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
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
