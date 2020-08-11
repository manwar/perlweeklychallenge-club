#! /usr/bin/perl6

my @rooms=1 xx 500;

for 2..500 -> $n {
  loop (my $k=$n-1 ; $k <500 ; $k+=$n) {
    @rooms[$k]=1-@rooms[$k];
  }
}

map {say $_+1}, grep {@rooms[$_]==1}, (0..@rooms.end);
