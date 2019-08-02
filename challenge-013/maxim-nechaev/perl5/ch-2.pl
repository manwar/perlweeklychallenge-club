#!/usr/bin/perl -w
use strict;
use feature 'say';
no warnings 'recursion';

sub F { my $n=shift; $n>0? $n - M(F($n-1)) : 1 }
sub M { my $n=shift; $n>0? $n - F(M($n-1)) : 0 }

say F(99);	# 61
say M(101);	# 63
