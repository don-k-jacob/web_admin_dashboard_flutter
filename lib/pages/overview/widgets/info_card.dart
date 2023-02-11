import 'package:flutter/material.dart';
import 'package:admin_dashboard/constants/style.dart';
import 'package:get/get.dart';

import '../../../controllers/customers_controller.dart';

class InfoCard extends StatefulWidget {
  const InfoCard(
      {Key? key,
      required this.title,
      required this.value,
      this.isActive = false,
      required this.onTap,
      this.topColor})
      : super(key: key);

  final String title;
  final int value;
  final Color? topColor;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  final CustomersController customersController =
      Get.put(CustomersController());


  @override
  void initState() {
    super.initState();
    customersController.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: 136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGray.withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    color: widget.topColor ?? active,
                    height: 5,
                  ))
                ],
              ),
              Expanded(child: Container()),
              Obx(() => customersController.customers.isEmpty
                    ? const CircularProgressIndicator()
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "${widget.title}\n",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: widget.isActive ? active : lightGray)),
                          TextSpan(
                              text: "${customersController.customers.length}",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: widget.isActive ? active : dark)),
                        ])),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
