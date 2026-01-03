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

ch-2.pl - Replace Digits

=head1 SYNOPSIS

  perl ch-2.pl a1c1e1
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an alphanumeric string, replace each digit with the previous letter
shifted forward by that digit. If multiple digits appear in a row, they all
use the last seen letter.

=cut

my $STR_CHECK = compile(Str);

sub replace_digits ($str) {
    ($str) = $STR_CHECK->($str);

    my $last = undef;
    my $out  = '';

    for my $ch ( split //, $str ) {
        if ( $ch =~ /[A-Za-z]/ ) {
            $last = $ch;
            $out .= $ch;
            next;
        }
        if ( $ch =~ /\d/ ) {
            die 'Digit without preceding letter' if !defined $last;
            my $shifted = chr( ord($last) + $ch );
            $out .= $shifted;
            next;
        }
        die "Unexpected character: $ch";
    }

    return $out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str>\n" if @args != 1;
    my $str = $args[0];
    my $out = replace_digits($str);
    say "Input:  \$str = '$str'";
    say "Output: '$out'";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'a1c1e1',   expected => 'abcdef' },
        { label => 'Example 2', str => 'a1b2c3d4', expected => 'abbdcfdh' },
        { label => 'Example 3', str => 'b2b',      expected => 'bdb' },
        { label => 'Example 4', str => 'a16z',     expected => 'abgz' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( replace_digits( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 replace_digits($str)

Returns the transformed string.

=cut

