#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;

=head1 NAME

MakeItBigger - Remove one digit occurrence to maximise the number

=head1 SYNOPSIS

  perl ch-1.pl 15456 5
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a string number and a digit character, remove exactly one occurrence
of the digit to make the resulting number as large as possible.

Strategy: find the first occurrence of the digit where the next digit is
greater than the digit to remove. If no such occurrence exists, remove the
last occurrence.

=cut

sub make_it_bigger {
    my ($number, $digit) = @_;
    die "Expected string number and digit\n" unless defined $number && defined $digit;

    my @chars = split //, $number;
    my $last_idx = -1;

    for my $i (0 .. $#chars) {
        if ($chars[$i] eq $digit) {
            $last_idx = $i;
            if ($i < $#chars && $chars[$i + 1] gt $digit) {
                # Removing this digit lets a bigger digit move up
                splice @chars, $i, 1;
                return join '', @chars;
            }
        }
    }

    # No digit followed by a larger one: remove the last occurrence
    splice @chars, $last_idx, 1 if $last_idx >= 0;
    return join '', @chars;
}

sub _run_cli {
    my (@args) = @_;
    if (!@args) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <number> <digit>\n" if @args != 2;
    my ($number, $digit) = @args;
    my $result = make_it_bigger($number, $digit);
    say "Input:  \$str = \"$number\", \$char = \"$digit\"";
    say "Output: \"$result\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', number => '15456',  digit => '5', expected => '1546' },
        { label => 'Example 2', number => '7332',   digit => '3', expected => '732' },
        { label => 'Example 3', number => '2231',   digit => '2', expected => '231' },
        { label => 'Example 4', number => '543251', digit => '5', expected => '54321' },
        { label => 'Example 5', number => '111',    digit => '1', expected => '11' },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = make_it_bigger($case->{number}, $case->{digit});
        Test::More::is($got, $case->{expected}, "$case->{label}: '$got'");
    }
}

_run_cli(@ARGV);
