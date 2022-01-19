#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Parallel::ForkManager;

my @unsorted = sort { rand 1 <=> rand 1 } 1 .. 10;
my $pm       = Parallel::ForkManager->new(20);

print 'Unsorted: ';
say join ' ', @unsorted;
say '';

print 'Sorted: ';
LOOP: for my $i (@unsorted) {
    my $pid = $pm->start and next LOOP;
    sleep $i;
    print qq{$i };
    $pm->finish;
}
$pm->wait_all_children;
say '';
