use strict;
use warnings;
use feature 'say';

sub uncommon {
    my %histo;
    $histo{$_}++ for map { split /\s+/ } @_;
    my @result = grep {$histo{$_} == 1} keys %histo;
    return @result ? join " ", @result : "''";
}

my @tests = ( ['Mango is sweet', 'Mango is sour'],
              ['Mango Mango', 'Orange'],
              ['Mango is Mango', 'Orange is Orange'] );
for my $test (@tests) {
    printf "%-18s - %-18s => ", $test->[0], $test->[1];
    say uncommon $test->[0], $test->[1];
}
