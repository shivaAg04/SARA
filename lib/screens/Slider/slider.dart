import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/apis.dart';
import '../../main.dart';
import '../../model/chat_user.dart';

class SliderControlScreen extends StatefulWidget {
  @override
  State<SliderControlScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<SliderControlScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    APIs.getSliderList();
    super.initState();
  }

  bool isupdated = true;
  TextEditingController one = TextEditingController(text: APIs.SliderList[0]);
  TextEditingController two = TextEditingController(text: APIs.SliderList[1]);
  TextEditingController three = TextEditingController(text: APIs.SliderList[2]);

  TextEditingController four = TextEditingController(text: APIs.SliderList[3]);
  TextEditingController five = TextEditingController(text: APIs.SliderList[4]);

  Future<void> sliderUpdate() async {
    await APIs.firestore.collection('Slider').doc('pic').update({
      'first': one.text,
      'second': two.text,
      'third': three.text,
      'fourth': four.text,
      'fifth': five.text,
    }).then((value) {
      APIs.SliderList[0] = one.text;
      APIs.SliderList[1] = two.text;
      APIs.SliderList[2] = three.text;
      APIs.SliderList[3] = four.text;
      APIs.SliderList[4] = five.text;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Stack(
          children: [
            // The text border
            Text(
              'Slider Screen',
              style: GoogleFonts.josefinSans(
                fontSize: 27,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Color.fromARGB(255, 1, 85, 129),
              ),
            ),

            Text(
              'Slider Screen',
              style: GoogleFonts.josefinSans(
                fontSize: 27,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 102, 0),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      //body
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: mq.height * .03,
              ),
              TextFormField(
                controller: one,
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : "Required Field",
                decoration: InputDecoration(
                  label: const Text("First"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              TextFormField(
                controller: two,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : "Required Field",
                decoration: InputDecoration(
                  label: Text("Second"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              TextFormField(
                controller: three,
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : "Required Field",
                decoration: InputDecoration(
                  label: const Text("Third"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              TextFormField(
                controller: four,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : "Required Field",
                decoration: InputDecoration(
                  label: const Text("Fourth"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              TextFormField(
                controller: five,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : "Required Field",
                decoration: InputDecoration(
                  label: const Text("Fifth"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .04,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(),
                      minimumSize: Size(mq.width * .5, mq.height * .06)),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      setState(() {
                        isupdated = !isupdated;
                      });
                      sliderUpdate().then((value) {
                        setState(() {
                          isupdated = !isupdated;
                        });
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: isupdated
                      ? const Text(
                          "UPDATE",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )
                      : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            backgroundColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        ))
            ]),
          ),
        ),
      ),
    );
  }
}
