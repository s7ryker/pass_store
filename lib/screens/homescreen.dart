import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pass_store/model/item_model.dart';
import 'package:pass_store/provider/home.dart';
import 'package:pass_store/utils/theme_data.dart';
import 'package:pass_store/widgets/add_item_button.dart';
import 'package:pass_store/widgets/appbar.dart';
import 'package:provider/provider.dart';

import 'components/list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void setData() {

  // }

  @override
  void initState() {
    Provider.of<Home>(context, listen: false).setItems();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<Home>(context).getItems;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundFadedColor,
      appBar: customAppbar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundFadedColor,
                  AppColors.backgroundColor,
                ],
                stops: [0.0, 1],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ListView.builder(
                itemBuilder: (ctx, index) => ListItem(
                  size: size,
                  item: items[index],
                ),
                itemCount: items.length,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: AddItemButton(),
          )
        ],
      ),
      // ListView.builder(
      //   itemBuilder: (ctx, index) => ListItem(
      //     size: size,
      //     item: items[index],
      //   ),
      //   itemCount: items.length,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => addItem(context, size),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  addItem(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side:
              const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05), width: 2),
        ),
        content: Container(
          height: size.height * .5,
          width: size.width * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
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
                        cursorColor: Colors.black,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<Home>(context, listen: false).addItem(
                          _accountController.text,
                          _userNameController.text,
                          _passwordController.text,
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
