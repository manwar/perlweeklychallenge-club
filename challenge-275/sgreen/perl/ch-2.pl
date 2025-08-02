#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::MoreUtils 'first_index';

sub main ($str) {
    my $current_letter_pos = undef;
    my $solution = '';
    my @alphabet = ('a'..'z');

    foreach my $char (split //, $str) {
        if ($char =~ /[0-9]/) {
            if (not defined $current_letter_pos) {
                die "The first number must follow a letter\n";
            }

            $solution .= $alphabet[($current_letter_pos + $char) % 26];
        }
        else {
            $solution .= $char;
            $current_letter_pos = first_index { $_ eq $char } @alphabet;
        }
    }

    say $solution;
}

main(@ARGV);