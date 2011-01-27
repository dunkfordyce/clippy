import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.external.ExternalInterface;

class Clippy {
  // Main
  static function main() {
    var target:String   = flash.Lib.current.loaderInfo.parameters.target;
    var defaultText:String   = flash.Lib.current.loaderInfo.parameters.text;

    if(target == null) target   = "body";
    if(defaultText == null) defaultText   = "";

    flash.Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    flash.Lib.current.stage.align     = flash.display.StageAlign.TOP_LEFT;

    // button

    var button:SimpleButton = new SimpleButton();
    button.useHandCursor    = true;
    button.upState          = flash.Lib.attach("button_up");
    button.overState        = flash.Lib.attach("button_over");
    button.downState        = flash.Lib.attach("button_down");
    button.hitTestState     = flash.Lib.attach("button_down");

    button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
      //var text:String = ExternalInterface.call("function(target, defaultText){ var data = { text: '', defaultText: defaultText }; jQuery(target).trigger('clippycopy', data); return data.text; }", target, defaultText);
      flash.system.System.setClipboard('bob');

      //ExternalInterface.call("function(target){ jQuery(target).trigger('clippycopied'); }", target);
    });

    button.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {
      ExternalInterface.call("function(target){ jQuery(target).trigger('clippyover'); }", target);
    });

    button.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {
      ExternalInterface.call("function(target){ jQuery(target).trigger('clippyout'); }", target);
    });

    flash.Lib.current.addChild(button);
  }
}
