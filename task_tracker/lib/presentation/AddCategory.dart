import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_tracker/bloc/AddCategory.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/presentation/utilities_widgets/ErrorView.dart';
import 'package:task_tracker/presentation/utilities_widgets/LoadingView.dart';
import 'package:task_tracker/utilities/Constants.dart';
import 'package:toast/toast.dart';

import 'list_cards/CategoryCard.dart';

class AddCategory extends StatefulWidget {
  final DataBloc dataBloc;
  AddCategory({this.dataBloc});
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory>
    with SingleTickerProviderStateMixin {
  CategoryViewModel newCategory = CategoryViewModel(
    categoryColor: '0xFFb68a82', // color white
    categoryName: "Untitiled",
  );

  AddCategoryBloc categoryBloc;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BehaviorSubject<bool> needUpdate = BehaviorSubject<bool>();

  TextEditingController _taskNameController =
      TextEditingController(text: 'Untitiled');
  String newColor = '0xFFb68a82';

  @override
  void initState() {
    super.initState();
    _taskNameController.addListener(() {
      newCategory.categoryName = _taskNameController.text;
      print('Sinking');
      needUpdate.sink.add(true);
    });

    categoryBloc = AddCategoryBloc();
    // TODO: implement initState
  }

  void changeColor(Color color) {
    newColor = '${color.value}';
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.APP_COLOR,
          title: Text('New Category'),
        ),
        body: BlocListener(
          bloc: categoryBloc,
          listener: (context, state) {
            if (state is SuccessState) {
              Toast.show(Strings.SAVE_TASK_SUCCESS_MESSAGE, context,
                  duration: 5, gravity: Toast.BOTTOM);
              _taskNameController.clear();
              _taskNameController.clear();

              widget.dataBloc.add(LoadUserData());
              Navigator.of(context).pop();
            } else if (state is FailedState) {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => AlertDialog(
                  elevation: 2,
                  title: Text(Strings.SAVE_TASK_FAILED_MESSAGE),
                  content: ErrorHandleView(),
                ),
              );
            }
          },
          child: BlocBuilder(
            bloc: categoryBloc,
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is CategoryLoading,
                progressIndicator: LoadingView(
                  indicatorColor: Color(int.parse(newCategory.categoryColor)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height,
                    child: Stack(
                      children: <Widget>[
                        cardControls(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: StreamBuilder<bool>(
                            initialData: false,
                            stream: needUpdate,
                            builder: (context, snapshot) {
                              return cardPreview();
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: FloatingActionButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                categoryBloc.add(
                                    CreateCategory(newCategory: newCategory));
                              }
                            },
                            elevation: 5,
                            backgroundColor: Color(int.parse(newColor)),
                            child: Icon(Icons.thumb_up),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  cardPreview() {
    return Container(
      width: 200,
      height: 250,
      child: CategoryCard(
        associatedTasks: 0,
        categoryViewModel: newCategory,
      ),
    );
  }

  cardControls() {
    return Material(
      type: MaterialType.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Category Name'),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 2,
              type: MaterialType.card,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(int.parse(newColor)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    width: 10,
                    height: 50,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (text) {
                          return (text.length > 0)
                              ? null
                              : Strings.REQUIRED_FIELD_ERROR;
                        },
                        controller: _taskNameController,
                        cursorColor: Color(int.parse(newColor)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: Strings.TASK_NAME_HINT,
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Category main color'),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.palette,
                    size: 35,
                    color: Color(int.parse(newColor)),
                  ),
                  label: Text('Color'),
                  onPressed: () => showPicker(),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(int.parse(newColor)),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    needUpdate.close();
    // TODO: implement dispose
    super.dispose();
  }

  showPicker() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: ColorPicker(
            pickerColor: Color(int.parse(newColor)),
            onColorChanged: changeColor,
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() {});
              needUpdate.sink.add(true);
              newCategory.categoryColor = newColor;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
