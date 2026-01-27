#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Encrypted String

=head1 SYNOPSIS

  perl ch-2.pl              # runs the embedded tests
  perl ch-2.pl abc 1        # prints "bcd"

=head1 DESCRIPTION

Encrypt a string using a Caesar-style shift: for each character in the string,
replace it with the N-th character after it in the alphabet (wrapping around).

Only letters are shifted; other characters are left unchanged.

=cut

sub encrypt ( $str, $shift ) {
    my $k = $shift % 26;
    my $out = '';

    for my $ch ( split //, $str ) {
        if ( $ch ge 'a' && $ch le 'z' ) {
            my $o = ord($ch) - ord('a');
            $out .= chr( ord('a') + ( $o + $k ) % 26 );
        }
        elsif ( $ch ge 'A' && $ch le 'Z' ) {
            my $o = ord($ch) - ord('A');
            $out .= chr( ord('A') + ( $o + $k ) % 26 );
        }
        else {
            $out .= $ch;
        }
    }

    return $out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { str => 'abc',   int => 1,  out => 'bcd',  label => 'Example 1' },
        { str => 'xyz',   int => 2,  out => 'zab',  label => 'Example 2' },
        { str => 'abc',   int => 27, out => 'bcd',  label => 'Example 3' },
        { str => 'hello', int => 5,  out => 'mjqqt', label => 'Example 4' },
        { str => 'perl',  int => 26, out => 'perl', label => 'Example 5' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $t (@cases) {
        Test::More::is( encrypt( $t->{str}, $t->{int} ), $t->{out}, $t->{label} );
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str> <int>\n" if @args != 2;
    my ( $str, $int ) = @args;
    die "Expected integer shift\n" if $int !~ /^-?\d+$/;
    say encrypt( $str, 0 + $int );
}

_run_cli(@ARGV);

