#!/usr/bin/perl

#
# Perl Weekly Challenge - 065
#
# Task #2: Palindrome Partition
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-065/
#

use strict;
use warnings;

use Test::More;
use Test::Deep;
use Algorithm::Combinatorics qw(partitions);

is_deeply find_palindromes('aabaab'),
          [['aa','baab'],['aabaa'],['aba']],
          'aabaab';
is_deeply find_palindromes('abbaba'),
          [['abba'],['bb','aba'],['bab']],
          'abbaba';
is_deeply find_palindromes('aa'),
          [['aa']],
          'aa';
is_deeply find_palindromes('ab'),
          [],
          'ab';

done_testing;

sub find_palindromes {
    my ($string) = @_;

    die "ERROR: Missing string.\n"
        unless defined $string;
    die "ERROR: String must have 2 or more alphabets. [$string]\n"
        unless (length($string) >= 2);

    my @partitions = partitions([split //, $string]);
    my %partitions = ();

    foreach my $entry (@partitions) {
        foreach my $partition (@$entry) {
            my $str = join ("", @$partition);
            next if (length($str) == 1
                     ||
                     length($str) == length($string)
                    );

            if (index($string, $str) >= 0) {
                $partitions{$str} = index($string, $str);
            }
        }
    }

    my $index = 0;
    my $palindromes     = [];
    my %seen_partitions = ();
    foreach my $primary (sort { $partitions{$a} <=> $partitions{$b} }
                         sort keys %partitions) {
        next unless ($primary eq reverse($primary));
        next if (exists $seen_partitions{$primary});

        push @{$palindromes->[$index]}, $primary;
        foreach my $secondary (sort keys %partitions) {
            next unless ($secondary eq reverse($secondary));

            if ($partitions{$secondary} >= $partitions{$primary} + length($primary)) {
                push @{$palindromes->[$index]}, $secondary;
                $seen_partitions{$secondary} = 1;
            }
        }
        $index++;
    }

    push @{$palindromes->[scalar @$palindromes]}, $string
        if ($string eq reverse($string));

    return $palindromes;
}
