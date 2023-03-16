import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penggajian/features/penggajian/controller_penggajian.dart';
import 'package:penggajian/shared/helpers/currency_formatter.dart';
import 'package:penggajian/shared/widgets/loading_indicator.dart';
import 'package:penggajian/shared/widgets/page_decoration_top.dart';

class PagePenggajian extends GetView<ControllerPenggajian> {
  const PagePenggajian({super.key});

  @override
  Widget build(BuildContext context) {
    return PageDecorationTop(
      title: '',
      enableBack: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      backgroundColor: Colors.amber.shade200,
      center: Center(
        child: Text(
          'Data Karyawan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade100,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: Get.width,
              color: Colors.amber.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.loading.isFalse
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: controller.listData.length,
                              itemBuilder: (context, index) => CardRounded(
                                title: controller.listData[index].negara,
                                upperColor: controller.listData[index].negara ==
                                        "Indonesia"
                                    ? Colors.red
                                    : Colors.red.shade300,
                                child: Column(
                                  children: [
                                    //Nama
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Nama : ',
                                              style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '${controller.listData[index].nama}',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        ),
                                        //Status Perkawinan
                                        Row(
                                          children: [
                                            Text(
                                              'Status Perkawinan : ',
                                              style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '${controller.listData[index].statusPerkawinan}',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Penghasilan (Bulan) : ',
                                          style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          controller.listData[index].negara ==
                                                  "Indonesia"
                                              ? IDRCurrencyFormat.convertToIdr(
                                                  controller.gajiBulan[index],
                                                  0)
                                              : VNDCurrencyFormat.convertToVnd(
                                                  controller.gajiBulan[index],
                                                  0),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(
                                      height:
                                          controller.listData[index].negara ==
                                                  "Indonesia"
                                              ? 0
                                              : 8,
                                    ),
                                    controller.listData[index].negara ==
                                            "Vietnam"
                                        ? Row(
                                            children: [
                                              Text(
                                                'Asuransi (Bulan) : ',
                                                style: TextStyle(
                                                  color: Colors.grey.shade900,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                VNDCurrencyFormat.convertToVnd(
                                                    controller.listData[index]
                                                        .asuransi,
                                                    0),
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Penghasilan Bruto (Tahun) : ',
                                          style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          controller.listData[index].negara ==
                                                  "Indonesia"
                                              ? IDRCurrencyFormat.convertToIdr(
                                                  controller.listData[index]
                                                      .penghasilanBulanan,
                                                  0)
                                              : VNDCurrencyFormat.convertToVnd(
                                                  controller.listData[index]
                                                      .penghasilanBulanan,
                                                  0),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Penghasilan Netto (Bulan) : ',
                                          style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          controller.listData[index].negara ==
                                                  "Indonesia"
                                              ? IDRCurrencyFormat.convertToIdr(
                                                  controller.listData[index]
                                                      .penghasilanNetto,
                                                  0)
                                              : VNDCurrencyFormat.convertToVnd(
                                                  controller.listData[index]
                                                      .penghasilanNetto,
                                                  0),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Pajak Penghasilan (Bulan) : ',
                                          style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          controller.listData[index].negara ==
                                                  "Indonesia"
                                              ? IDRCurrencyFormat.convertToIdr(
                                                  controller.listData[index]
                                                      .pajakPenghasilan,
                                                  0)
                                              : VNDCurrencyFormat.convertToVnd(
                                                  controller.listData[index]
                                                      .pajakPenghasilan,
                                                  0),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : loadingIndicator(context),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.getData();
                controller.calculation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                minimumSize: const Size(345, 40),
              ),
              child: const Text('Refresh Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardRounded extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? width;
  final Color? color;
  final Color? upperColor;
  final List<BoxShadow>? shadow;

  const CardRounded({
    Key? key,
    required this.child,
    this.title,
    this.padding,
    this.margin,
    this.width,
    this.borderRadius,
    this.color,
    this.upperColor,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Container(
            width: width,
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 4),
            color: upperColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '$title',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: width,
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: color ?? Colors.white,
              borderRadius: borderRadius != null
                  ? BorderRadius.all(Radius.circular(borderRadius!))
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
              boxShadow: shadow ??
                  [
                    BoxShadow(
                        color: const Color(0xff333333).withOpacity(.15),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: const Offset(0, 1)),
                  ],
            ),
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}
