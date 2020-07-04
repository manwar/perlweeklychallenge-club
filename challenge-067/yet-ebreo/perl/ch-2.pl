#!/usr/bin/perl
use strict;
use feature 'say';


say $_ for glob join "",map "{".qw(-,@ ABC DEF GHI JKL MNO PQRS TUV WXYZ)[$_-1]=~s/\B/,/gr."}", ($ARGV[0] || '35')=~/./g