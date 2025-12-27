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

ch-2.pl - Backspace Compare

=head1 SYNOPSIS

  perl ch-2.pl "ab#c" "ad#c"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Treats the character C<#> as a backspace and compares the resulting strings.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub _apply_backspaces ($str) {
    my @stack;
    for my $ch ( split //, $str ) {
        if ( $ch eq '#' ) {
            pop @stack if @stack;
        }
        else {
            push @stack, $ch;
        }
    }
    return join '', @stack;
}

sub backspace_compare ($str1, $str2) {
    ( $str1, $str2 ) = $ARGS_CHECK->( $str1, $str2 );
    return _apply_backspaces($str1) eq _apply_backspaces($str2) ? 1 : 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <str1> <str2>\n" if @args != 2;
    my ( $s1, $s2 ) = @args;
    my $out = backspace_compare( $s1, $s2 ) ? 'true' : 'false';
    say qq{Input: \$str1 = "$s1"};
    say qq{       \$str2 = "$s2"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str1 => 'ab#c',  str2 => 'ad#c',  expected => 1 },
        { label => 'Example 2', str1 => 'ab##',  str2 => 'a#b#',  expected => 1 },
        { label => 'Example 3', str1 => 'a#b',   str2 => 'c',     expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = backspace_compare( $case->{str1}, $case->{str2} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 backspace_compare($str1, $str2)

Returns a boolean indicating whether the two strings are equal after applying
backspaces.

=cut
