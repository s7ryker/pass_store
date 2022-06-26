import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_store/model/item_model.dart';
import 'package:pass_store/provider/home.dart';
import 'package:pass_store/utils/hero_dialog_route.dart';
import 'package:pass_store/utils/theme_data.dart';
import 'package:provider/provider.dart';

class ListItem extends StatefulWidget {
  ListItem({
    Key? key,
    required this.size,
    required this.item,
  }) : super(key: key);

  final Size size;
  final Item item;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height * .12,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Center(
                child: _PopUpCard(item: widget.item),
              ),
            ),
          );
        },
        child: Card(
          color: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.05), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.accountName,
                      style: TextStyles.heading,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Username :',
                          style: TextStyles.text,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.item.userName,
                          style: TextStyles.subText,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'Confirm you want to delete this item'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: AppColors.accentColor,
                                  ),
                                ),
                              ),
                              deleteBtn(
                                () {
                                  Provider.of<Home>(context, listen: false)
                                      .deleteItem(widget.item);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PopUpCard extends StatefulWidget {
  _PopUpCard({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<_PopUpCard> createState() => _PopUpCardState();
}

class _PopUpCardState extends State<_PopUpCard> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.item.id,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.cardColor,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.item.accountName,
                              style: TextStyles.heading,
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    HeroDialogRoute(
                                      builder: (context) => Center(
                                        child: EditItem(item: widget.item),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        const Text(
                          'Username',
                          style: TextStyles.subHeading,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              widget.item.userName,
                              style: TextStyles.subText,
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: widget.item.userName));
                                },
                                icon: const Icon(Icons.copy))
                          ],
                        ),
                        const Text(
                          'Password',
                          style: TextStyles.subHeading,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            obscureText
                                ? const Text(
                                    '•••••••••',
                                    style: TextStyles.subText,
                                  )
                                : Text(
                                    widget.item.password,
                                    style: TextStyles.subText,
                                  ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: obscureText
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: widget.item.password));
                                },
                                icon: const Icon(Icons.copy))
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}

class EditItem extends StatefulWidget {
  const EditItem({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final TextEditingController _accountController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    _accountController.text = widget.item.accountName;
    _passwordController.text = widget.item.password;
    _userNameController.text = widget.item.userName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.item.id,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.cardColor,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
                                cursorColor: Colors.black,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
                                cursorColor: Colors.black,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2.5,
                                  color: const Color.fromRGBO(236, 235, 240, 1),
                                ),
                              ),
                              child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                  height: 1.4,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: saveBtn(() {
                                    Provider.of<Home>(context, listen: false)
                                        .editItem(
                                      widget.item,
                                      _accountController.text,
                                      _userNameController.text,
                                      _passwordController.text,
                                    );
                                    Navigator.of(context).pop();
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
