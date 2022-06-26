import 'package:flutter/material.dart';
import 'package:pass_store/provider/home.dart';
import 'package:pass_store/utils/hero_dialog_route.dart';
import 'package:pass_store/utils/theme_data.dart';
import 'package:provider/provider.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddItemPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddItemButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddItemButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _AddItemPopupCard();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class _AddItemPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  _AddItemPopupCard({Key? key}) : super(key: key);
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: AppColors.cardColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Account Info",
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account',
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2.5,
                                color: const Color.fromRGBO(236, 235, 240, 1),
                              ),
                            ),
                            child: TextField(
                              controller: _accountController,
                              decoration: const InputDecoration(
                                hintText: 'Account',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                height: 1.4,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Text(
                            'Username',
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2.5,
                                color: const Color.fromRGBO(236, 235, 240, 1),
                              ),
                            ),
                            child: TextField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                hintText: 'UserName',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                height: 1.4,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const Text(
                            'Password',
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2.5,
                                color: const Color.fromRGBO(236, 235, 240, 1),
                              ),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                height: 1.4,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: saveBtn(() {
                            Provider.of<Home>(context, listen: false).addItem(
                              _accountController.text,
                              _userNameController.text,
                              _passwordController.text,
                            );
                            Navigator.of(context).pop();
                          }),
                        ),
                        Expanded(
                          child: cancelBtn(() {
                            Navigator.of(context).pop();
                          }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
