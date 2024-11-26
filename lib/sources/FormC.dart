import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FormC extends StatefulWidget {
  const FormC({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormCState();
  }
}

class _FormCState extends State<FormC> {
  String velocity = "Select Options";
  var options = ["optionA", "optionB", "optionC"];
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  EdgeInsets defaultspacing = EdgeInsets.all(7.5);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    var selOption = options.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: defaultspacing,
                    child: FormBuilderChoiceChip(
                        name: "theChipIsMade",
                        spacing: 5.0,
                        decoration:
                            InputDecoration(label: Text("Choice Chips")),
                        options: [
                          FormBuilderChipOption(value: "Dart - Flutter"),
                          FormBuilderChipOption(value: "Java"),
                          FormBuilderChipOption(value: "C#"),
                        ]),
                  ),
                  Padding(
                    padding: defaultspacing,
                    child: FormBuilderSwitch(
                      name: "switch",
                      title: Text("This is a Switch"),
                      decoration: InputDecoration(label: Text("Switch")),
                    ),
                  ),
                  Padding(
                    padding: defaultspacing,
                    child: FormBuilderTextField(
                      name: "text",
                      decoration: InputDecoration(label: Text("Text Field")),
                      autovalidateMode: AutovalidateMode.always,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "This field is required"),
                        FormBuilderValidators.maxLength(15,
                            errorText:
                                "The value must be shorter than 15 characters"),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: defaultspacing,
                    child: FormBuilderDropdown(
                      name: "dropdown",
                      decoration:
                          InputDecoration(label: Text("Dropdown Field")),
                      autovalidateMode: AutovalidateMode.always,
                      items: options
                          .map((selOption) => DropdownMenuItem(
                              value: selOption, child: Text(selOption)))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: defaultspacing,
                    child: FormBuilderRadioGroup(
                      name: "radioGroup",
                      orientation: OptionsOrientation.vertical,
                      decoration: InputDecoration(
                        label: Text("Radio Group")
                      ),
                      options: [
                        FormBuilderFieldOption(value: "Option A"),
                        FormBuilderFieldOption(value: "Option B"),
                        FormBuilderFieldOption(value: "Option C"),
                        FormBuilderFieldOption(value: "Option D"),
                      ],
                    ),
                  )
                ],
              )),
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
