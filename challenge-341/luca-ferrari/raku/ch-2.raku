#!raku

#
# Perl Weekly Challenge 341
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
#

sub MAIN( Str $text, Str $prefix where { $text ~~ / $prefix / } ) {
    my $index = $text.comb( :skip-empty ).first( * ~~ $prefix, :k );
    ( $text.comb[ 0 .. $index ].join.flip ~ $text.comb[ $index + 1 .. * - 1 ].join ).join.say;
}
