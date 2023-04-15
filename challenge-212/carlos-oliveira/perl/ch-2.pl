use strict;
use warnings;
use v5.36;

use Test::More;
use List::UtilsBy qw(extract_first_by);

sub arrange_groups ($size, @list) {
  return -1 if @list % $size;
  my @sorted_list = sort @list;
  my @groups;
  for my $first_in_group (@sorted_list) {
    my @group = ($first_in_group);
    for my $next_in_group ($first_in_group + 1 .. $first_in_group + $size - 1) {
      my $val = extract_first_by { $_ == $next_in_group } @sorted_list;
      return -1 unless $val;
      push @group, $val;
    }
    push @groups, \@group;
  }
  return @groups;
}

is_deeply [arrange_groups (3, (1, 2, 3, 5, 1, 2, 7, 6, 3))],
  [ [1 ,2, 3], [1, 2, 3], [5, 6, 7] ];

is_deeply [arrange_groups (2, (1, 2, 3))], [-1];

is_deeply [arrange_groups (3, (1, 2, 4, 3, 5, 3))],
  [ [1 ,2, 3], [3, 4, 5] ];

is_deeply [arrange_groups (3, (1, 5, 2, 6, 4, 7))], [-1];

done_testing;
