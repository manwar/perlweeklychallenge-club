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

ch-2.pl - Reverse Letters

=head1 SYNOPSIS

  perl ch-2.pl "p-er?l"
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Reverses only the alphabetic characters in the string while leaving all other
characters in their original positions.

=cut

my $STR_CHECK = compile(Str);

sub reverse_letters ($str) {
    ($str) = $STR_CHECK->($str);
    my @chars = split //, $str;
    my ( $l, $r ) = ( 0, $#chars );

    while ( $l < $r ) {
        ++$l while $l < $r && $chars[$l] !~ /[A-Za-z]/;
        --$r while $l < $r && $chars[$r] !~ /[A-Za-z]/;
        ( $chars[$l], $chars[$r] ) = ( $chars[$r], $chars[$l] ) if $l < $r;
        ++$l;
        --$r;
    }

    return join '', @chars;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;

    my $str = $args[0];
    my $out = reverse_letters($str);
    say qq{Input: \$str = "$str"};
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'p-er?l',            expected => 'l-re?p' },
        { label => 'Example 2', str => 'wee-k!L-y',         expected => 'yLk-e!e-w' },
        { label => 'Example 3', str => '_c-!h_all-en!g_e',  expected => '_e-!g_nel-la!h_c' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( reverse_letters( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 reverse_letters($str)

Returns the string with only alphabetic characters reversed.

=cut
