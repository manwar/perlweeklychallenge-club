#!/usr/bin/env raku
use v6;

sub secretSanta($n) {
  my @valid;
  for (1 .. $n).permutations -> @perm {
    my $is_valid = 1;
    for 0 .. $n-1 -> $i {
      if (@perm[$i] == $i+1) {
        $is_valid = 0;
        last;
      }
    }
    @valid.push(@perm) if $is_valid;
  }
  @valid.elems;
}

sub solution($n) {
  say qq/Input: \$n = $n/;
  say 'Output: ' ~ secretSanta($n);
}

say "Example 1:";
solution(1);

say "\nExample 2:";
solution(2);

say "\nExample 3:";
solution(3);

say "\nExample 4:";
solution(4);

say "\nExample 5:";
solution(5);
