#! /usr/bin/perl6

use Test;

plan 2;

is(us('littleit','lit'),5,'example 1');
is(us('london','lon'),3,'example 2');

sub us($text,$match) {
  my %s;
  {
    my $i=0;
    for $text.comb -> $c {
      unless %s{$c} {
        %s{$c}=Array.new;
      }
      push %s{$c},$i;
      $i++;
    }
  }
  my @j;
  for $match.comb -> $c {
    if (%s{$c}:exists) {
      push @j,%s{$c};
    } else {
      return 0;
    }
  }
  my @o=(1) xx @j[0].elems;
  for 1..@j.elems-1 -> $m {
    my @n;
    for 0..@j[$m].elems-1 -> $bi {
      my $t=0;
      for 0..@j[$m-1].elems-1 -> $ai {
        if (@j[$m-1][$ai] < @j[$m][$bi]) {
          $t+=@o[$ai];
        }
      }
      push @n,$t;
    }
    @o=@n;
  }
  return sum(@o);
}
