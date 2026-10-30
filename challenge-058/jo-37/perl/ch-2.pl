#!/usr/bin/perl

use Test2::V0;
use List::MoreUtils qw(pairwise firstidx reduce_1);

# exchange item at position $pos and next taller item.
# return position of found next item.
sub exchange {
	my ($items, $pos) = @_;
	my $pos_height = $items->[$pos]{height};
	my $next = $pos + firstidx {$_->{height} > $pos_height}
		@$items[$pos..$#$items];
	@$items[$pos, $next] = @$items[$next, $pos];
	return $next;
}

sub lineup {
	my ($heights, $talls) = @_;
	die "hights and talls have different sizes" if @$heights != @$talls;

	# collect hights and talls into single array.
	my @items = sort {$a->{height} <=> $b->{height}}
		pairwise { {height => $a, taller => $b} } @$heights, @$talls;

	# check solvability: the required number of taller predecessors must
	# not exceed the number of taller items.
	reduce_1 {$a && $b->{taller} <= $#items - $_} @items
			or die "no solution";

	# create an index to locate items in the array.
	my @index = (0 .. $#items);

	# process items by size.
	for (my $i = 0; $i < @index; $i++) {
		my $pos = $index[$i];
		my $item = $items[$pos];

		# move item to the right for the desired number of taller
		# predecessors.
		foreach my $offs (1 .. $item->{taller}) {
			# store new position of moved item
			$index[$i + $offs] = $pos;
			$pos = exchange \@items, $pos;
		}
	}
	return [map $_->{height}, @items];
}

# main

my @H = (2, 6, 4, 5, 1, 3);
my @T = (1, 0, 2, 0, 1, 2);
my @A = (5, 1, 2, 6, 3, 4);

my $result = lineup \@H, \@T;
is $result, \@A, 'first example';

# Heights
@H = (27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
      34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
      48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
       5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33);

# Number taller people in front
@T = ( 6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
      29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
      13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
       2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12);

# Expected answer
@A = (35, 23,  5, 64, 37,  9, 13, 25, 16, 44, 50, 40,  2, 27, 36,  6,
      18, 54, 20, 39, 56, 45, 12, 47, 17, 33, 55, 30, 26, 51, 42, 53,
      49, 41, 32, 15, 22, 60, 14, 46, 24, 59, 10, 28, 62, 38, 58, 63,
       8, 48,  4,  7, 31, 19, 61, 43, 57, 11,  1, 34, 21, 52, 29,  3);

$result = lineup \@H, \@T;
is $result, \@A, 'second example';

done_testing;
