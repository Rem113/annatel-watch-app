import 'package:annatel_app/blocs/add_watch/add_watch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gradient_flat_button.dart';

class AddWatchDialog extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AddWatchDialog(this.scaffoldKey, {Key key}) : super(key: key);

  @override
  _AddWatchDialogState createState() => _AddWatchDialogState();
}

class _AddWatchDialogState extends State<AddWatchDialog> {
  AddWatchBloc _addWatchBloc;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();

  final FocusNode _idNode = FocusNode();
  final FocusNode _vendorNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _addWatchBloc = BlocProvider.of<AddWatchBloc>(context);
  }

  _attemptSubmit() {
    _vendorNode.unfocus();

    _addWatchBloc.add(
      AddWatchAttempt(
        name: _nameController.text,
        id: _idController.text,
        vendor: _vendorController.text,
      ),
    );
  }

  _showErrorSnackbar(String message) {
    widget.scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                message,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline6.fontFamily,
                ),
              ),
              Icon(Icons.done),
            ],
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWatchBloc, AddWatchState>(
      bloc: _addWatchBloc,
      listener: (context, state) {
        if (state.added == true) {
          Navigator.of(context).pop(true);
        }

        if (state.serverError != null) {
          _showErrorSnackbar(state.serverError);
        }
      },
      child: BlocBuilder<AddWatchBloc, AddWatchState>(
          bloc: _addWatchBloc,
          builder: (context, state) {
            return Dialog(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Subscribe to watch",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          errorText: state.nameError,
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => _idNode.requestFocus(),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: "ID",
                          errorText: state.idError,
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => _vendorNode.requestFocus(),
                        focusNode: _idNode,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _vendorController,
                        decoration: InputDecoration(
                          labelText: "Vendor",
                          errorText: state.vendorError,
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: _vendorNode,
                        onEditingComplete: _attemptSubmit,
                      ),
                      SizedBox(height: 16.0),
                      GradientFlatButton(
                        borderRadius: 8.0,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor,
                          ],
                        ),
                        onPressed: _attemptSubmit,
                        text: "Add",
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
