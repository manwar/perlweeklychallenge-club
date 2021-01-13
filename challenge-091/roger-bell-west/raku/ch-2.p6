#! /usr/bin/perl6

use Test;

plan 2;

is(jg((1,2,1,2)),1,'example 1');
is(jg((2,1,1,0,2)),0,'example 2');

sub jg(@n) {
  my $mx=@n.end;
  my $p=0;
  loop {
    $p+=@n[$p];
    if ($p == $mx) {
      return 1;
    } elsif ($p > $mx || @n[$p] == 0) {
      return 0;
    }
  }
}
