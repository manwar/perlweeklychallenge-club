#!/usr/bin/env raku
use v6;

sub specialBinarySubstrings($binary) {
  my @arr = $binary.comb;
  # special case: all 0s or all 1s
  my $len = @arr.elems;
  my $sum = @arr.sum;
  return () if $sum == 0 || $sum == $len;
  my %seen; # keep track of substrings already checked
  # generate substrings and check
  for 0 .. @arr.end - 1 -> $i {
    for $i + 1 .. @arr.end -> $j {
      my @subarr = @arr[$i .. $j];
      my $substr = @subarr.join;
      next if %seen{$substr}:exists;
      if (@subarr.sum == @subarr.elems/2) { # equal num 0 & 1
        if ($substr.subst(/^0+/, "") ~~ /^1+$/ ||
            $substr.subst(/0+$/, "") ~~ /^1+$/) { # consecutive
          %seen{$substr} = True;
          next;
        }
      }
      %seen{$substr} = False;
    }
  }
  %seen.keys.grep({ %seen{$_} }).sort;
}

sub solution($binary) {
  say qq{Input: \$binary = "$binary"};
  my $output = specialBinarySubstrings($binary)
               .map({ qq/"$_"/ }).join(', ');
  say 'Output: (' ~ $output ~ ')';
}

say "Example 1:";
solution("0101");

say "\nExample 2:";
solution("000111");

say "\nExample 3:";
solution("000011");

say "\nExample 4:";
solution("10011100");

say "\nExample 5:";
solution("00000");
