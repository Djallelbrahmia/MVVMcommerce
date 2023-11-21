import 'package:ecommvvm/data/mapper/mapper.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getstateRendererType();
  String getMessage();
}

//Loading state(Popup, Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getstateRendererType() {
    return stateRendererType;
  }
}

//Error State state(Popup, Full Screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getstateRendererType() {
    return stateRendererType;
  }
}

//Content State
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() {
    return EMPTY;
  }

  @override
  StateRendererType getstateRendererType() {
    return StateRendererType.CONTENT_SCREEN_STATE;
  }
}

//Empty State
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getstateRendererType() {
    return StateRendererType.EMPTY_SCREEN_STATE;
  }
}

//Empty State
class SuccessState extends FlowState {
  String message;
  SuccessState(this.message);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getstateRendererType() {
    return StateRendererType.POPUP_SUCCESS_STATE;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getstateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getstateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getstateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          if (getstateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(context, getstateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getstateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ContentState:
        {
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getstateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case SuccessState:
        {
          dismissDialog(context);
          showPopUp(
              context, StateRendererType.POPUP_SUCCESS_STATE, getMessage());
          return contentScreenWidget;
        }

      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != null;
  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {}),
      );
    });
  }
}
