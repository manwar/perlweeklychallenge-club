using Lambda;
using StringTools;

class Ch1 {
    public static function main() {
        var input = "Perl Weekly Challenge";
        var countE = input.split("").count(x -> x == "e");
        var replaced = input.replace("e", "E");

        Sys.println('"$replaced" [replaced $countE]');
    }
}