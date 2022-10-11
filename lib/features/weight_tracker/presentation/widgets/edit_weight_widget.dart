import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/custom_button.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/custom_input.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/weight_tracker_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/models/weight_model.dart';

class EditWeightWidget extends StatefulWidget {
  final String existingWeight;
  final String id;
  final Timestamp timestamp;

  const EditWeightWidget(
      {Key? key,
      required this.existingWeight,
      required this.id,
      required this.timestamp})
      : super(key: key);

  @override
  _EditWeightWidgetState createState() => _EditWeightWidgetState();
}

class _EditWeightWidgetState extends State<EditWeightWidget> {
  GlobalKey<FormState> editWeightFormKey = GlobalKey<FormState>();

  TextEditingController weightCtrl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weightCtrl = TextEditingController(text: widget.existingWeight);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: editWeightFormKey,
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
                  label: 'Edit',
                  onPress: () {},
                  isLoading: true,
                );
              }
              return CustomBtn(
                  label: 'Edit',
                  onPress: () {
                    _submit(context, widget.id, widget.timestamp);
                  });
            }, listener: (context, state) {
              if (state is WeightTrackerLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Weight updated successfully')));
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

  _submit(BuildContext context, String id, Timestamp timestamp) {
    final FormState form = editWeightFormKey.currentState!;
    if (form.validate()) {
      form.save();
      BlocProvider.of<WeightTrackerBloc>(context).add(UpdateWeightEvent(
          id: id,
          weight: WeightModel(weight: weightCtrl.text, timeStamp: timestamp)));
    }
  }
}
