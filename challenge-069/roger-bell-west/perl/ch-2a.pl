#! /usr/bin/perl

use strict;
use warnings;

my $s='';
my $n=0;
while (1) {
  print "S$n = \"$s\"\n";
  my @i;
  my $l=-1;
  do {
    $l=index($s,'1',$l+1);
    if ($l>-1) {
      push @i,$l+1;
    }
  } while ($l!=-1);
  print join(',',@i),"\n";
  $s=plusone($s);
  $n++;
  sleep 1;
}

sub plusone {
  my $in=shift;
  return join('',$in,'0',switch(rev($in)));
}

sub switch {
  my $str=shift;
  $str =~ s/1/x/g;
  $str =~ s/0/1/g;
  $str =~ s/x/0/g;
  return $str;
}

sub rev {
  my @in=split '',shift;
  return join('',reverse @in);
}
