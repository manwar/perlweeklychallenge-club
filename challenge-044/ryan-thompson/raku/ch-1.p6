#!/usr/bin/env perl6

# ch-1.raku - Insert +/- into 123456789 to make 100
#
# Ryan Thompson <rjt@cpan.org>


my $num = 123456789;

expr-split(100, 123456789);

#| Insert +/- into $num such that the expression = $sum; output all
sub expr-split( Int $sum, Int $num, Str $exp = '', Int $psum = 0 ) {
    say $exp if $num == 0 and $psum == $sum;
    return   if $num == 0;

    for 1..$num.chars {
        my ($l, $r) = ($num.substr(0, $_), $num.substr($_))».Int;
        expr-split($sum, $r, "$exp+$l", $psum + $l);
        expr-split($sum, $r, "$exp-$l", $psum - $l);
    }
}

