import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendify/core/di/di.dart';
import 'package:sendify/core/utils/custom_colors.dart';
import 'package:sendify/core/widgets/widgets.dart';
import 'package:sendify/features/send/presentation/bloc/send_bloc.dart';

class SendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SendBloc>(),
      child: SendContainer(),
    );
  }
}

class SendContainer extends StatefulWidget {
  static const PATH = "/sendScreen";

  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendContainer> {
  String _title;
  String _content;
  String _androidImage;
  String _iosAttachment;

  @override
  Widget build(BuildContext context) => _buildBody();

  _buildBody() {
    final screenSize = MediaQuery.of(context).size;

    final double factor = screenSize.height * 0.2;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            color: CustomColors.BACKGROUND,
            height: screenSize.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTopBar("Notificações Alfredo", factor),
                _buildContent(factor),
              ],
            ),
          ),
        ),
        BlocConsumer<SendBloc, SendState>(
          builder: (context, state) {
            if (state is SendLoadingState) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Container();
          },
          listener: (context, state) {
            if (state is SendSuccessResultState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Sua mensagem foi entregue com sucesso: ${state.sendResultEntity.recipients}',
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.greenAccent,
                ),
              );
            } else if (state is SendErrorResultState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Não foi possível enviar!',
                    ),
                    duration: const Duration(seconds: 5),
                    backgroundColor: Colors.redAccent,
                  ),
              );

            }
          },
        )
      ],
    );
  }

  _buildContent(factor) {
    final double titleFontSize = factor * 0.1;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          defaultTextField(
            titleFontSize,
            "Título da mensagem",
            multiLine: null,
            onChange: (value) {
              _title = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          defaultTextField(
            titleFontSize,
            "Mensagem",
            multiLine: null,
            minLine: 13,
            onChange: (value) {
              _content = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: defaultTextField(
                  titleFontSize,
                  "Imagens Android",
                  multiLine: 1,
                  hint: "www.web.com/image",
                  onChange: (value) {
                    _androidImage = value;
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: defaultTextField(
                  titleFontSize,
                  "Imagens IOS",
                  multiLine: 1,
                  hint: "www.web.com/image",
                  onChange: (value) {
                    _iosAttachment = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<SendBloc>().add(SendNotificationEvent(
                        _title, _content, _androidImage, _iosAttachment));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Enviar",
                      style: titleTextStyle(titleFontSize)
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
