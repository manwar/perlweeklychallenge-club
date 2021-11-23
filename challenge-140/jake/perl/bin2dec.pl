#!/r/bin/perl
use strict;
use warnings;

# get input
print "binary number: ";
my $binary_input = <STDIN>;
chomp $binary_input;

my $a_decimal = binary_to_decimal ( $binary_input );
print "$a_decimal\n";

sub binary_to_decimal {
    my ( $binary ) = @_;

    return _binary_to_decimal ( $binary, 0, 0 );
}

sub _binary_to_decimal {
    my ( $binary_number, $power, $acc, $tail ) = @_;
    return $acc if $binary_number eq '';

    $tail = chop ($binary_number);

    if ( $tail == 1 ) {
        $acc += 2**$power;
        $power++;
        return _binary_to_decimal ( $binary_number, $power, $acc );
    }

    if ( $tail == 0 ) {
        $power++;
        return _binary_to_decimal ( $binary_number, $power, $acc );
    }
}