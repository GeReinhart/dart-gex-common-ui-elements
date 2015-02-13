// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.show_room.login;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';

@CustomTag('page-login')
class PageLogin extends Page with Showable {
  static final String NAME = "login";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.BLUE_0082C8;

  Layout layout;
  SpanElement openIdSpan;
  SpanElement emailSpan;
  SpanElement displayNameSpan;
  ImageElement avatarImg;  
  
  
  PageLogin.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    openIdSpan = this.shadowRoot.querySelector("#openId") as SpanElement;
    emailSpan = this.shadowRoot.querySelector("#email") as SpanElement;
    displayNameSpan = this.shadowRoot.querySelector("#displayName") as SpanElement;
    avatarImg = this.shadowRoot.querySelector("#avatar") as ImageElement;    
    
    layout = $["layout"] as Layout;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(
        new ButtonModel(label: "Login", action: login, image: new Image(mainImageUrl: "/images/button/login.png")));
    buttonModels.add(
        new ButtonModel(label: "Cancel", action: cancel, image: new Image(mainImageUrl: "/images/button/back57.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: mainColor,
        orientation: Orientation.est,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
    
    
    
  }

  login(Parameters params) {
    fireApplicationEvent(new CallUserAuthEvent(this));
  }
  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event is UserAuthEvent){
      openIdSpan.innerHtml = event.user.openId ;
      emailSpan.innerHtml = event.user.email ;
      displayNameSpan.innerHtml = event.user.displayName ;
      avatarImg.src = event.user.imageUrl ;
    }
    
  }
  
  
  cancel(Parameters params) {
    // TODO cancel
  }
}
