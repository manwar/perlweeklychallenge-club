use warnings;
use strict;

use v5.38;

use List::Util qw(max);

my @inputs = (
    ["challenge", "e"],
    ["programming", "a"],
    ["champion", "b"],
    ["and2 Raku3 cou4sins5 Perl are4", 'e']
    );
for (@inputs) {
    my @vals = @$_;
    say join( ' ', @vals ) . " => " . reverse_substring( $vals[1], $vals[0] );
}

sub reverse_substring( $char, $string ) {
    my $idx = index $string, $char;
    my @chars = split '', $string;
    return join '', (
	( sort @chars[0..$idx] ),
	@chars[$idx+1..$#chars]
	);
}

# julia racket
