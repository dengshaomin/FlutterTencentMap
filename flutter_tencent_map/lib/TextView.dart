
import 'package:flutter/material.dart';
import 'package:flutter_tencent_map/common/TextViewAttr.dart';

class TextView extends StatefulWidget implements TextViewAttr {
  TextView(
      {Key? key,
      this.textColor,
      this.textSize,
      this.background,
      this.text,
      this.marginLeft,
      this.marginTop,
      this.marginRight,
      this.marginBottom,
      this.paddingLeft,
      this.paddingTop,
      this.paddingRight,
      this.paddingBottom})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextViewState();
  }

  @override
  Color? background;

  @override
  List<int>? borderRadius;

  @override
  List<double>? margin;

  @override
  List<double>? padding;

  @override
  String? text;

  @override
  double? marginBottom;

  @override
  double? marginLeft;

  @override
  double? marginRight;

  @override
  double? marginTop;

  @override
  double? paddingBottom;

  @override
  double? paddingLeft;

  @override
  double? paddingRight;

  @override
  double? paddingTop;

  @override
  Color? textColor;

  @override
  double? textSize;

// TextView(this.attr_textView, {Key? key})
//     : super(attr_textView?.text ?? "", key: key);

// TextView(final TextViewAttr attr, {Key? key})
//     :super(attr?.text ?? "", key: key);

// const TextView._(String text, {Key? key})
//     :super(text, key: key);

}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(widget.marginLeft ?? 0, widget.marginTop ?? 0,
          widget.marginRight ?? 0, widget.marginBottom ?? 0),
      padding: EdgeInsets.fromLTRB(
          widget.paddingLeft ?? 0,
          widget.paddingTop ?? 0,
          widget.paddingRight ?? 0,
          widget.paddingBottom ?? 0),
      color: widget.background,
      child: Text(widget?.text ?? "",style: TextStyle(color: widget.textColor,fontSize: widget.textSize))
    );
  }
}
