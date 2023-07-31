#!raku

#
# Perl Weekly Challenge 228
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-228/>
#

sub MAIN( *@nums  where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my $bag = @nums.Bag;
    $bag.keys.grep( { $bag{ $_ } == 1 } ).sum.say;
}
