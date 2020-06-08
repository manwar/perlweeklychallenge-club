#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);
use utf8;

my @in=(
  [qw(1 2 3)],
  [qw(4 5 6)],
  [qw(7 8 9)],
    );

my @l=([0,0]);

my $s;
my @p;

while (@l) {
  my $t=shift @l;
  my @xy=splice @{$t},0,2;
  push @{$t},$in[$xy[0]][$xy[1]];
  if ($t->[-1] == $in[-1][-1]) {
    my $sa=sum(@{$t});
    if (!defined $s || $sa < $s) {
      $s=$sa;
      @p=@{$t};
    }
  }
  if ($xy[0] < $#in && $xy[1] <= $#{$in[$xy[0]+1]}) {
    push @l,[$xy[0]+1,$xy[1],@{$t}];
  }
  if ($xy[1] < $#{$in[$xy[0]]}) {
    push @l,[$xy[0],$xy[1]+1,@{$t}];
  }
}

binmode STDOUT,':utf8';
print "$s ( ".join(' → ',@p)." )\n";
