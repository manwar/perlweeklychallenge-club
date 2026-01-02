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

ch-2.pl - Split String

=head1 SYNOPSIS

  perl ch-2.pl "good morning"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a string, return C<true> if it can be split into two non-empty parts
containing the same number of vowels (a, e, i, o, u), otherwise C<false>.

=cut

my $STR_CHECK = compile(Str);

sub _vowel_count ($s) {
    my $n = 0;
    $n++ while $s =~ /[aeiou]/gi;
    return $n;
}

sub split_string ($str) {
    ($str) = $STR_CHECK->($str);
    return 0 if length($str) < 2;

    my $total = _vowel_count($str);
    return 0 if $total % 2 == 1;

    my $target = int( $total / 2 );
    return 1 if $target == 0;    # any non-empty split works

    my $count = 0;
    my @chars = split //, $str;
    for my $i ( 0 .. $#chars - 1 ) {    # split after i (so both parts non-empty)
        $count++ if $chars[$i] =~ /[aeiou]/i;
        return 1 if $count == $target;
    }
    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str = join ' ', @args;
    my $out = split_string($str) ? 'true' : 'false';
    say "Input:  \$str = \"$str\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'perl',         expected => 0 },
        { label => 'Example 2', str => 'book',         expected => 1 },
        { label => 'Example 3', str => 'good morning', expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( split_string( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 split_string($str)

Returns 1 if the string can be split as required, otherwise 0.

=cut

