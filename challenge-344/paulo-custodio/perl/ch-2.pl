#!/usr/bin/env perl

# Perl Weekly Challenge 344 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/

use Modern::Perl;

@ARGV==2 or die "usage: #0 'n n, n n, ...' 'n n n'\n";
my($source, $target) = @ARGV;
my @parts = split /,/, $source;
my @source = map {[split ' ', $_]} @parts;
my @target = split ' ', $target;

say array_formed(\@source, \@target) ? "true" : "false";

sub array_formed {
    my($source, $target) = @_;
    my @source = @$source;
    my @target = @$target;

main_loop:
    while (@target) {
        return unless @source;
        # find a starting segment
        for my $i (0 .. $#source) {
            my @segment = @{$source[$i]};
            next unless @segment;
            if (is_prefix(\@target, \@segment)) {
                @target = @target[ scalar(@segment) .. $#target ];
                splice(@source, $i, 1);
                next main_loop;
            }
        }
        return;
    }
    return 1;
}

sub is_prefix {
    my($a, $b) = @_;
    my @a = @$a;
    my @b = @$b;
    for (my $i = 0; $i < @a && $i < @b; $i++) {
        return if $a[$i] != $b[$i];
    }
    return 1;
}
