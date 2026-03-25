#!/usr/bin/env perl

# Perl Weekly Challenge 215 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-215/

use Modern::Perl;

sub can_place {
    my($nums, $count) = @_;
    my $str = join '', @$nums;
    for (1 .. $count) {
        if (!($str =~ s/000/010/)) {
            return 0;
        }
    }
    return 1;
}

@ARGV==2 or die "usage: ch-2.pl 1,0,... n\n";
my @nums = split /,/, shift;
my $count = shift;
say can_place(\@nums, $count);
