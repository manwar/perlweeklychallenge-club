#!/usr/bin/env perl
# Perl weekly challenge 109
# Task 2: Chowla Numbers
#
# See https://wlmb.github.io/2021/04/19/PWC109/#task-1-chowla-numbers
use strict;
use warnings;
use v5.12;
use List::Util qw(sum0);
say join ' ',
    map {my $n=$_; sum0 map {$_**2==$n?$_:($_, $n/$_)}
	 grep {$n%$_==0} 2..sqrt($n)} @ARGV;
