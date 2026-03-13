#!/usr/bin/env perl

use Modern::Perl;
use Math::Combinatorics;

my @perm = find_permutation(@ARGV);
say "(", join(", ", @perm), ")";

sub find_permutation {
    my($s) = @_;
    my @s = split //, $s;
    my @n = (0 .. length($s));
    my $combinat = Math::Combinatorics->new(count => scalar(@n), data => \@n);
    my @permu;
    while (@permu = $combinat->next_permutation) {
        if (check_permu(\@s, \@permu)) {
            return @permu;
        }
    }
    return ();
}

sub check_permu {
    my($s, $permu) = @_;
    my @s = @$s;
    my @permu = @$permu;

    for my $i (0 .. $#permu-1) {
        if (!($s[$i] eq 'I' && $permu[$i] < $permu[$i+1] ||
              $s[$i] eq 'D' && $permu[$i] > $permu[$i+1])) {
            return 0;
        }
    }
    return 1;
}
