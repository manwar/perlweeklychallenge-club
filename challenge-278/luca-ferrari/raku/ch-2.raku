#!raku

#
# Perl Weekly Challenge 278
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
#

sub MAIN( Str $word, Str $char ) {
    $word.say and exit if ( $word !~~ / $char / );

    my @chars;
    for $word.comb {
	@chars.push: $_;
	last if $_ eq $char;
    }

    say @chars.sort.join( '' ) ~ $word.comb[ @chars.elems .. * ].join( '' );
}
