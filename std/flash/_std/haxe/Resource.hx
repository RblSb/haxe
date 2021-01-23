/*
 * Copyright (C)2005-2019 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package haxe;

@:coreApi
class Resource {
	@:nullSafety(Off)
	static var content:Array<{name:String}>;

	public static function listNames():Array<String> {
		var names = new Array();
		for (x in content)
			names.push(x.name);
		return names;
	}

	public static function getString(name:String):Null<String> {
		var b = resolve(name);
		return b == null ? null : b.readUTFBytes(b.length);
	}

	public static function getBytes(name:String):Null<haxe.io.Bytes> {
		var b = resolve(name);
		return b == null ? null : haxe.io.Bytes.ofData(b);
	}

	static function resolve(name:String):Null<flash.utils.ByteArray> {
		try {
			untyped {
				var c = __as__(__global__["flash.utils.getDefinitionByName"]("_res._" + name.split(".").join("_")), Class);
				return __new__(c);
			}
		} catch (e:Dynamic) {
			return null;
		}
	}

	static function __init__():Void {
		content = untyped __resources__();
	}
}
