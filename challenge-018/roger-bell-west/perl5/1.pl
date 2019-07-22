#! /usr/bin/perl

use strict;
use warnings;

print map {"$_\n"} lcsubstr(@ARGV);

sub lcsubstr {
  my @str=@_;
  if (scalar @str < 2) {
    return @str;
  }
  my @a=lcsubstr2(shift @str,shift @str);
  while (@str) {
    my %b;
    my $c=shift @str;
    foreach my $a (@a) {
      map {$b{$_}=1} lcsubstr2($a,$c);
    }
    @a=sort keys %b;
  }
  return @a;
}

# don't use this, use String::LCSS_XS instead
sub lcsubstr2 { # https://en.wikipedia.org/wiki/Longest_common_substring_problem#Pseudocode
  my @s=split '',shift;
  my @t=split '',shift;
  my %l;
  my $z=0;
  my @ret;
  foreach my $si (0..$#s) {
    foreach my $ti (0..$#t) {
      if ($s[$si] eq $t[$ti]) {
        if ($si==0 || $ti==0) {
          $l{$si}{$ti}=1;
        } else {
          $l{$si}{$ti}=($l{$si-1}{$ti-1} || 0)+1;
        }
        if ($l{$si}{$ti} > $z) {
          $z=$l{$si}{$ti};
          @ret=();
        }
        if ($l{$si}{$ti} == $z) {
          push @ret,join('',@s[$si-$z+1..$si]);
        }
      }
    }
  }
  return @ret;
}
