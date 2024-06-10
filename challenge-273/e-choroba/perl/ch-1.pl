#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use POSIX qw{ round };

sub percentage_of_character($str, $char) {
    my $count =()=  $str =~ /\Q$char/g;
    return round(100 * $count / length $str)
}

use Test::More tests => 6;

is percentage_of_character('perl', 'e'), 25, 'Example 1';
is percentage_of_character('java', 'a'), 50, 'Example 2';
is percentage_of_character('python', 'm'), 0, 'Example 3';
is percentage_of_character('ada', 'a'), 67, 'Example 4';
is percentage_of_character('ballerina', 'l'), 22, 'Example 5';
is percentage_of_character('analitik', 'k'), 13, 'Example 6';
