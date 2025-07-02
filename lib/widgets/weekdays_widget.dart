import 'package:flutter/material.dart';

import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

class WeekdaysWidget extends StatelessWidget {
  final CleanCalendarController cleanCalendarController;
  final String locale;
  final Layout? layout;
  final TextStyle? textStyle;
  final Widget Function(BuildContext context, String weekday)? weekdayBuilder;
  final double? aspectRatio;
  final double weekDaysHeight;

  const WeekdaysWidget({
    Key? key,
    required this.cleanCalendarController,
    required this.locale,
    required this.layout,
    required this.weekdayBuilder,
    required this.textStyle,
    required this.aspectRatio,
    required this.weekDaysHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(DateTime.daysPerWeek, (index) {
        final weekDay = cleanCalendarController.getDaysOfWeek(locale)[index];

        if (weekdayBuilder != null) {
          return Flexible(child: weekdayBuilder!(context, weekDay));
        }

        return Flexible(
          child: <Layout, Widget Function()>{
            Layout.DEFAULT: () => _pattern(context, weekDay),
            Layout.BEAUTY: () => _beauty(context, weekDay)
          }[layout]!(),
        );
      }),
    );
    // return GridView.custom(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   padding: EdgeInsets.zero,
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: double.infinity, // this will fill the row
    //     mainAxisExtent: 100, // 👈 fixed height
    //     mainAxisSpacing: 0,
    //     crossAxisSpacing: 0,
    //   ),
    //   childrenDelegate: SliverChildBuilderDelegate(
    //     (context, index) {
    //       final weekDay = cleanCalendarController.getDaysOfWeek(locale)[index];

    //       if (weekdayBuilder != null) {
    //         return weekdayBuilder!(context, weekDay);
    //       }

    //       return <Layout, Widget Function()>{
    //         Layout.DEFAULT: () => _pattern(context, weekDay),
    //         Layout.BEAUTY: () => _beauty(context, weekDay)
    //       }[layout]!();
    //     },
    //     childCount: DateTime.daysPerWeek,
    //   ),
    // );
    // return GridView.count(
    //   crossAxisCount: DateTime.daysPerWeek,
    //   shrinkWrap: true,
    //   childAspectRatio: aspectRatio ?? 1.0,
    //   physics: const NeverScrollableScrollPhysics(),
    //   padding: EdgeInsets.zero,
    //   children: List.generate(DateTime.daysPerWeek, (index) {
    //     final weekDay = cleanCalendarController.getDaysOfWeek(locale)[index];

    //     if (weekdayBuilder != null) {
    //       return weekdayBuilder!(context, weekDay);
    //     }

    //     return <Layout, Widget Function()>{
    //       Layout.DEFAULT: () => _pattern(context, weekDay),
    //       Layout.BEAUTY: () => _beauty(context, weekDay)
    //     }[layout]!();
    //   }),
    // );
  }

  Widget _pattern(BuildContext context, String weekday) {
    return Center(
      child: Text(
        weekday.capitalize(),
        style: textStyle ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.4),
                  fontWeight: FontWeight.bold,
                ),
      ),
    );
  }

  Widget _beauty(BuildContext context, String weekday) {
    return Center(
      child: Text(
        weekday.capitalize(),
        style: textStyle ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.4),
                  fontWeight: FontWeight.bold,
                ),
      ),
    );
  }
}
