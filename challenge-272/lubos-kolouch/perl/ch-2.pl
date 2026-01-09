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

ch-2.pl - String Score

=head1 SYNOPSIS

  perl ch-2.pl hello
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

The score of a string is the sum of the absolute differences between ASCII
values of adjacent characters.

=cut

my $STR_CHECK = compile(Str);

sub string_score ($str) {
    ($str) = $STR_CHECK->($str);
    my @c = split //, $str;
    return 0 if @c <= 1;

    my $score = 0;
    for my $i ( 0 .. $#c - 1 ) {
        $score += abs( ord( $c[$i] ) - ord( $c[ $i + 1 ] ) );
    }
    return $score;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str>\n" if @args != 1;
    my $str = $args[0];
    my $out = string_score($str);
    say "Input:  \$str = \"$str\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'hello', expected => 13 },
        { label => 'Example 2', str => 'perl',  expected => 30 },
        { label => 'Example 3', str => 'raku',  expected => 37 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( string_score( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 string_score($str)

Returns the string score.

=cut

