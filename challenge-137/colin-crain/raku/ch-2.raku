#!/usr/bin/env perl6
#
#
#       lychrel.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

constant MAX-ITER  = 5000;
constant MAX-VALUE = 10_000_000_000;
constant ERR-LARGE = 'number too large - larger than ' ~ MAX-VALUE;
constant ERR-MANY  = 'too many iterations - more than ' ~ MAX-ITER;


for 10..1000 -> $num {
    my ($out, $res) = lychrel( $num );
    say qq:to/END/;
    Input:  $num
    Output: $out
            $res
    END
}


sub lychrel ( $num is copy ) {
    my @chain = $num;
    return 1, @chain if $num == $num.flip;
    for 1..MAX-ITER {
        my $revsum = $num + $num.flip;
        @chain.push: $revsum;
        return 1, @chain if $revsum == $revsum.flip;
        $num = $revsum;
        return 0, ERR-LARGE if $num > MAX-VALUE;
    }
    return 0, ERR-MANY;
}


