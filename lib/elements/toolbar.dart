library gex_common_ui_elements.toolbar;

import "dart:html";
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';
import 'package:polymer/polymer.dart';

@CustomTag('gex-toolbar')
class Toolbar extends Positionable {
  
  final Logger log = new Logger('Toolbar');
  
  @published String backgroundColor = "black";
  
  Position initialPostion ;
  Position postion ;
  Orientation orientation ;
  List<ActionDescriptor> actions ;
  List<Button> _buttons ;
  
  Toolbar.created() : super.created() ;
  
  void ready() {
    super.ready();
    this.style.backgroundColor = backgroundColor; 
  }
  
  
  void init(Position position, Orientation orientation, List<ActionDescriptor> actions) {
    this.initialPostion = position;
    this.orientation = orientation;
    this.actions = actions ;
    _buttons = new List<Button>();
    this.postion = position.clone() ;
    for (var i = 0; i < actions.length; i++) {
      Button button = new Element.tag('gex-button') as Button;
      
      ActionDescriptor  action = actions[i];
      button.label = action.name ;
      
      num left = 0;
      if ( Orientation.est ==  orientation ){
        left =  i * position.width ;
        this.postion.width = left + position.width ;
      }
      if ( Orientation.west ==  orientation ){
        left =  - i * position.width ;
        this.postion.left =  left - position.width ;
      }
      
      num top = 0;
      if ( Orientation.south ==  orientation ){
        top =  i * position.height ;
        this.postion.height = (i+1) * position.height ;
      }
      if ( Orientation.north ==  orientation ){
        top =  - i * position.height ;
        this.postion.height = (i+1) * position.height;
      }      
      Position currentPostion = position.clone() ;
      currentPostion..left = left
                    ..top = top ;
      
      button.moveTo(currentPostion) ;
      button.targetAction(action);
      this.append(button);
      _buttons.add(button);
    }
    
    moveTo(this.postion);
  }
  
  List<Button> get buttons{
    List<Button> buttons = new List<Button>();
    _buttons.forEach((b)=> buttons.add(b.clone(true)));
    return buttons ;
  }
  
}
