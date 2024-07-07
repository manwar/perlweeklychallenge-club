use strict;
use warnings;

use v5.38;

my @inputs = (
    [12, 12, 30, 24, 24],
    [72, 48, 24, 5],
    [12, 18, 24],
    [36, 36, 36, 1, 1, 1, 1, 1, 1, 47, 47, 47, 47]
    );

for (@inputs) {
    my @input = @$_;
    say join (", ", @input) . " =#completed days=> " . check_completed_days( @input );
}

sub check_completed_days( @hours ) {
    no warnings 'uninitialized';
    
    my $count;
    my %hours_rem_count;
    for (@hours) {
	my $idx = $_ % 24;
	my $inverse_idx = (24 - $idx) % 24;
	$count += $hours_rem_count{ $inverse_idx };
	++$hours_rem_count{ $idx };
    }
    return $count;
}

