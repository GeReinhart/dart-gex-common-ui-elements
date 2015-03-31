import 'dart:io' show Platform;
import 'package:path/path.dart' show join, dirname;
import 'package:redstone/server.dart' as app;
import 'package:shelf_static/shelf_static.dart';
import "package:redstone_mapper/plugin.dart";
import "package:redstone_mapper_mongo/manager.dart";
import 'package:gex_webapp_kit_client/webapp_kit_server.dart';

main() {

  MongoDbManager dbManager = new MongoDbManager(dbUri(), poolSize: poolSize());
  app.addPlugin(getMapperPlugin(dbManager, "/services/.+"));

  app.setShelfHandler(
      createStaticHandler(staticPathToServe(), defaultDocument: "index.html", serveFilesOutsidePath: supportDartium()));

  UserService_googleOAuthClientId =  googleOAuthClientId();
  
  app.setupConsoleLog();
  app.start(port: serverPort());
}

num serverPort() {
  try {
    return num.parse(Platform.environment['PORT']);
  } catch (e) {
    return 9090;
  }
}

String staticPathToServe() {
  var dartMode = Platform.environment['DART_MODE'];
  if (dartMode == "DEV") {
    return join(dirname(Platform.script.toFilePath()), '..', 'web');
  } else {
    return join(dirname(Platform.script.toFilePath()), '..', 'build/web');
  }
}

bool supportDartium() {
  var dartMode = Platform.environment['DART_MODE'];
  return dartMode == "DEV";
}

@app.Route("/oauth/google/clientid")
String googleOAuthClientId() {
  return Platform.environment['GEX_WEBAPP_KIT_GOOGLE_OAUTH_CLIENT_ID'];
}

String googleOAuthSecret() {
  return Platform.environment['GEX_WEBAPP_KIT_GOOGLE_OAUTH_SECRET'];
}

String dbUri() {
  return Platform.environment['GEX_WEBAPP_KIT_DB_URI'];
}

num poolSize() {
  try {
    return num.parse(Platform.environment['GEX_WEBAPP_KIT_DB_POOL_SIZE']);
  } catch (e) {
    return 3;
  }
}
