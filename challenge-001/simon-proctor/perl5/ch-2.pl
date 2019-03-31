use v5.10;
use strict;

sub fz { $_[0] % 3 == 0 ? "Fizz" : "" }
sub bz { $_[0] % 5 == 0 ? "Buzz" : "" }
sub fb { my $i = shift; (fz( $i ) . bz( $i ) ) || $i }

say join( "\n", map { fb($_) } (1..20) )
