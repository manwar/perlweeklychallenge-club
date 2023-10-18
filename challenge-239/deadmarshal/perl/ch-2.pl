#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);

sub consistent_strings{
  my ($arr,$allowed) = @_;
  scalar grep{all{index($allowed,$_) != -1} split '',$_} @$arr;
}

printf "%d\n",consistent_strings(['ad','bd','aaab','baa','badab'],
				 'ab');
printf "%d\n",consistent_strings(['a','b','c','ab','ac','bc','abc'],
				 'abc');
printf "%d\n",consistent_strings(['cc','acd','b','ba','bac','bad',
				  'ac','d'],'cad');

