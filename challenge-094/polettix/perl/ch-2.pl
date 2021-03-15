#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
$|++;

sub build_linked_list ($input) {
   my @rows = map { [ split m{}mxs ] } split m{\n}mxs, $input;
   my $root = 0;
   $root++ while $rows[0][$root] eq ' ';
   my $pre_start = {};
   _build_linked_list_r(\@rows, 0, $root, $pre_start);
   return $pre_start->{next};
}

sub _build_linked_list_r($rows, $rid, $cid, $previous) {
   my $so_far = $previous->{next} = {value => $rows->[$rid][$cid]};
   if ($rid < $#$rows) { # there can be something more
      $rid++;
      if ($cid < $#{$rows->[$rid]}) {
         $so_far = _build_linked_list_r($rows, $rid + 1, $cid - 2, $so_far)
            if 0 < $cid && $rows->[$rid][$cid - 1] ne ' ';
         $so_far = _build_linked_list_r($rows, $rid + 1, $cid + 2, $so_far)
            if $rows->[$rid][$cid + 1] ne ' ';
      }
   }
   return $so_far;
}

sub print_linked_list ($head) {
   my $separator = '';
   while ($head) {
      print $separator, $head->{value};
      $separator = ' -> ';
      $head = $head->{next};
   }
   print "\n";
}

my $tree = <<'END';
        1
       / \
      2   3
     / \
    4   5
       / \
      6   7
END

print_linked_list(build_linked_list($tree));
