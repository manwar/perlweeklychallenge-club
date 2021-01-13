use strict;
use warnings;
use feature "say";

my @tests = qw<1122234 2333445 12345>;
say  sprintf( "%-10d -> ", $_), count_numbers($_) for @tests;

sub count_numbers {
    my $n = shift;
    my $result = "";
    my @digits = split //, $n;
    my $start = shift @digits;
    my $count = 1;
    for my $digit (@digits) {
        if ($digit eq $start) {
            $count++;
        } else {
            $result .= $count . $start;
            $count = 1;
            $start = $digit;
        }
    }
    $result .= $count . $start;
    return $result;
}
