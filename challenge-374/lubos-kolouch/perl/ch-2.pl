#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=head1 NAME

ch-2.pl - Largest Same-digits Number

=head1 DESCRIPTION

Given a string of digits, return the largest number with all digits the same.
Find all runs of identical digits, convert to numbers, and return the largest.

=cut

my $STR_CHECK = compile(Str);

sub largest_same_digits ($str) {
    ($str) = $STR_CHECK->($str);
    return '' if $str eq '';

    my @runs;
    my $cur = '';
    for my $ch (split //, $str) {
        if ($cur eq '' || substr($cur, -1) eq $ch) {
            $cur .= $ch;
        } else {
            push @runs, $cur;
            $cur = $ch;
        }
    }
    push @runs, $cur if $cur ne '';

    # Return the run that represents the largest number
    my $best = '';
    for my $run (@runs) {
        # Compare as numbers (handle leading zeros)
        my $run_val = $run + 0;
        my $best_val = $best + 0;
        if ($run_val > $best_val || ($run_val == $best_val && length($run) > length($best))) {
            $best = $run;
        }
    }
    return $best;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0 <string>\n" if @args != 1;
    my $str = $args[0];
    my $out = largest_same_digits($str);
    say qq{Input: \$str = "$str"};
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => '6777133339', expected => '3333' },
        { label => 'Example 2', str => '1200034',    expected => '4' },
        { label => 'Example 3', str => '44221155',   expected => '55' },
        { label => 'Example 4', str => '88888',      expected => '88888' },
        { label => 'Example 5', str => '11122233',   expected => '222' },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        Test::More::is(largest_same_digits($case->{str}), $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
