package cases;

class NewCompletionInBuildMacro extends DisplayTestCase {
	/**
		class MyMacro {
			macro static public function build():Array<haxe.macro.Expr.Field> {
				return haxe.macro.Context.getBuildFields();
			}
		}

		#if !macro
		@:build(NewCompletionInBuildMacro.MyMacro.build())
		#end
		class Main {
			static function main() {
				var x = new {-1-}
			}
		}
	**/
	@:func
	function test1() {
		// The `new |` completion point uses an empty (magic) type path
		// which must survive through decode_ast_path
		eq(true, hasToplevel(toplevel(pos(1)), "type", "Array"));
	}
}
