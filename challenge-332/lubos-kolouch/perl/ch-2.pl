#!/usr/bin/env perl
use v5.38;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util      qw(all);
use Type::Params    qw(compile);
use Types::Standard qw(StrMatch);
use Test::More;

=pod

=head1 NAME

ch-2 - Odd Letters frequency checker

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

The script implements Task 2 (Odd Letters) from The Weekly Challenge #332.
It provides L</odd_letters> that accepts an ASCII alphabetic string and
returns a boolean indicating whether every distinct letter occurs an odd
number of times.

=cut

my $AlphaWord    = StrMatch [qr/\A[a-zA-Z]+\z/];
my $string_check = compile($AlphaWord);

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub odd_letters ($word) {
    ($word) = $string_check->($word);
    my %tally;
    $tally{$_}++ for split //, lc $word;
    my $all_odd = all { $_ % 2 == 1 } values %tally;
    return $all_odd ? 1 : 0;
}
## use critic

# Unit tests (Examples provided by the challenge)
ok !odd_letters('weekly'),    'Example 1';
ok odd_letters('perl'),       'Example 2';
ok !odd_letters('challenge'), 'Example 3';

done_testing();
