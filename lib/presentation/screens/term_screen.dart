import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TermScreen extends StatelessWidget {
  const TermScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Үйлчилгээний нөхцөл",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.containerMargin),
          child: Column(
            children: [
              Text("Дасгал апп нь эрүүл мэнддээ анхаардаг хүн болгонд зориулсан апп юм.", style: AppStyle.textBody1,),
              SizedBox(height: 12,),
              Text("Та өөрийн утасны дугаараар нэвтэрснээр үйлчилгээний нөхцөлийг зөвшөөрч байгаа болно.", style: AppStyle.textBody1,),
              SizedBox(height: 12,),
              Text("Та дараах мэдээллийг оруулснаар Дасгал апп-ыг хэрэглэх боломжтой болно. Утасны дугаар, нэр, нас, өндөр, жин.", style: AppStyle.textBody1,),
              SizedBox(height: 12,),
              Text("Нууцлалын бодлого", style: AppStyle.textBody1,),
              SizedBox(height: 12,),
              Text("Таны оруулсан хувийн мэдээллийг аюулгүйгээр хадгалах ба хууль эрх зүйн хүрээнд шаардахаас бусад нөхцөлд бид аливаа гуравдагч этгээдэд задруулахгүй болно. Та хувийн мэдээллээ аюулгүй хадгалах үүднээс нууц үгээ бусдад дамжуулхаас татгалзана уу.", style: AppStyle.textBody1,),
              SizedBox(height: 12,),
              Text("Таны мэдээлэл зөвхөн танд үйлчилгээ үзүүлэхэд ашиглагдах ба оруулсан мэдээллээ устгах, өөрчлөх, мөн энэхүү аппликэшнийг хэрэглэхээс татгалзах эрхтэй.", style: AppStyle.textBody1,),
            ],
          ),
        ),
      ),
    );
  }
}
