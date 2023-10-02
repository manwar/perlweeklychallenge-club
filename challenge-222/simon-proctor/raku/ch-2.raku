#!/usr/bin/env raku

multi sub MAIN('TEST') is hidden-from-USAGE {
    use Test;
    is last-member(), 0;
    is last-member(1), 1;
    is last-member(1,1), 0;
    is last-member( |( (2,7,4,1,8,1).sort.reverse ) ), 1;    
    done-testing;
}

#| Given a list of integers do some stuff based on the challenge
multi sub MAIN (
    *@list where { @list.all ~~ Int() } #= List of Integers
) {
    last-member( |(@list.sort.reverse) ).say;
}

multi sub last-member() { 0; }
multi sub last-member($a) { $a; }
multi sub last-member($a, $b where $a ~~ $b, *@rest) {
    last-member( |@rest );
}
multi sub last-member($a, $b, *@rest) {
    last-member( |( ( $a-$b, |@rest).sort.reverse ) );
}
