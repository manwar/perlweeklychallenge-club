#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my (@seq,%seq_hash);

say "@{[ ulam(1,2,100) ]}";
say "@{[ ulam(2,3,100) ]}";
say "@{[ ulam(2,5,100) ]}";

sub ulam {
  my%seq_hash=map{$_,$_}my@seq=($_[0],my$n=$_[1]);
  for(;scalar @seq<$_[2];++$n){
    push@seq,$seq_hash{$n}=$n if 1==grep{2*$_<$n&&$seq_hash{$n-$_}}@seq;
  }
  @seq;
}

