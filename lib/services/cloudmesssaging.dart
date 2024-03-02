import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/models/chatuser.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

class CloudMessagingService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future initialise() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}

class AccessFirebaseToken {
  static String fMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "flutterapplication1-72f40",
        "private_key_id": "4ad263e367fc3082eccd4d9b371e08a5e7845c94",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCgzUHHguTEVuYB\nT1WXTLASTkZgXauWNvOwEJ469bZSBTOTZfhVXgCN6PJ6EHND8mtFoy6s7eZzXCIo\nanwm2hcRQlPjNKW+vJ5hx8ppPLq4OXpuVE/b6X64L6tpPJPjFdY76qvsygeszWDH\nY/4W2JxHiTvvSPiZ64ExQelsbBmcPPWB95UyE5Noijq86Z9A95CN5KTn1iTFJIzT\nc71GbT92VuC8yiQ12bN8Mf+cM/NywLXfNvgqtPe87rtmvOtwZnJeQDt9G9A2BLIK\nQCH4Kxmlr5xQqQBqDPMr3FoMg/qzrgyGzmLCYGKNgxLHIbaQP7E6dc6+83O07kkK\nyiGeCkfDAgMBAAECggEARRecxXyVDlXmUzbC6JU/bEYs0Bg/c3ZeI88oJd5Q/hIV\nFKbyWr/ezhsDIPaziET/2bahhhVceUHjvWjvuoPn+Hb+83e6JegGx63gZ3J8Kk8s\nL37Tp4K++6Yj6T5prt/BoxIU2FQAkzvV8yagVTGyiLxLP+gjRYOfCcqv4PHb2Tjb\nyRfXXgXRAsK4PfkWJrhpZto+46oUk3ajrulbjS1MmApEwfse5H5r0XeW4JIf8N1c\nq3LSTQLQmsmPGOTXvemnIrun1WCsn/zWFOu+ISrRJXpI0nlfa4lXwB57Hb2Y18qC\n/5ZfQcIJKCxQPb0YIHnZXsN6BsoZ2dGS3LWUQZIVOQKBgQDMx+i+XY72vwVx3B81\nNoTOFzL1gNmDr90Kzb+kUtbIiKRzaErJMgDXxMg2E4rxO4vauPUJtya22j/MVhMa\nZbAeO6iSyfGpitZzXWymOryvDjuAaa4ry6O+IB10+1ac6UTVG84u6YRrraJeEI4c\nx69Mxcuf8+s9sQFEjbVE8o2wCwKBgQDJBV8tZYTX7kNlql0vEsZuxyc8LH2Y9uLL\nsiNU430jkJnjN1yY0v0kdtcXMV4ibhF90VQvHiFgtAtulyu7NRKxiITTg5Kkz3Mn\njd45WBpMY243Gt2FmsWrfT7fSH1pmLBPgP0c7Dv0BJ1zcYENNk6eslcJqtNnfDE7\nEZ3RvIsCKQKBgQCH/2uuoWvEqu/uwgVnzaE9TWLmcIAEWNMvzZysgOdrnnO4wVaJ\nb8/nfCSK5UetFaK3y4XQwfXQEfm0tqVRLp9cNLqrYbpAopfxXeY+L1wH1ifmDElD\nhKZmKeXmPtUyuCiibyjrNuJesJ3YYp4+ts7Q6btlqxRbkCYLZSExfPRkKQKBgQCa\n4siy8cWpmqvTabDi1FSQhmJ0utMLSS72RAt1HNMO1Bu+NqniFq91qRuRgzhEzwor\nJ1717wFIwXENhOztEbeVktrFHlufIThZAbZ3+KpKsVH6o3iLuPUVbStEX1ZCRqOS\nnpBn+J05J1Up3grRY0awgDkP+c9prQdBvBEdyWhSAQKBgEtE4Qk+4GLwieGfkOem\nOIDLVbfNEOx6o+dEdRdJJEs82bg4r1yVEpbxGDvzZhMdmPHNT4S7MZsktdFN9aY5\n/AXLvz9VTptw/JbJSRAIYYy+xobvAbBNo/O+OG8haouhpITvqLI9awOZU/0ig2Dl\n+ysgwgfm/NqN61mZjZCWi4Nk\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-2ugyq@flutterapplication1-72f40.iam.gserviceaccount.com",
        "client_id": "111528374325601213023",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2ugyq%40flutterapplication1-72f40.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      [fMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }

  Future<void> sendPushNotification(List<ChatUser?> chatUser) async {
    AccessFirebaseToken accessToken = AccessFirebaseToken();
    String bearerToken = await accessToken.getAccessToken();

    for (int i = 0; i <= 0; i++) {
      final body = {
        "message": {
          "token": chatUser[i]!.pushToken,
          "notification": {"title": "Medos", "body": 'A New Message'},
        }
      };
      try {
        var res = await post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/flutterapplication1-72f40/messages:send'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode(body),
        );
        print("Response statusCode: ${res.statusCode}");
        print("Response body: ${res.body}");
      } catch (e) {
        print("\nsendPushNotification: $e");
      }
    }
  }
}
