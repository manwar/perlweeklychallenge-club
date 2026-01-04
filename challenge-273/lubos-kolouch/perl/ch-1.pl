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

ch-1.pl - Percentage of Character

=head1 SYNOPSIS

  perl ch-1.pl perl e
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a string and a character, return the percentage (nearest whole number)
of the string that is equal to that character.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub percentage_of_character ($str, $char) {
    ( $str, $char ) = $ARGS_CHECK->( $str, $char );
    die 'Expected a single character' if length($char) != 1;
    die 'Expected non-empty string'   if length($str) == 0;

    my $count = 0;
    $count++ while $str =~ /\Q$char\E/g;
    my $pct = ( $count / length($str) ) * 100;
    return int( $pct + 0.5 );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str> <char>\n" if @args != 2;
    my ( $str, $char ) = @args;
    my $out = percentage_of_character( $str, $char );
    say "Input:  \$str = \"$str\", \$char = \"$char\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'perl',      char => 'e', expected => 25 },
        { label => 'Example 2', str => 'java',      char => 'a', expected => 50 },
        { label => 'Example 3', str => 'python',    char => 'm', expected => 0 },
        { label => 'Example 4', str => 'ada',       char => 'a', expected => 67 },
        { label => 'Example 5', str => 'ballerina', char => 'l', expected => 22 },
        { label => 'Example 6', str => 'analitik',  char => 'k', expected => 13 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            percentage_of_character( $case->{str}, $case->{char} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 percentage_of_character($str, $char)

Returns the percentage rounded to the nearest whole number.

=cut

