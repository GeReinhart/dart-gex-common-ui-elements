// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library gex_webapp_kit_client.user.edit;

import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/map_geo_location.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-user-edit')
class UserEdit extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('UserEdit');

  @observable String openId;
  @observable String email;
  @observable String displayName;
  @observable String avatarUrl;
  @observable String googlePlusUrl;
  
  UserEdit.created() : super.created();
  MapGeoLocation map;

  @override
  void ready() {
    map = new MapGeoLocation($["map"], 400, "images/button/location76.png", 50);
  }

  @override
  void show() {
    super.show();
    map.show();
  }

  @override
  void hide() {
    super.hide();
    map.hide();
  }

  set user(User user) {
    openId = user.openId;
    email = user.email;
    displayName = user.displayName;
    avatarUrl = user.avatarUrl;
    googlePlusUrl = user.googlePlusUrl;
    map.user = user;
  }

  User get user => new User.fromFields(
      openId: openId,
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      googlePlusUrl:googlePlusUrl,
      locationLat: map.location.lat,
      locationLng: map.location.lng,
      locationAddress: map.address);
}
