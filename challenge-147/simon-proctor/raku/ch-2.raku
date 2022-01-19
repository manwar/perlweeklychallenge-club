#!/usr/bin/env raku

my @pentagons = (1..*).map( { $_ * ((3 * $_)-1) / 2 });

my @vals = lazy gather {
    for (0..5000) -> $i {
        for (0..^$i) -> $j {
            take (@pentagons[$i], @pentagons[$j], $i+$j);
        }
    }
};

@vals.race.grep(
    -> (\a, \b, \m) {
        my \check = Set(@pentagons[^m]);
        ((a - b) (elem) check) && ((a + b) (elem) check);
    }
).map( -> (\a, \b, \m) { ( a, b ) } ).first.say
