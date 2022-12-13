import 'package:flutter/material.dart';

class DropDownHelper extends StatefulWidget {
  const DropDownHelper({Key? key}) : super(key: key);

  @override
  State<DropDownHelper> createState() => _DropDownHelperState();
}

class _DropDownHelperState extends State<DropDownHelper> {
  List dropDownListData = [
    {"title": "BCA", "value": "1"},
    {"title": "MCA", "value": "2"},
    {"title": "B.Tech", "value": "3"},
    {"title": "M.Tech", "value": "4"},
  ];

  String selectedCourseValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            DropdownButton<String>(
              value: selectedCourseValue,
              isDense: true,
              isExpanded: true,
              menuMaxHeight: 350,
              items: [
                const DropdownMenuItem(
                    child: Text(
                      "Select Course",
                    ),
                    value: ""),
                ...dropDownListData.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                      child: Text(e['title']), value: e['value']);
                }).toList(),
              ],
              onChanged: (newValue) {
                setState(
                  () {
                    selectedCourseValue = newValue!;
                    print(selectedCourseValue);
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                contentPadding: const EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCourseValue,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 350,
                  items: [
                    const DropdownMenuItem(
                        child: Text(
                          "Select Course",
                        ),
                        value: ""),
                    ...dropDownListData.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                          child: Text(e['title']), value: e['value']);
                    }).toList(),
                  ],
                  onChanged: (newValue) {
                    setState(
                      () {
                        selectedCourseValue = newValue!;
                        print(selectedCourseValue);
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedCourseValue == "") {
                  print("Please Select a course");
                } else {
                  print("Selected Course Value $selectedCourseValue");
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
