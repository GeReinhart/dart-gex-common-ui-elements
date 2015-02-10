library gex_common_ui_elements.page;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/layout.dart';
import 'package:polymer/polymer.dart';

abstract class Page extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('Page');

  Layout _layout;
  PageModel _model;

  Page.created() : super.created();

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  PageModel get model => _model.clone();
  String get name => _model.name;

  void _setAttributes() {
    _layout = $["layout"] as Layout;
  }

  void init(PageModel model) {
    _model = model;
    _layout.init(model.layoutModel);
  }

  Margin get margin => _model.margin;

  set margin(Margin margin) {
    _model.margin = margin;
    _layout.margin = margin;
  }

  @override
  void moveTo(Position position) {
    super.moveTo(position);
    _layout.moveTo(position);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    _model.recieveApplicationEvent(event);
  }
}
