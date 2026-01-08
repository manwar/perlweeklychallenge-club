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

ch-1.pl - Disarium Numbers

=head1 SYNOPSIS

  perl ch-1.pl

=head1 DESCRIPTION

Generate the first 19 Disarium numbers.

A Disarium number is an integer such that the sum of each digit raised to the
power of its position (1-based) equals the number.

=cut

sub is_disarium ($n) {
    my @d = split //, "$n";
    my $sum = 0;
    for my $i ( 0 .. $#d ) {
        $sum += ( 0 + $d[$i] )**( $i + 1 );
    }
    return $sum == $n ? 1 : 0;
}

sub disarium_numbers ($count) {
    ($count) = compile(Int)->($count);
    die 'Expected count > 0' if $count <= 0;

    my @out;
    my $n = 0;
    while ( @out < $count ) {
        push @out, $n if is_disarium($n);
        ++$n;
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 [count]\n" if @args != 1;
    my $count = 0 + $args[0];
    my $out   = disarium_numbers($count);
    say join ', ', @$out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    # Only the example shown in the spec.
    Test::More::plan( tests => 1 );
    Test::More::ok( is_disarium(518), 'Example: 518 is a Disarium number' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 disarium_numbers($count)

Returns an arrayref of the first C<$count> Disarium numbers.

=cut
