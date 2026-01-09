#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-2.pl - Odd String

=head1 SYNOPSIS

  perl ch-2.pl adc wzy abc
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of same-length strings, compute the difference array for each:

  diff[i] = value(s[i+1]) - value(s[i]) where a=0, ..., z=25

Return the string whose difference array is unique.

=cut

my $ARR_CHECK = compile( ArrayRef [Str] );

sub _sig ($s) {
    my @c = split //, $s;
    my @d;
    for my $i ( 0 .. $#c - 1 ) {
        push @d, ( ord( $c[ $i + 1 ] ) - ord('a') ) - ( ord( $c[$i] ) - ord('a') );
    }
    return join ',', @d;
}

sub odd_string ($strings) {
    ($strings) = $ARR_CHECK->($strings);
    die 'Expected at least 3 strings' if @$strings < 3;

    my %count;
    my @sig = map { _sig($_) } @$strings;
    $count{$_}++ for @sig;

    for my $i ( 0 .. $#$strings ) {
        return $strings->[$i] if $count{ $sig[$i] } == 1;
    }
    die 'No unique string found';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = odd_string( \@args );
    say 'Input:  @s = (' . join( ', ', map { qq{\"$_\"} } @args ) . ')';
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', s => [qw(adc wzy abc)], expected => 'abc' },
        { label => 'Example 2', s => [qw(aaa bob ccc ddd)], expected => 'bob' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( odd_string( $case->{s} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 odd_string($strings)

Returns the string with the unique difference array.

=cut

