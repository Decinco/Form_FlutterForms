import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:intl/intl.dart';

class FormD extends StatefulWidget {
  const FormD({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormDState();
  }
}

class _FormDState extends State<FormD> {
  String velocity = "Select Options";
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  EdgeInsets defaultspacing = EdgeInsets.all(7.5);

  var characters = [
    "Kamisato Ayaka",
    "Jean",
    "Lisa",
    "Barbara",
    "Kaeya",
    "Diluc",
    "Razor",
    "Amber",
    "Venti",
    "Xiangling",
    "Beidou",
    "Xingqiu",
    "Xiao",
    "Ningguang",
    "Klee",
    "Zhongli",
    "Fischl",
    "Bennett",
    "Tartaglia",
    "Noelle",
    "Qiqi",
    "Chongyun",
    "Ganyu",
    "Albedo",
    "Diona",
    "Mona",
    "Keqing",
    "Sucrose",
    "Xinyan",
    "Rosaria",
    "Hu Tao",
    "Kaedehara Kazuha",
    "Yanfei",
    "Yoimiya",
    "Thoma",
    "Eula",
    "Raiden Shogun",
    "Sayu",
    "Sangonomiya Kokomi",
    "Gorou",
    "Kujou Sara",
    "Arataki Itto",
    "Yae Miko",
    "Shikanoin Heizou",
    "Yelan",
    "Kirara",
    "Aloy",
    "Shenhe",
    "Yun Jin",
    "Kuki Shinobu",
    "Kamisato Ayato",
    "Collei",
    "Dori",
    "Tighnari",
    "Nilou",
    "Cyno",
    "Candace",
    "Nahida",
    "Layla",
    "Wanderer",
    "Faruzan",
    "Yaoyao",
    "Alhaitham",
    "Dehya",
    "Mika",
    "Kaveh",
    "Baizhu",
    "Lynette",
    "Lyney",
    "Freminet",
    "Wriothesley",
    "Neuvillette",
    "Charlotte",
    "Furina",
    "Chevreuse",
    "Navia",
    "Gaming",
    "Xianyun",
    "Chiori",
    "Sigewinne",
    "Arlecchino",
    "Sethos",
    "Clorinde",
    "Emilie",
    "Kachina",
    "Kinich",
    "Mualani",
    "Xilonen",
    "Chasca",
    "Ororon",
    "Citlali",
    "Mavuika",
    "Lan Yan"
  ];

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
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
                      child: FormBuilderTypeAhead(
                          name: 'autocomplete',
                          decoration:
                              InputDecoration(label: Text("Autocomplete")),
                          itemBuilder: (context, String character) {
                            return ListTile(title: Text(character));
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.containsElement(characters,
                                errorText: "Invalid character!")
                          ]),
                          suggestionsCallback: (query) {
                            if (query.isNotEmpty) {
                              var lowerCase = query.toLowerCase();
                              return characters.where((character) {
                                return character
                                    .toLowerCase()
                                    .contains(lowerCase);
                              }).toList();
                            } else {
                              return characters;
                            }
                          })),
                  Padding(
                      padding: defaultspacing,
                      child: FormBuilderDateTimePicker(
                          name: "date",
                          decoration:
                              InputDecoration(label: Text("Date Picker")),
                          inputType: InputType.date)),
                  Padding(
                      padding: defaultspacing,
                      child: FormBuilderDateRangePicker(
                          name: "dateRange",
                          decoration:
                              InputDecoration(label: Text("Date Range")),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025))),
                  Padding(
                      padding: defaultspacing,
                      child: FormBuilderDateTimePicker(
                          name: "time",
                          decoration:
                              InputDecoration(label: Text("Time Picker")),
                          inputType: InputType.time)),
                  Padding(
                      padding: defaultspacing,
                      child: FormBuilderFilterChip(
                          name: "filters",
                          spacing: 5.0,
                          decoration:
                              InputDecoration(label: Text("Filter Chips")),
                          options: [
                            FormBuilderChipOption(value: "Dart - Flutter"),
                            FormBuilderChipOption(value: "Java"),
                            FormBuilderChipOption(value: "C#"),
                          ])),
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
