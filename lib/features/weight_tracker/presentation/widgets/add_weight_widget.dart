import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/custom_button.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/custom_input.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/weight_tracker_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/models/weight_model.dart';

class AddWeightWidget extends StatefulWidget {
  const AddWeightWidget({Key? key}) : super(key: key);

  @override
  _AddWeightWidgetState createState() => _AddWeightWidgetState();
}

class _AddWeightWidgetState extends State<AddWeightWidget> {
  GlobalKey<FormState> addWeightFormKey = GlobalKey<FormState>();

  TextEditingController weightCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: addWeightFormKey,
      child: Container(
        height: size.height * 0.25,
        child: Column(
          children: [
            CustomFormInput(
              controller: weightCtrl,
              hint: "Enter Weight",
              label: 'kg',
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
            ),
            BlocConsumer<WeightTrackerBloc, WeightTrackerState>(
                builder: (context, state) {
              if (state is WeightTrackerLoading) {
                return CustomBtn(
                  label: 'Add',
                  onPress: () {},
                  isLoading: true,
                );
              }
              return CustomBtn(
                  label: 'Add',
                  onPress: () {
                    _submit(context);
                  });
            }, listener: (context, state) {
              if (state is WeightTrackerLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Weight added successfully')));
                Navigator.pop(context);
              } else if (state is WeightTrackerError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            })
          ],
        ),
      ),
    );
  }

  _submit(BuildContext context) {
    final FormState form = addWeightFormKey.currentState!;
    if (form.validate()) {
      form.save();
      BlocProvider.of<WeightTrackerBloc>(context).add(AddWeightEvent(
          weight: WeightModel(
              weight: weightCtrl.text,
              timeStamp: Timestamp.fromDate(DateTime.now()))));
    }
  }
}
