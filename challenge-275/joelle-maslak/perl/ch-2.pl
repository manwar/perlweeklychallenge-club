#!/usr/bin/perl

use JTM::Boilerplate 'script';

MAIN: {
    my $input = $ARGV[0];

    my $letter = "a";
    for my $current (split //, $input) {
        if ($current =~ /^\d$/) {
            print chr(ord($letter) + $current);
        } else {
            print $current;
            $letter = $current;
        }
    }
    say "";
}
