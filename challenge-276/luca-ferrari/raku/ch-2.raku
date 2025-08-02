#!raku

#
# Perl Weekly Challenge 276
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( { $_ ~~ Int && $_ > 0 } ).elems } ) {
    my %frequency;
    %frequency{ @nums.grep( * ~~ $_ ).elems }.push: $_ for @nums;
    %frequency{ %frequency.keys.max }.unique.elems.say;
}
