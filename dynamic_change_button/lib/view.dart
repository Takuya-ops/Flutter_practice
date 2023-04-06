import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_change_button/message_repository.dart';
import 'package:dynamic_change_button/utils.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageRepository messageRepository = MessageRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast vs SnackBar Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Toast vs SnackBar'),
            ElevatedButton(
                onPressed: () => messageRepository.showToast(
                    'FlutterからAndroid側にメッセージを渡し、Toastで表示する。', 100),
                child: const Text('Show Toast')),
            ElevatedButton(
                onPressed: () => Utils.showSnackbar(context,
                    'ToastよりSnackBarが推奨されているようなので、SnackBarでも表示してみる。', 5),
                child: const Text('Show Snackbar'))
          ],
        ),
      ),
    );
  }
}
