#!raku

#
# Perl Weekly Challenge 255
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-255>
#

sub MAIN( Str :$p is copy, Str :$w ) {

    $p ~~ s:g/ \W* $w \W+/ /;
    my $classification = Bag.new: $p.split( / \W+ /, :skip-empty );
    $classification.keys.grep( { $classification{ $_ } == $classification.values.max } ).first.say;

}
