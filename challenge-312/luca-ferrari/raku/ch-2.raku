#!raku

#
# Perl Weekly Challenge 312
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
#

sub MAIN( Str $elements ) {

    my %boxes;
    for $elements.uc.comb -> $color, $box {
	%boxes{ $box }.push: $color;
    }

    my $found = 0;
    $found++ if %boxes{ $_ }.values.grep( * ~~ /R|G|B/ ).elems >= 3 for %boxes.keys;
    $found.say;
}
