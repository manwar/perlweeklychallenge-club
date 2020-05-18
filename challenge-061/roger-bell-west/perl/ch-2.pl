#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min);

my $in=$ARGV[0] || '25525511135';

my @buf=([$in]);
while (my $t=shift @buf) {
  my @l=@{$t};
  my $r=pop @l;
  if ($r eq '' && scalar @l == 4) {
    print join('.',@l),"\n";
  }
  if (scalar @l >= 4) {
    next;
  }
  foreach my $fl (1..min(3,length($r))) {
    my $a=substr($r,0,$fl);
    if ($a <= 255 && ($a==0 || $a =~ /^[1-9]/)) {
      my $b=substr($r,$fl);
      push @buf,[@l,substr($r,0,$fl),$b];
    }
  }
}
