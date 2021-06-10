#! /usr/bin/perl

use strict;
use warnings;

use Text::CSV_XS;

my $csv = Text::CSV_XS->new({eol => $/});

my $fh;
if (defined $ARGV[0] && -e $ARGV[0]) {
  open $fh,'<',$ARGV[0];
} else {
  $fh=*STDIN;
}

my @a;
my $ri=0;
while (my $row=$csv->getline($fh)) {
  foreach my $ci (0..$#{$row}) {
    $a[$ci][$ri]=$row->[$ci];
  }
  $ri++;
}

close $fh;

$csv->say(*STDOUT,$_) for @a;
