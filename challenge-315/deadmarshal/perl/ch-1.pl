#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub find_words{
  grep {$_[0]->[$_] =~ $_[1]} 0..$#{$_[0]}
}

print show find_words(['the','weekly','challenge'],'e');
print show find_words(['perl','raku','python'],'p');
print show find_words(['abc','def','bbb','bcd'],'b');

