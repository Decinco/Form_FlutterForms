import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FormB extends StatefulWidget {
  const FormB({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormBState();
  }
}

class _FormBState extends State<FormB> {
  String velocity = "Select Options";
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildProgressIndicator() {
    final List<IconData> stepIcons = [
      Icons.person,
      Icons.contact_mail,
      Icons.cloud_upload,
    ];

    final List<String> stepLabels = ['Pers.', 'Contact', 'Upload'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () => _goToStep(index),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor:
                    index <= _currentStep ? Colors.blue : Colors.grey,
                child: Icon(
                  stepIcons[index],
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(stepLabels[index]),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              _buildProgressIndicator(),
              Expanded(
                  child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Text(
                        'Personal',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Pulsi "Contact" o pulsi el botó "Continue"',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => {_goToStep(1)},
                            child: Text("CONTINUE"),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Personal',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Pulsi "Upload" o pulsi el botó "Continue"',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => {_goToStep(2)},
                            child: Text("CONTINUE"),
                          ),
                          TextButton(
                            onPressed: () => {_goToStep(0)},
                            child: Text("CANCEL"),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7.5),
                        child: FormBuilderTextField(
                          name: "email",
                          decoration: InputDecoration(
                            label: Text("Email"),
                            icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.5),
                        child: FormBuilderTextField(
                          name: "address",
                          decoration: InputDecoration(
                            label: Text("Address"),
                            icon: Icon(Icons.house),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.5),
                        child: FormBuilderTextField(
                          name: "phone",
                          decoration: InputDecoration(
                            label: Text("Mobile No"),
                            icon: Icon(Icons.phone),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final formValues = _formKey.currentState!.value;
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Form Results"),
                                          content: Text(formValues.toString()),
                                        ));
                              }
                            },
                            child: Text("CONTINUE"),
                          ),
                          TextButton(
                            onPressed: () => {_goToStep(1)},
                            child: Text("CANCEL"),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ))
            ],
          )),
    );
  }
}
