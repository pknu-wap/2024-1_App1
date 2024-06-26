import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'check_image.dart';
import 'dart:convert';
class Upload_Image extends StatefulWidget {
  final String requestMail;
  const Upload_Image( {Key? key, required this.requestMail}) : super(key: key);

  @override
  _Upload_ImageState createState() => _Upload_ImageState();
}

class User {
  String mail; //이메일      *sign_up.dart에서 받음*
  String department; //전공  *이 페이지에서 임시로 받는 값* 본 데이터는 check_image.dart에서 받음
  String name; //이름        *이 페이지에서 임시로 받는 값*
  String id; //학번          *이 페이지에서 임시로 받는 값*
  String pw; //비밀번호       *profile.dart에서 받는값*
  String nickname; //닉네임  *profile.dart에서 받는값*

  User(this.mail, this.department, this.name,
      this.id, this.pw, this.nickname);

  Map<String, dynamic> toJson(){
    return {
      "mail" : mail,
      "department" : department,
      "name" : name,
      "id" : id,
      "pw" : pw,
      "nickname" : nickname,
    };
  }
}

class _Upload_ImageState extends State<Upload_Image> {
  String parsedtext = ''; // 추출된 텍스트를 저장할 String 변수
  late User u1 = User('','','','','','');


  parsethetext() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if (pickedFile == null) return;
      var bytes = File(pickedFile.path.toString()).readAsBytesSync();
      String img64 = base64Encode(bytes);

      var url = 'https://api.ocr.space/parse/image';
      var payload = {
        "base64Image": "data:image/png;base64,${img64.toString()}",
        "language": "kor"
      };
      var header = {"apikey": "K88159020988957"};


      var post = await http.post(
          Uri.parse(url), body: payload, headers: header);
      var result = jsonDecode(post.body); // 추출 결과를 받아서 result에 저장
      setState(() {
        print(result);
        parsedtext =
        result['ParsedResults'][0]['ParsedText']; // 추출결과를 다시 parsedtext로 저장
        extractInfoFromText();
        //if (u1.name != '' && u1.id != '' && u1.department != '') {
        // Navigate to the next page with the populated s1 object

        //}
      });
    } catch(e) {
      log("error at picked image or connect OCR api");
      u1 = User(widget.requestMail,'','','','','');
    }
    finally {
      setState(() {
        u1.mail = widget.requestMail;
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => Check_Image(u1: u1)
          ),);
      });
    }
  }
  void extractInfoFromText() {
    int index = parsedtext.indexOf('남은시간');
    if(index == -1)
      index = parsedtext.indexOf('남은');
    if(index == -1)
      index = parsedtext.indexOf('시간');
    if(index == -1)
      index = parsedtext.indexOf('은시');
    if (index != -1) {
      // "남은시간"을 기준으로 분할하여 앞 부분은 잘라냄
      String remainingText = parsedtext.substring(index);

      // "\n"을 기준으로 분할하여 리스트로 저장
      List<String> splitText = remainingText.split('\n');

      splitText.removeAt(0); // 첫 번째 요소인 "남은시간: 30"은 필요 없으므로 제거

      // 추출된 텍스트에서 학번, 이름, 전공 추출

      if (splitText.length >= 3) {
        setState(() {
          //splitText[0]: 이름, splitText[1]: 전공, splitText[2]: 학번
          u1 = User(widget.requestMail,splitText[1],splitText[0],splitText[2],'',''); // s1에 객체 저장
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: SizedBox(
              height: 25.0,
              child: const Text(
                '본인인증',
                style: TextStyle(
                  fontFamily: 'paybooc',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.01,
                  color: Color(0xff111111),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 22.0, top: 30.0),
                child: const Text(
                  '모바일 학생증 인증',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.01,
                    color: Color(0xff373737),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Stack(
                  children: <Widget>[
                    Image.asset('assets/images/Rectangle 1.png', width: 320, height: 202, fit: BoxFit.cover),
                    Positioned(
                      left: 0, right: 0, top: 0, bottom: 0,
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/upload_image_button.png',
                          width: 80,
                          height: 80,
                          // color: Color(0xff8D8D8D),
                        ),
                        onPressed: () {
                          // 이 버튼을 누르면 갤러리가 열리고 이미지를 가져오도록 설정
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //       builder: (context) => Check_Image(u1: u1)
                          //   ),);
                          parsethetext();
                          initState();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 22.0, top: 36.0),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 9.0),
                            child: const Text(
                              '업로드 파일 예시',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.01,
                                color: Color(0xff373737),
                              ),
                            ),
                          ),
                          const Text(
                            '파일 형식  jpg / png',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.01,
                              color: Color(0xff373737),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 139.58,
                      height: 256.44,
                      margin: const EdgeInsets.only(left: 22.0, top: 17.0),
                      child: Image.asset('assets/images/upload_image_sample.png'),
                    ),

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