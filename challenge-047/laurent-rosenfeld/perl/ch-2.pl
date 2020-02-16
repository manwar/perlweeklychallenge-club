use strict;
use warnings;
use feature "say";

my @gapful = ();
my $current = 100;
do {
    my ($start, $end) = $current =~ /^(\d)\d+(\d)$/;
    push @gapful, $current unless $current % ($start . $end);
    $current ++;
} until $#gapful >= 19;
say "@gapful";
