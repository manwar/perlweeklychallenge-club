#!perl.exe

use strict;
use warnings;

# AUTHOR: Robert DiCicco
# DATE: 2022-08-29
# Challenge 180 First Unique Character ( Perl )

my %letters = ();
my @arr;
my $index;

my @strs = ('Long Live Perl','Perl Weekly Challenge');

foreach my $str ( @strs){

  $index = 0;

  print "Input: \$s = \"$str\"\n";

  mysetup($str);

  process();

}

sub mysetup {

  %letters = ();

  my $str = shift;

  @arr = split('',$str);

  foreach (@arr) {

    $_ = lc($_);

    ! exists($letters{$_}) ? $letters{$_} = 1 : $letters{$_}++;

  }

}

sub process {

  while($index <= $#arr){

    if($letters{$arr[$index]} == 1) {

      print("Output: $index as \"$arr[$index]\" is the first unique character\n\n");

      last;

    }

    $index++;

  }

}
