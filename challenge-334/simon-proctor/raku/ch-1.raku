#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is range-sum( x=>0, y=>2, -2, 0, 3, -5, 2, -1), 1;
    is range-sum( x=>1, y=>3, 1, -2, 3, -4, 5), -3;
    is range-sum( x=>3, y=>4, 1, 0, 2, -1, 3), 2;
    is range-sum( x=>0, y=>3, -5, 4, -3, 2, -1, 0), -2;
    is range-sum( x=>0, y=>2, -1, 0, 2, -3, -2, 1), 1;
    done-testing;
}

sub range-sum( Int() :$x, Int() :$y, *@ints where all(@ints) ~~ Int() ) { [+] @ints[$x..$y] }
                                   
