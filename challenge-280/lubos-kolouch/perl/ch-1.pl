#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-1.pl - Twice Appearance

=head1 SYNOPSIS

  perl ch-1.pl acbddbca
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a string containing lowercase English letters, return the first letter
that appears twice when scanning left-to-right.

=cut

my $STR_CHECK = compile(Str);

sub twice_appearance ($str) {
    ($str) = $STR_CHECK->($str);
    die 'Expected lowercase English letters only' if $str !~ /\A[a-z]*\z/;

    my %seen;
    for my $ch ( split //, $str ) {
        return $ch if $seen{$ch}++;
    }
    return '';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str>\n" if @args != 1;
    my $str = $args[0];
    my $out = twice_appearance($str);
    say "Input:  \$str = \"$str\"";
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'acbddbca', expected => 'd' },
        { label => 'Example 2', str => 'abccd',    expected => 'c' },
        { label => 'Example 3', str => 'abcdabbb', expected => 'a' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( twice_appearance( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 twice_appearance($str)

Returns the first character whose second occurrence is encountered.

=cut

