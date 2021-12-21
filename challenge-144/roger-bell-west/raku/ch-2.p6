#! /usr/bin/perl6

use Test;
plan 3;

is-deeply(ulam(1,2,10),[1, 2, 3, 4,  6 , 8, 11, 13, 16, 18],'example 1');
is-deeply(ulam(2,3,10),[2, 3, 5, 7,  8,  9, 13, 14, 18, 19],'example 2');
is-deeply(ulam(2,5,10),[2, 5, 7, 9, 11, 12, 13, 15, 19, 23],'example 3');

sub ulam($u,$v,$count) {
  my @ulams=[$u,$v];
  my @sieve;
  my $uc=$v;
  while (@ulams.elems < $count) {
    my $ss=$uc+@ulams[*-2];
    @sieve.append(0 xx ($ss-@sieve.elems));
    for (0..@ulams.end-1) -> $i {
      @sieve[$uc + @ulams[$i] - 1]++;
    }
    for ($uc..@sieve.end) -> $i {
      if (@sieve[$i]==1) {
        $uc=$i+1;
        push @ulams,$uc;
        last;
      }
    }
  }
  return @ulams;
}
