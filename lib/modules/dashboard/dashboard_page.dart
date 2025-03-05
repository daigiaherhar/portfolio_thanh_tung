import 'package:flutter/material.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/widgets/index.dart';

import '../../constants/const_images.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BannerWidget(
        title: "ĐOÀN THANH TÙNGĐOÀN THANH TÙNGĐOÀN THANH TÙNGĐOÀN THANH TÙNGĐOÀN THANH TÙNGĐOÀN THANH TÙNGĐOÀN THANH TÙNGĐOÀN THANH TÙNG",
        description: "tôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong lai",
      ),
    );
  }
}
