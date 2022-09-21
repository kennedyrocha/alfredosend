import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendify/core/di/di.dart';
import 'package:sendify/core/utils/custom_colors.dart';
import 'package:sendify/core/utils/paginated_listview.dart';
import 'package:sendify/core/widgets/widgets.dart';
import 'package:sendify/features/analytics/domain/entity/analytics_entity.dart';
import 'package:sendify/features/analytics/presentation/bloc/analytics_bloc.dart';

class AnalyticsScreen extends StatelessWidget {
  static const PATH = "/analytics";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AnalyticsBloc>()..add(AnalyticsEventLoadMore()),
      child: AnalyticsContainer(),
    );
  }
}

class AnalyticsContainer extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsContainer> {

  bool _hasReachedMax = false;

  @override
  Widget build(BuildContext context) => _buildBody();

  _buildBody() {
    final screenSize = MediaQuery.of(context).size;

    final double factor = screenSize.height * 0.2;

    return Column(
      children: [
        buildTopBar("Analytics", factor),
        BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            return Container();
          },
        ),
        BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            if (state is AnalyticsLoading) {
              return _buildList(factor, state.notifications, true);
            }
            if (state is AnalyticsLoadedNotifications) {
              _hasReachedMax = state.hasReachedMax;
              return _buildList(factor, state.notifications, false);
            }
            if (state is AnalyticsInitial) {
              return _buildCenterLoadingIndicator();
            }

            return Container();
          },
        ),
      ],
    );
  }

  _buildList(double factor, List<AnalyticsEntity> analytics, bool isLoading) {
    return PaginatedListView(
      itemCount: analytics.length,
      isLoading: isLoading,
      hasReachedMax: _hasReachedMax,
      item: (index){
        return  _buildItems(factor, analytics[index]);
      },
      onLoadMore: (){
        context.read<AnalyticsBloc>().add(AnalyticsEventLoadMore());
      },
    );
  }


  _buildCenterLoadingIndicator() => Expanded(
        child: Center(
          child: Container(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(),
          ),
        ),
      );

  _buildItems(double factor, AnalyticsEntity analyticsEntity) {
    final double titleFontSize = factor * 0.09;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: CustomColors.PRIMARY_COLOR,
      child: ExpandablePanel(
        header: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      analyticsEntity.title ?? "title is empty",
                      style: titleTextStyle(
                        titleFontSize,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16, bottom: 10),
                          child: Text(
                            analyticsEntity.content ?? "content is empty",
                            textAlign: TextAlign.start,
                            style: contentTextStyle(
                              titleFontSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_box,
                          color: Colors.lightGreen,
                          size: titleFontSize + 5,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Total successful : ${analyticsEntity.totalSuccess}",
                          textAlign: TextAlign.start,
                          style: contentTextStyle(
                            titleFontSize,
                          ).copyWith(color: Colors.lightGreen),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sms_failed,
                          color: Colors.redAccent,
                          size: titleFontSize + 5,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Total failed : ${analyticsEntity.totalFailed}",
                          textAlign: TextAlign.start,
                          style: contentTextStyle(
                            titleFontSize,
                          ).copyWith(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        expanded: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 2,
              color: CustomColors.BACKGROUND,
            ),
            SizedBox(
              height: 8,
            ),
            analyticsEntity.analyticsPlatformDeliveryStats.android != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: _buildRowPlatformDeliveryStats(
                      titleFontSize,
                      "Android:",
                      analyticsEntity.analyticsPlatformDeliveryStats.android,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
            analyticsEntity.analyticsPlatformDeliveryStats.ios != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: _buildRowPlatformDeliveryStats(
                      titleFontSize,
                      "IOS:",
                      analyticsEntity.analyticsPlatformDeliveryStats.ios,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            imageAvailable(analyticsEntity.bigImageUrl)
                ? Container()
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: Image.network(
                      analyticsEntity.bigImageUrl,
                      height: factor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  imageAvailable(url) => url == null || url == "null" || url.trim().length < 3;

  _buildRowPlatformDeliveryStats(
      double titleFontSize, String title, AnalyticsPlatform analyticsPlatform) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: contentTextStyle(titleFontSize)
              .copyWith(color: CustomColors.FONT),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "successful : ${analyticsPlatform.successful}",
                textAlign: TextAlign.start,
                style: contentTextStyle(titleFontSize).copyWith(
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "failed :  ${analyticsPlatform.failed}",
                textAlign: TextAlign.center,
                style: contentTextStyle(titleFontSize).copyWith(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "errored :  ${analyticsPlatform.errored}",
                textAlign: TextAlign.right,
                style: contentTextStyle(titleFontSize).copyWith(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
