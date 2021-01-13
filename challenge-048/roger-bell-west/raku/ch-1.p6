#! /usr/bin/perl6

my @list=(1..50);
my $n=0;

while (@list.elems > 1) {
  $n++;
  if ($n>@list.end) {
    $n=0;
  }
  splice @list,$n,1;
}

say @list[0];
