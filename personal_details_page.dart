import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_widgets.dart';
import '../constants/constants.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  bool isEditing = false;

  final user = FirebaseAuth.instance.currentUser;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with user info or default
    nameController.text = 'Juan Dela Cruz';
    emailController.text = user?.email ?? 'No Email';
    phoneController.text = '09125368536';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Text('Personal Details'),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 70, color: Colors.blue),
            ),
            const SizedBox(height: 30),

            // Name
            isEditing
                ? CustomInputField(
                    icon: Icons.person,
                    hint: 'Full Name',
                    controller: nameController,
                  )
                : Text(
                    nameController.text,
                    style: const TextStyle(color: Colors.white, fontSize: 38),
                  ),
            const SizedBox(height: 10),

            // Email
            isEditing
                ? CustomInputField(
                    icon: Icons.email,
                    hint: 'Email',
                    controller: emailController,
                  )
                : Text(
                    emailController.text,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
            const SizedBox(height: 10),

            // Phone
            isEditing
                ? CustomInputField(
                    icon: Icons.phone,
                    hint: 'Phone',
                    controller: phoneController,
                  )
                : Text(
                    phoneController.text,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
            const SizedBox(height: 20),

            // Last Visit Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Color(0xFF0052CC),
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Last Visit',
                        style: TextStyle(
                          color: Color(0xFF0052CC),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'July 26, 2025',
                    style: TextStyle(
                      color: Color(0xFF0052CC),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '14:00 - 15:00',
                    style: TextStyle(
                      color: Color(0xFF0052CC),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Buttons
            isEditing
                ? PrimaryButton(
                    text: 'Save',
                    onPressed: () {
                      setState(() {
                        isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Details updated successfully'),
                        ),
                      );
                    },
                  )
                : PrimaryButton(
                    text: 'Edit Details',
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                  ),
            const SizedBox(height: 10),
            PrimaryButton(
              text: 'Confirm',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
