import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/widgets/custom_text_form.dart';
import 'package:lms/core/widgets/primary_button.dart';
import 'package:lms/features/trainer/bloc/apply_trainer/apply_trainer_bloc.dart';
import 'package:lms/features/trainer/model/apply_trainer_model.dart';

class ApplyTrainer extends StatefulWidget {
  const ApplyTrainer({super.key});
    static const String routeName = "/trainer-form";


  @override
  State<ApplyTrainer> createState() => _ApplyTrainerState();
}

class _ApplyTrainerState extends State<ApplyTrainer> {
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _expertise = TextEditingController();
  final TextEditingController _experienceYears = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _bio.dispose();
    _expertise.dispose();
    _experienceYears.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apply for trainer")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                Text("Bio", style: TextStyle(fontSize: 24)),
                CustomTextForm(
                  controller: _bio,
                  prefixIcon: Icon(Icons.library_books_sharp),
                ),
                SizedBox(),
                Text("expertise", style: TextStyle(fontSize: 24)),
                CustomTextForm(    
                  controller: _expertise,
                  prefixIcon: Icon(Icons.lightbulb),
                ),
                SizedBox(),
                Text("experienceYears", style: TextStyle(fontSize: 24)),
                CustomTextForm(
                  controller: _experienceYears,
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                SizedBox(),
                SizedBox(),
                BlocBuilder<ApplyTrainerBloc, ApplyTrainerState>(
                  builder: (context, state) {
                    return PrimartButton(
                      lableText: "Apply",
                      onpressed: () {
                        int experienceYears = int.parse(_experienceYears.text);
                        final form = ApplyTrainerModel(
                          bio: _bio.text,
                          expertise: _expertise.text,
                          experienceYears: experienceYears,
                        );
                        context.read<ApplyTrainerBloc>().add(
                          ApplyTrainerEvent(form),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
