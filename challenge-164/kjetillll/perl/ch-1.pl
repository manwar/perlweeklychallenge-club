#!/usr/bin/perl
use warnings; use strict;

sub is_palindromic { local $_ = shift//$_;        /^((.)(?1)\2|.?)$/ }
sub is_prime       { local $_ = 1 x (shift//$_); !/^1?$|^(11+?)\1+$/ }

print join' ', grep is_palindromic && is_prime, 1..999;
print "\n";
