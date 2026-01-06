#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-1.pl - Binary String

=head1 SYNOPSIS

  perl ch-1.pl 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an integer n > 0, return all binary strings of length n.

=cut

my $INT_CHECK = compile(Int);

sub binary_strings ($n) {
    ($n) = $INT_CHECK->($n);
    die 'Expected n > 0' if $n <= 0;

    my @out;
    for my $x ( 0 .. ( 2**$n ) - 1 ) {
        push @out, sprintf "%0${n}b", $x;
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <n>\n" if @args != 1;
    my $n   = 0 + $args[0];
    my $out = binary_strings($n);
    say "Input:  \$n = $n";
    say "Output: " . join( ', ', @$out );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', n => 2, expected => [qw(00 11 01 10)] },
        { label => 'Example 2', n => 3, expected => [qw(000 001 010 100 111 110 101 011)] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = [ sort @{ binary_strings( $case->{n} ) } ];
        my $exp = [ sort @{ $case->{expected} } ];
        Test::More::is_deeply( $got, $exp, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 binary_strings($n)

Returns an arrayref of all length-n binary strings.

=cut

