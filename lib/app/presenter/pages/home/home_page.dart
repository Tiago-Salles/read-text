import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:read_text/app/core/app_module/app_modules.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';
import 'package:read_text/app/presenter/pages/home/widgets/body_home_page.dart';
import 'package:read_text/app/presenter/pages/home/widgets/home_bottom_sheet.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeDomain homeDomain;
  late TextEditingController textController;
  List<String> moreThanOneWordList = [];
  
  @override
  void initState() {
    homeDomain = AppModules.homeDomain;
    textController = TextEditingController();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyHomePage(
        homeDomain: homeDomain,
        moreThanOneWordList: moreThanOneWordList,
      ),
      bottomSheet: HomeBottomSheet(
        homeDomain: homeDomain,
        moreThanOneWordList: moreThanOneWordList,
      ),
    );
  }
}
