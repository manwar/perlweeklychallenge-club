#!/usr/bin/perl

#
# Perl Weekly Challenge - 067
#
# Task #2: Letter Phone
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-067/
#

use strict;
use warnings;

binmode STDOUT, 'encoding(UTF-8)';
print join "\n", phone_letters($ARGV[0]), '';

sub phone_letters {
    my ($digits) = @_;

    die "ERROR: Missing digits.\n"
        unless defined $digits;
    die "ERROR: Invalid digits [$digits].\n"
        unless ($digits =~ /^[0-9\*\#]+$/);

    # letter phone
    my %letter_of = (
        '1' => '_,@',
        '2' => 'abc',
        '3' => 'def',
        '4' => 'ghi',
        '5' => 'jlk',
        '6' => 'mno',
        '7' => 'pqrs',
        '8' => 'tuv',
        '9' => 'wxyz',
        '0' => '0',
        '#' => '#',
        '*' => chr(9251),
    );

    # prepare data set
    my @data = ();
    foreach my $digit (split //,$digits) {
        push @data, [ split //, $letter_of{$digit} ];
    }

    # generate all possible combinations
    my @combinations = ('');
    foreach my $members (@data) {
        @combinations = map {
            my  $member = $_;
            map $member.$_, @$members
        } @combinations;
    }

    return @combinations;
}
