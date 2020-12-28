#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub sum_path ($input) {
   my @rows = map { [ split m{}mxs ] } split m{\n}mxs, $input;
   my $root = 0;
   $root++ while $rows[0][$root] eq ' ';
   return _sum_path_r(\@rows, 0, $root, 0);
}

sub _sum_path_r($rows, $rid, $cid, $parent) {
   my $so_far = $parent + $rows->[$rid][$cid];
   my $sub_sum = 0;
   if ($rid < $#$rows) { # there can be something more
      $rid++;
      $sub_sum += _sum_path_r($rows, $rid + 1, $cid - 2, $so_far)
         if $cid > 0 && $rows->[$rid][$cid - 1] ne ' ';
      $sub_sum += _sum_path_r($rows, $rid + 1, $cid + 2, $so_far)
         if $cid < $#{$rows->[$rid]} && $rows->[$rid][$cid + 1] ne ' ';
   }
   return $sub_sum || $so_far;
}

my $tree = <<'END';
     1
    /
   2
  / \
 3   4
END

$tree = <<'END';
     1
    / \
   2   3
  /   / \
 4   5   6
END

say sum_path($tree);
