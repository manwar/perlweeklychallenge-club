#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $num = 1221;

# Palindrome Number
my $numStr = "$num";
my $res = 0;

$res = 1 if($numStr eq reverse $numStr);

# Output
say($res);