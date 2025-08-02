#!/usr/bin/env perl
#
=head1 Task 2: Bus Route

Several bus routes start from a bus stop near my home, and go to the same stop
in town. They each run to a set timetable, but they take different times to get
into town.

Write a script to find the times - if any - I should let one bus leave and
catch a strictly later one in order to get into town strictly sooner.

An input timetable consists of the service interval, the offset within the
hour, and the duration of the trip.

=head2 Example 1

	Input: [ [12, 11, 41], [15, 5, 35] ]
	Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]

Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11,
23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5
minutes past (5, 20, ...) and takes 35 minutes.

At 45 minutes past the hour I could take the route 1 bus at 47 past the hour,
arriving at 28 minutes past the following hour, but if I wait for the route 2
bus at 50 past I will get to town sooner, at 25 minutes past the next hour.

=head2 Example 2

	Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
	Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
              50, 51, 55, 56, 57, 58, 59 ]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[12, 11, 41],
      [15,  5, 35]],
     [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
    ],
	[[[12,  3, 41],
      [15,  9, 35],
      [30,  5, 25]],
     [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
         51, 55, 56, 57, 58, 59]
    ],
];

sub bus_route
{
	my $routes = shift;
	
	my %tt;
	for my $r (@$routes) {
		my ($cycle, $start, $duration) = @$r;
		while (1) {
            if (!exists($tt{$start}) or ($duration + $start) < $tt{$start}) {
                $tt{$start} = ($start + $duration);
            }
			last if $start > 60;
			$start += $cycle;
		}
	}

	my @mins;
	my @deptmins = sort {$a <=> $b} keys %tt;
	for my $i (0..59) {
        shift @deptmins if $i > $deptmins[0];
        push @mins, $i if $tt{$deptmins[1]} < $tt{$deptmins[0]};
    }
	return \@mins;
}

for (@$cases) {
    is(bus_route($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

