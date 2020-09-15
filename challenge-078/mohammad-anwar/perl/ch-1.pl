#!/usr/bin/perl

#
# Perl Weekly Challenge - 078
#
# Task #1: Leader Element
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use strict;
use warnings;
use List::Util qw(max);

printf("%s\n", join(", ", leader_elements(get_list($ARGV[0]))));

#
#
# METHODS

sub leader_elements {
    my ($list) = @_;

    my @leaders = ();
    my $i       = 0;
    my @array   = @$list;
    foreach my $n (@array) {
        if ($i == $#array) {
            push @leaders, $n;
        }
        else {
            push @leaders, $n
                if ($n > max(@array[$i+1 .. $#array]));
        }
        $i++;
    }

    return @leaders;
}

sub get_list {
    my ($l) = @_;

    die "ERROR: Missing list.\n"      unless defined $l;
    die "ERROR: Invalid list [$l].\n" unless ($l =~ /^[\-?\d\,?\s?]+$/);

    $l =~ s/\s//g;
    return [ split /\,/, $l ];
}
