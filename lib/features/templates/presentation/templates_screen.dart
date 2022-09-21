import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendify/core/di/di.dart';
import 'package:sendify/core/utils/custom_colors.dart';
import 'package:sendify/core/utils/paginated_listview.dart';
import 'package:sendify/core/widgets/widgets.dart';
import 'package:sendify/features/templates/presentation/bloc/templates_bloc.dart';

import '../domain/entity/template_entity.dart';

class TemplateScreen extends StatelessWidget {
  static const PATH = "/templateScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TemplatesBloc>()..add(TemplatesEventLoadMore()),
      child: TemplateContainer(),
    );
  }
}

class TemplateContainer extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<TemplateContainer> {
  _onItemClicked(TemplateEntity templateEntity) {
    showDialog(
      context: context,
      builder: (context) {
        return _buildDialog(templateEntity);
      },
    );
  }

  _buildDialog(TemplateEntity templateEntity) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Do you want send ",
                    style: titleTextStyle(18),
                  ),
                  TextSpan(
                    text: templateEntity.name,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: " to clients?",
                    style: titleTextStyle(18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    context.read<TemplatesBloc>().add(
                          TemplatesEventSendByID(
                            templateEntity.id,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Yes",
                    style:
                        titleTextStyle(17).copyWith(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildList(double factor, List<TemplateEntity> templates, bool isLoading,
      hasReachedMax) {
    final double titleFontSize = factor * 0.09;

    return PaginatedListView(
      itemCount: templates.length,
      isLoading: isLoading,
      hasReachedMax: hasReachedMax,
      item: (index) {
        return _buildItems(templates[index], fontSize: titleFontSize);
      },
      onLoadMore: () {
        context.read<TemplatesBloc>().add(TemplatesEventLoadMore());
      },
    );
  }

  _buildItems(TemplateEntity templateEntity, {double fontSize}) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 1),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: fontSize * 3,
        color: CustomColors.PRIMARY_COLOR,
        child: Row(
          children: [
            Expanded(
              child: Text(
                templateEntity.name,
                style: titleTextStyle(fontSize),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _onItemClicked(templateEntity);
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

  _buildBody() {
    final screenSize = MediaQuery.of(context).size;
    final double factor = screenSize.height * 0.2;
    return Column(
      children: [
        buildTopBar("Templates", factor),
        BlocConsumer<TemplatesBloc, TemplatesState>(
          buildWhen: (prev, current) {
            if (current is TemplateFailedToSendNotification ||
                current is TemplateSuccessSendNotification)
              return false;
            else
              return true;
          },
          builder: (context, state) {
            if (state is TemplateLoading) {
              return _buildList(factor, state.templates, true, false);
            }
            if (state is TemplatesLoaded) {
              return _buildList(
                  factor, state.templates, false, state.hasReachedMax);
            }
            if (state is TemplatesInitial) {
              return _buildCenterLoadingIndicator();
            }

            return Container();
          },
          listener: (context, state) {
            if (state is TemplateSuccessSendNotification) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'your message has been sent successfully',
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.greenAccent,
                ),
              );
            }
            if (state is TemplateFailedToSendNotification) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Não foi possível enviar a mensagem!',
                  ),
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _buildBody();
}
