#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;


sub new_queue {
    my @queue;  # an AoA
    my $is_empty = sub {
        for my $item (@queue) {
            next unless defined $item;
            return 0 if @$item > 0;
        }
        return 1;
    };
    my $insert_with_prio = sub {
        my ($item, $prio) = @_;
        push @{$queue[$prio]}, $item;
    };
    my $pull_highest_prio = sub {
        for my $item (reverse @queue) {
            next unless defined $item;
            return shift @$item if @$item > 0;
        }
    };
    return $is_empty, $insert_with_prio, $pull_highest_prio;
}

my ($is_empty, $insert, $pull_prio) = new_queue;
for my $num (1..20) {   # inserting 20 items into the queue
    $insert->($num,
        $num % 10 == 0 ? 10 :
        $num % 5  == 0 ? 5  :
        $num % 3  == 0 ? 3  :
        $num % 2  == 0 ? 2  :
        1);
}
for my $num (1..20) {
    say $pull_prio->();
}
say "Empty queue" if $is_empty->();


