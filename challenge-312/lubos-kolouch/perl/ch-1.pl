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

ch-1.pl - Minimum Time

=head1 SYNOPSIS

  perl ch-1.pl abc
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

The typewriter has letters a-z arranged in a circle. Moving the pointer one
step clockwise or anti-clockwise costs 1 second; typing a character costs 1
second. Starting position is 'a'. The script returns the minimum time needed to
type the given string.

=cut

my $STR_CHECK = compile(Str);

sub _pos ($ch) { return ord($ch) - ord('a') }

sub minimum_time ($str) {
    ($str) = $STR_CHECK->($str);
    my $time = 0;
    my $pos  = 0;    # 'a'

    for my $ch ( split //, $str ) {
        my $target = _pos($ch);
        my $diff   = abs( $target - $pos );
        my $move   = $diff < ( 26 - $diff ) ? $diff : ( 26 - $diff );
        $time += $move + 1;    # move + type
        $pos = $target;
    }
    return $time;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;
    my $str = $args[0];
    my $out = minimum_time($str);
    say qq{Input: \$str = "$str"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'abc',  expected => 5 },
        { label => 'Example 2', str => 'bza',  expected => 7 },
        { label => 'Example 3', str => 'zjpc', expected => 34 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( minimum_time( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 minimum_time($str)

Returns the minimum time to type the string on the circular typewriter.

=cut
