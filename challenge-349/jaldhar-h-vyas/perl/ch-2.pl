#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

sub follow($path) {
    my $col = 0;
    my $row = 0;

    for my $direction (split //, $path) {
        for ($direction) {
            if (/U/) { $row-- }
            if (/D/) { $row++ }
            if (/L/) { $col-- }
            if (/R/) { $col++ }
        }

        if ($col == 0 && $row == 0) {
            return true;
        }
    }

    return false;
}

my $path = shift;
say 0+(follow $path) ? 'true' : 'false';