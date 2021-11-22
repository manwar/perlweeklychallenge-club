#!/r/bin/perl
use strict;
use warnings;

# get input
print "binary number a: ";
my $a = <STDIN>;
chomp $a;

my $a_decimal = binary_to_decimal ( $a, 0, 0 );
print "$a_decimal\n";

sub binary_to_decimal {
    my ( $binary_number, $power, $acc, $tail ) = @_;
    print "begin sub with $binary_number\n";
    return $acc if $binary_number eq '';
    $tail = chop ($binary_number);
    if ( $tail == 1 ) {
    print "if with $binary_number\n";
        $acc += 2**$power;
        $power++;
        return binary_to_decimal ( $binary_number, $power, $acc );
    }

    if ( $tail == 0 ) {
    print "elsf with $binary_number\n";
        $power++;
        return binary_to_decimal ( $binary_number, $power, $acc );
    }
}