import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailClient {
  static void sendEmail({@required attachmentPaths}) async {
    Email email = Email(
      body: '',
      subject: 'My Budget APP',
      //recipients: ['example@example.com'],
      attachmentPaths: attachmentPaths,
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
