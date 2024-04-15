#!/usr/bin/env perl
use strict;
use warnings;
use Set::Scalar;

sub completing_word{
  my $s1 = Set::Scalar->new(split'',(lc $_[0] =~ s/(\s+|\d+)//gr));
  (grep{$_ if $s1 <= (Set::Scalar->new(split'',$_))}@{$_[1]})[0];
}

printf "%s\n",completing_word('aBc 11c',['accbbb','abc','abbc']);
printf "%s\n",completing_word('Da2 abc',['abcm','baacd','abaadc']);
printf "%s\n",completing_word('JB 007',['jj','bb','bjb']);

