#!/usr//bin/perl
# Example 1:
# 
# Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
# Output: true
# 
# We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
# The average of the two arrays are the same i.e. 4.5.
# 
# Example 2:
# 
# Input: @list = (1, 3)
# Output: false

use strict;
use warnings;
use List::Util qw/sum0/;
use Test::More;

my $cases = [
    [1, 2, 3, 4, 5, 6, 7, 8],
    [1, 3],
];

sub avg
{
	my $a = shift;
	return sum0(@$a) / @$a;
}

sub combine
{
  my ($list, $n) = @_;
  die "Insufficient list members" if $n > @$list;

  return map [$_], @$list if $n <= 1;

  my @comb;

  for (my $i = 0; $i+$n <= @$list; ++$i) {
    my $val  = $list->[$i];
    my @rest = @$list[$i+1..$#$list];
    push @comb, [$val, @$_] for combine(\@rest, $n-1);
  }

  return @comb;
}

sub split_array
{
	my $lref = shift;

    my $idx = [0..$#$lref];
	my @idxlist;
	my $n = 0;
	while ($n < int(@$idx / 2)) {
		push @idxlist, combine($idx, ++$n);
	}

	for my $i (@idxlist) {
		my @l = $lref->@[@$i];
		my @r = @$lref;
		delete @r[@$i];
        @r = grep { defined } @r;
        my $lavg = avg(\@l);
        my $ravg = avg(\@r);
        if (abs($lavg - $ravg) < 0.001) {
			#print join('|', @$i), '--', join('|', @l), ' - ', join('|', @r),
			#	' -> ', $lavg, '<=>', $ravg, "\n";
			return 1
		}
    }
	return 0;
}

is(split_array($cases->[0]), 1, '[1, 2, 3, 4, 5, 6, 7, 8]');
is(split_array($cases->[1]), 0, '[1, 3]');
done_testing();

exit 0;

