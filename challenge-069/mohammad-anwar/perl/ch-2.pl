#!/usr/bin/perl

#
# Perl Weekly Challenge - 069
#
# Task #2: 0/1 String
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069
#

use strict;
use warnings;

my $string = $ARGV[0];
print sprintf("%s\n%s\n", $string, string_0_1($string));

sub string_0_1 {
    my ($string) = @_;

    die "ERROR: Missing string.\n"
        unless defined $string;
    die "ERROR: Invalid string [$string].\n"
        unless ($string =~ /s\d+/i);

    if ($string =~ /(\d+)/) {
        my $limit = $1;
        die "ERROR: Invalid string [$string]. S30 is the limit.\n"
            if ($limit > 30);

        my $string_0_1 = '';
        foreach (1 .. $limit) {
            my $_string_0_1 =  reverse $string_0_1;
            $_string_0_1    =~ tr/[01]/[10]/;
            $_string_0_1    =  '0'. $_string_0_1;
            $string_0_1     =  $string_0_1 . $_string_0_1;
        }

        return $string_0_1;
    }
}
