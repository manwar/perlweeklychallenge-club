use strict;
use warnings;

my $upper = 1_000_000_000_000_000;
my ( $min, $max ) = @ARGV;
die "\$min must be a positive integer"
    unless $min && $min =~ m/^\d+$/ && $min >= 1 && $min <= $upper;
die "\$max must be a positive integer >= \$min"
    unless $max && $max =~ m/^\d+$/ && $max >= 1 && $min <= $max && $max <= $upper;

my %reverse = (
    0 => 0,
    1 => 1,
    6 => 9,
    8 => 8,
    9 => 6,
);

my @strobos = ();
MAIN:
for my $n ( $min .. $max ) {
    next if $n =~ m/[^01689]/;
    my $len = length( $n );
    my @digits = split( m//, $n );
    for ( my $i = 0; $i < scalar( @digits ); $i++ ) {
        last if $i >= $len / 2;
        next MAIN unless $digits[ $len - $i - 1 ] == $reverse{ $digits[$i] };
    }
    push( @strobos, $n );
}
print join( "\n", @strobos ) . "\n";
