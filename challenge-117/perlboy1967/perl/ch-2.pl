#!/usr/bin/perl

# Perl Weekly Challenge - 117
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-117/#TASK2
#
# Task 2 - Find Possible Paths
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;
use Test::Deep;

# Prototype(s)
sub findPossiblePaths($);

my %tests = (
   1 => [qw(R LH)],
   2 => [qw(RR RLH LRH LLHH LHR LHLH)],
   3 => [qw(RRR RRLH RLRH RLLHH RLHR RLHLH LRRH LRLHH LRHR
            LRHLH LLRHH LLLHHH LLHRH LLHLHH LLHHR LLHHLH 
            LHRR LHRLH LHLRH LHLLHH LHLHR LHLHLH)],
);

foreach my $test (sort keys %tests) {
  cmp_deeply(findPossiblePaths($test),
             $tests{$test},
             "findPossiblePaths($test)");
}

done_testing;

print "Now some bigger challenges...\n";
for my $size (4 .. 10) {
  printf "findPossiblePaths($size) = %d paths\n", 
         scalar @{findPossiblePaths($size)};
}


sub findPossiblePaths($) {
  my ($size) = @_;

  my ($arRes,$arPath) = ([],[]);
  _fpp($arRes,$arPath,$size,0,0);
  return $arRes;
}

sub _fpp {
  my ($arRes,$arPath,$size,$level,$pos) = @_;

  if ($level==$size and $pos==$level) {
    push(@$arRes,join('',@$arPath));
    return;
  }

  _fpp($arRes,[@$arPath,'R'],$size,$level+1,$pos+1) if ($level<$size); 
  _fpp($arRes,[@$arPath,'L'],$size,$level+1,$pos)   if ($level<$size);
  _fpp($arRes,[@$arPath,'H'],$size,$level,  $pos+1) if ($pos<$level); 
}
