#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Scalar::Util qw{looks_like_number};

my @numbers = ( 1221, -101, 90, 2112, 9, 90.09 );

for my $num (@numbers) {
    my $r = is_palindrome_number($num);
    say qq{Input:   $num};
    say qq{Output:  $r};
    say '';
}

# this is specifically about numbers, so we'll use 
# looks_like_number from Scalar::Util. Otherwise we'll
# assume base-10 and treat it like a decimal, which is
# how Perl likes to stringify numbers. 

# returns 0 if not a number
# returns 0 if not a palindrome
# what remains should only be palindromic numbers,
#   so returns 1

sub is_palindrome_number($num = 0) {
    return 0 unless looks_like_number($num);
    my $mun = join '', reverse split //, $num;
    return 0 unless $mun eq $num;
    return 1;
}
