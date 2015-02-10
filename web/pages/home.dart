library gex_common_ui_elements.show_room.home;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/layout.dart';
import 'package:gex_common_ui_elements/elements/page.dart';

@CustomTag('page-home')
class PageHome extends Page with Showable {
  static final String NAME = "home";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.BLUE_0082C8;

  Layout layout;
  ImageElement dartLogo;

  PageHome.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    LayoutModel layoutModel = new LayoutModel();
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }
}
