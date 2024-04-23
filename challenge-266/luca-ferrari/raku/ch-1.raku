#!raku

#
# Perl Weekly Challenge 266
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
#

sub MAIN( Str $left, Str $right ) {
    my $bag-left  = Bag.new( $left.split( / \W+ / ).map( { .lc } ) );
    my $bag-right = Bag.new( $right.split( / \W+ / ).map( { .lc } ) );

    my @found-words;

    @found-words.push: $_ for $bag-left.keys.grep( -> $left,  { $bag-left{ $left } == 1 && ! $bag-right.keys.grep( { $left eq $_ } ) } );
    @found-words.push: $_ for $bag-right.keys.grep( -> $right,  { $bag-right{ $right } == 1 && ! $bag-left.keys.grep( { $right eq $_ } ) } );
    @found-words.join( ', ' ).say;
}
