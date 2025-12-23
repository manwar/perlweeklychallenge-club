#!raku

#
# Perl Weekly Challenge 352
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
#

sub MAIN( *@strings ) {
    my %found;
    for 0 ..^ @strings.elems {
	my $current = @strings[ $_ ];
	%found{ $current } = @strings[ $_ + 1 .. * - 1 ].grep( * ~~ / $current / ).elems;
    }

    %found.kv.grep( -> $k, $v { $v > 0 } ).map( *[0] ).join( ', ' ).say;
}
