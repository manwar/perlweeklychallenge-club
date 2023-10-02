#!/usr/bin/env perl
use strict;
use warnings;

sub count_words
{
  scalar grep{/^\Q$_[1]/} @{$_[0]};
}

printf "%d\n",count_words([qw/pay attention practice attend/],'at');
printf "%d\n",count_words([qw/janet julia java javascript/],'ja');

