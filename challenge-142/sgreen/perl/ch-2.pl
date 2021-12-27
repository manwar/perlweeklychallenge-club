#!/usr/bin/env perl

use strict;
use warnings;
use threads;
use feature 'say';
use List::Util 'any';
use Time::HiRes 'sleep';

sub _sleep_sort {
    my $seconds = shift;
    sleep $seconds;
    say $seconds;
}

sub main {
    my @sleep_seconds = @_;

    if ( any { $_ < 0 } @sleep_seconds ) {
        die "You can sort negative numbers\n";
    }

    my @threads = ();
    foreach my $seconds (@sleep_seconds) {
        my $new_thread = threads->create( '_sleep_sort', $seconds );
        push @threads, $new_thread;
    }

    foreach my $t (@threads) {
        $t->join();
    }
}

main(@ARGV);
