use strict;
use warnings;
use List::Util 'shuffle';

sub pick_lotto_numbers {
    my @numbers = ( 1 .. 49 );
    my @picked  = ( shuffle @numbers )[ 0 .. 5 ];
    return @picked;
}

# Test
use Test::More tests => 1;
my @result = sort { $a <=> $b } pick_lotto_numbers();
is( scalar(@result), 6, 'Six numbers are picked' );

# Additional tests to check uniqueness and range can be added

# Main
foreach my $num ( sort { $a <=> $b } pick_lotto_numbers() ) {
    print "$num\n";
}
