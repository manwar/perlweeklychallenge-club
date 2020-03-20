#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $LENGTH = 3;

my @stepping_numbers;

sub prolong {
    my (@short) = @_;
    my $last = $short[-1];
    for my $next (grep $_ >= 0 && $_ <= 9, $last - 1, $last + 1) {
        if ($LENGTH == @short + 1) {
            push @stepping_numbers, join "", @short, $next;
        } else {
            prolong(@short, $next);
        }
    }
}

prolong($_) for 1 .. 9;
say for @stepping_numbers;
