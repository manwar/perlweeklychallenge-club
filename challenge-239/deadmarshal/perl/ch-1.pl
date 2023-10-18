#!/usr/bin/env perl
use strict;
use warnings;

sub same_string{
  join('',@{$_[0]}) eq join('',@{$_[1]});
}

printf "%d\n",same_string(["ab","c"],["a","bc"]);
printf "%d\n",same_string(["ab","c"],["ac","b"]);
printf "%d\n",same_string(["ab","cd","e"],["abcde"]);

