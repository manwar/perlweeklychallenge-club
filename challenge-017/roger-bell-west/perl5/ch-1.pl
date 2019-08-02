#! /usr/bin/perl

use strict;
use warnings;

use Memoize;
memoize('ackermann');
use Math::BigInt;

my @r;
$r[0][0]='m/n';
foreach my $m (0..3) {
  $r[$m+1][0]=$m;
  foreach my $n (0..4) {
    $r[0][$n+1]||=$n;
    $r[$m+1][$n+1]=ackermann(Math::BigInt->new($m),Math::BigInt->new($n));
  }
}

print tabular(\@r);

sub ackermann {
  no warnings 'recursion';
  my ($m,$n)=@_;
  if ($m==0) {
    return $n+1;
  } elsif ($n==0) {
    return ackermann($m-1,1);
  } else {
    return ackermann($m-1,ackermann($m,$n-1));
  }
}

sub tabular {
  my $d=shift;
  my @columnlength;
  foreach my $row (@{$d}) {
    foreach my $colno (0..$#{$row}) {
      if (!defined($columnlength[$colno]) ||
          $columnlength[$colno] < length($row->[$colno])) {
        $columnlength[$colno]=length($row->[$colno]);
      }
    }
  }
  my $format=join('  ',map {"%${_}s"} @columnlength);
  my $result='';
  foreach my $row (@{$d}) {
    $result .= sprintf($format,@{$row})."\n";
  }
  return $result;
}
