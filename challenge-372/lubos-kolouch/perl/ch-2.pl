#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=head1 NAME

ch-2.pl - Largest Substring

=head1 SYNOPSIS

  perl ch-2.pl abcdeba
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Returns the length of the largest substring between two equal characters
excluding the two characters. Return -1 if no such substring exists.

=cut

sub largest_substring ($str) {
    my %first_pos;
    my $max_len = -1;

    my @chars = split //, $str;
    for ( my $i = 0; $i < @chars; $i++ ) {
        my $char = $chars[$i];
        if ( exists $first_pos{$char} ) {
            my $len = $i - $first_pos{$char} - 1;
            $max_len = $len if $len > $max_len;
        }
        else {
            $first_pos{$char} = $i;
        }
    }

    return $max_len;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str    = $args[0];
    my $result = largest_substring($str);
    say $result;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => "aaaaa",    expected => 3 },
        { label => 'Example 2', str => "abcdeba",  expected => 5 },
        { label => 'Example 3', str => "abbc",     expected => 0 },
        { label => 'Example 4', str => "abcaacbc", expected => 4 },
        { label => 'Example 5', str => "laptop",   expected => 2 },
        { label => 'Example 6', str => "abc",      expected => -1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( largest_substring( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);
