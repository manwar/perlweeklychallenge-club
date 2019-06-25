#! /usr/bin/perl

use strict;
use warnings;

use Getopt::Std;

my %o=(d => 'SOWPODS',
       s => 'states');
getopts('d:s:h',\%o);

if ($o{h}) {
  print STDERR <<EOF;
Usage: $0 -d dictionary -s state
dictionary file should contain one word per line
state file should contain one abbreviation per line, whitespace, state name
EOF
  exit 0;
}

my %s;

open S,'<',$o{s};
while (<S>) {
  chomp;
  my ($ab,$state)=split ' ',$_,2;
  $s{uc($ab)}=$state;
}
close S;

my $toplen=0;
my @results;

open D,'<',$o{d};
OUTER: while (<D>) {
  chomp;
  my $w=uc($_);
  if (length($w)%2==1) {
    next OUTER;
  }
  my @list;
  while ($w) {
    my $a=substr($w,0,2);
    if (exists $s{$a}) {
      push @list,$a;
      $w=substr($w,2);
    } else {
      next OUTER;
    }
  }
  if (@list && scalar @list >= $toplen) {
    if ($toplen < scalar @list) {
      @results=();
      $toplen=scalar @list;
    }
    my $ex=join(' + ',map {$s{$_}} @list).' = '.join('',@list);
    push @results,$ex;
  }
}

print map {"$_\n"} @results;
