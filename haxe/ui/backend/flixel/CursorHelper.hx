package haxe.ui.backend.flixel;

class CursorHelper {
    public static var useCustomCursors:Bool = true;
    public static var registeredCursors:Map<String, CursorInfo> = new Map<String, CursorInfo>();

    public static function registerCursor(name:String, graphic:String, scale:Float = 1, offsetX:Int = 0, offsetY:Int = 0) {
        registeredCursors.set(name, {
            name: name, 
            graphic: graphic, 
            scale: scale, 
            offsetX: offsetX, 
            offsetY: offsetY, 
        });
    }

    public static function hasCursor(name:String):Bool {
        #if haxeui_flixel_no_custom_cursors
        return false;
        #end

        if (!useCustomCursors) {
            return false;
        }
        preregisterCursors();
        return registeredCursors.exists(name);
    }

    private static var _cursorsPreregistered:Bool = false;
    private static function preregisterCursors() {
        if (_cursorsPreregistered) {
            return;
        }

        _cursorsPreregistered = true;

        if (!registeredCursors.exists("pointer")) {
            registerCursor("pointer", "haxeui-flixel/styles/default/cursors/pointer.png", 1, -10, -1);
        }
    }
}

private typedef CursorInfo = {
    var name:String;
    var graphic:String;
    var scale:Float;
    var offsetX:Int;
    var offsetY:Int;
}