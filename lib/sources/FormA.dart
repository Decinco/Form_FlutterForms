import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FormA extends StatefulWidget {
  const FormA({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormAState();
  }
}

class _FormAState extends State<FormA> {
  String velocity = "Select Options";
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();

  var velocityOptions = [
    'High',
    'Medium',
    'Low',
    'Very High',
    'Very Low',
    'Supersonic',
    'Unmoving',
    'Unstoppable Force',
    'Unmovable Object',
    'None of the Above'
  ];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void initState() {
    velocity = velocityOptions.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                initialValue: const {},
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Driving Form',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Test Form',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Please provide the speed of your vehicle',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    FormBuilderRadioGroup(
                        name: 'vehicleSpeed',
                        decoration: InputDecoration(
                            labelText: 'Select one of the options below',
                            labelStyle: TextStyle(color: Colors.grey)),
                        orientation: OptionsOrientation.vertical,
                        options: [
                          FormBuilderFieldOption(value: 'Above 40 km/h'),
                          FormBuilderFieldOption(value: 'Below 40 km/h'),
                          FormBuilderFieldOption(value: '0 km/h')
                        ]),
                    const SizedBox(height: 15),
                    Text(
                      'Enter your remarks',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    FormBuilderTextField(
                      name: 'remarks1',
                      textInputAction: TextInputAction.next,
                      decoration:
                          InputDecoration(labelText: 'Enter your remarks'),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Please provide the high speed of your vehicle',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    FormBuilderDropdown(
                        name: 'highSpeed',
                        decoration: InputDecoration(
                            labelText:
                                'Select one of the options in the dropdown'),
                        items: velocityOptions
                            .map((velocity) => DropdownMenuItem(
                                value: velocity, child: Text(velocity)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            velocity = value ?? "";
                          });
                        }),
                    const SizedBox(height: 15),
                    Text(
                      'Please provide the speed of your vehicle past the first hour',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    FormBuilderCheckboxGroup(
                        name: '1HSpeed',
                        orientation: OptionsOrientation.vertical,
                        decoration: InputDecoration(
                            labelText: 'Select all options that apply',
                            labelStyle: TextStyle(color: Colors.grey)),
                        options: <FormBuilderFieldOption>[
                          FormBuilderFieldOption(value: "20 km/h"),
                          FormBuilderFieldOption(value: "30 km/h"),
                          FormBuilderFieldOption(value: "40 km/h"),
                          FormBuilderFieldOption(value: "50 km/h")
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formValues = _formKey.currentState!.value;
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Form Results"),
                      content: Text(formValues.toString()),
                    ));
          }
        },
        child: Icon(Icons.upload),
        ));
  }
}
