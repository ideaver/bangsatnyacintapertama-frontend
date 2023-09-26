import 'package:flutter/material.dart';

import '../../../app/theme/app_text_style.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../model/table_model.dart';

class AppTable extends StatefulWidget {
  final List<TableModel>? headerData;
  final List<List<TableModel>> data;
  final String? title;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final Alignment alignment;
  final TextAlign textAlign;
  final int? maxLines;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color headerBackgroundColor;
  final EdgeInsets? headerPadding;
  final double? headerBottomBorderWidth;
  final Color headerBottomBorderColor;
  final Color backgroundColor;
  final EdgeInsets? padding;
  final double? bottomBorderWidth;
  final Color bottomBorderColor;
  final double? tableBorderWidth;
  final Color tableBorderColor;
  final Function()? onLoadMore;
  final ScrollController? scrollController;

  const AppTable({
    Key? key,
    this.headerData,
    required this.data,
    this.title,
    this.titleStyle,
    this.textStyle,
    this.alignment = Alignment.centerLeft,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.headerBackgroundColor = AppColors.baseLv7,
    this.headerPadding,
    this.headerBottomBorderWidth,
    this.headerBottomBorderColor = AppColors.baseLv6,
    this.backgroundColor = AppColors.white,
    this.padding,
    this.bottomBorderWidth = 1,
    this.bottomBorderColor = AppColors.baseLv7,
    this.tableBorderWidth,
    this.tableBorderColor = AppColors.baseLv7,
    this.onLoadMore,
    this.scrollController,
  }) : super(key: key);

  @override
  State<AppTable> createState() => _AppTableState();
}

class _AppTableState extends State<AppTable> {
  // ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(() {
        if (widget.scrollController!.offset == widget.scrollController!.position.maxScrollExtent) {
          if (widget.onLoadMore != null) {
            widget.onLoadMore!();
          }
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  widget.title ?? '',
                  style: widget.titleStyle ?? AppTextStyle.bold(context, fontSize: 18),
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            border: widget.tableBorderWidth != null
                ? Border.all(
                    width: widget.tableBorderWidth!,
                    color: widget.tableBorderColor,
                  )
                : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: widget.width ?? AppSizes.screenSize.width,
                child: Column(
                  children: [
                    widget.headerData != null ? header(widget.headerData!) : const SizedBox.shrink(),
                    SizedBox(
                        height: widget.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: widget.scrollController,
                          itemCount: widget.data.length,
                          itemBuilder: (context, i) {
                            return row(widget.data[i]);
                          },
                        )

                        // SingleChildScrollView(
                        //   controller: scrollController,
                        //   child: Column(
                        //     children: [
                        //       ...List.generate(widget.data.length, (i) {
                        //         return row(widget.data[i]);
                        //       })
                        //     ],
                        //   ),
                        // ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget header(List<TableModel> rowData) {
    return Container(
      decoration: BoxDecoration(
        color: widget.headerBackgroundColor,
        border: widget.headerBottomBorderWidth != null
            ? Border(
                bottom: BorderSide(
                  width: widget.headerBottomBorderWidth!,
                  color: widget.headerBottomBorderColor,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          ...List.generate(rowData.length, (i) {
            return rowData[i].expanded
                ? Expanded(
                    flex: rowData[i].flex,
                    child: rowData[i].child != null ? rowData[i].child! : child(rowData[i]),
                  )
                : rowData[i].child != null
                    ? rowData[i].child!
                    : child(rowData[i]);
          })
        ],
      ),
    );
  }

  Widget row(List<TableModel> rowData) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: widget.bottomBorderWidth != null
            ? Border(
                bottom: BorderSide(
                  width: widget.bottomBorderWidth!,
                  color: widget.bottomBorderColor,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          ...List.generate(rowData.length, (i) {
            return rowData[i].expanded
                ? Expanded(
                    flex: rowData[i].flex,
                    child: rowData[i].child != null ? rowData[i].child! : child(rowData[i]),
                  )
                : rowData[i].child != null
                    ? rowData[i].child!
                    : child(rowData[i]);
          })
        ],
      ),
    );
  }

  Widget child(TableModel data) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(12),
      alignment: widget.alignment,
      color: data.color,
      child: Text(
        data.data ?? '',
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
        style: data.textStyle ?? widget.textStyle ?? AppTextStyle.medium(context),
      ),
    );
  }
}
