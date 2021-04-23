#!/usr/bin/raku

sub bellNumber(Int $n) {
    my @bell;
    @bell[0][0] = 1;
    for 1 .. $n -> $i {
        @bell[$i][0] = @bell[$i - 1][$i - 1];
 
        for 1 .. $i -> $j {
            @bell[$i][$j] = @bell[$i - 1][$j - 1] + @bell[$i][$j - 1];
        }
    }
    return @bell[$n][0];
}
 
sub MAIN() {
    for 0 .. 9 -> $n {
        print bellNumber($n), q{ };
    }
    print "\n";
}