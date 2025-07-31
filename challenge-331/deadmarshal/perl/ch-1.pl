#!/usr/bin/env perl
use strict;
use warnings;

sub last_word{
  length((split /\s/,$_[0])[-1])
}

printf "%d\n",last_word('The Weekly Challenge');
printf "%d\n",last_word('    Hello World    ');
printf "%d\n",last_word('Let\'s begin the fun');

