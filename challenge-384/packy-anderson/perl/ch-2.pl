#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( sum );

sub specialBinarySubstrings($binary) {
  my @arr = split //, $binary;
  # special case: all 0s or all 1s
  my $len = @arr;
  my $sum = sum @arr;
  return () if $sum == 0 || $sum == $len;
  my %seen; # keep track of substrings already checked
  # generate substrings and check
  for my $i ( 0 .. $#arr - 1 ) {
    for my $j ( $i + 1 .. $#arr ) {
      my @subarr = @arr[$i .. $j];
      my $substr = join '', @subarr;
      next if exists $seen{$substr};
      if (sum(@subarr) == scalar(@subarr)/2) { # equal num 0 & 1
        if (($substr =~ s/^0+//r) =~ /^1+$/ ||
            ($substr =~ s/0+$//r) =~ /^1+$/) { # consecutive
          $seen{$substr} = 1;
          next;
        }
      }
      $seen{$substr} = 0;
    }
  }
  sort grep { $seen{$_} } keys %seen;
}

sub solution($binary) {
  say qq{Input: \$binary = "$binary"};
  my $output = join ', ', 
               map { qq/"$_"/ }
               specialBinarySubstrings($binary);
  say 'Output: (' . $output . ')';
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
