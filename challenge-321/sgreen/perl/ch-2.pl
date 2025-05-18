#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub convert_string($s) {
    my $new_string = '';
    foreach my $c (split //, $s) {
        if ($c eq '#') {
            # This is safe even if new_string is empty
            chop($new_string);
        }
        else {
            $new_string .= $c;
        }
    }

    return $new_string;
}

sub main ($str1, $str2) {
    my $same = convert_string($str1) eq convert_string($str2);
    say $same ? 'true' : 'false';
}

main($ARGV[0], $ARGV[1]);