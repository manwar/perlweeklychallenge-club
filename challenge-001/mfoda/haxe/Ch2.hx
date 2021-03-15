class Ch2 {
    public static function main() {
        function div(x, y) return x % y == 0;
        var result = [
            for (i in 1...21) {
                if (div(i,3) && div(i,5))
                    "fizzbuzz";
                else if (div(i,3))
                    "fizz";
                else if (div(i,5))
                    "buzz";
                else '$i';
            }
        ];
        Sys.println('${result.join("")}');
    }
}