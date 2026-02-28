#!/usr/bin/env perl

use JTM::Boilerplate 'script';

MAIN: {
    while (my $line = <<>>) {
        chomp $line;
        my $cnt = 1;
        for my $c (split //, $line) {
            print $c x $cnt++;
        }
        print "\n";
    }
}


