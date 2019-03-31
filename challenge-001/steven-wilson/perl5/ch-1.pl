#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-03-25
# Challenge 1
# Write a script to replace the character ‘e’ with ‘E’ in the string 
# ‘Perl Weekly Challenge’. Also print the number of times the character 
# ‘e’ found in the string.

use warnings;
use strict;
use feature qw/ say /;

my $string = 'Perl Weekly Challenge';
my $count = 0;
my $index = 0;
my $loop = 1;

while($loop){
    $index = index($string, 'e', $index);
    if($index == -1){
        $loop = 0;
    } else {
        substr($string, $index, 1) = 'E';
        $count++;
    }
}

say $string;
say "The character 'e' was found $count times in the string."