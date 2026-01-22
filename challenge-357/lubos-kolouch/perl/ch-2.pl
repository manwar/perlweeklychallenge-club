#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Unique Fraction Generator

=head1 SYNOPSIS

  perl ch-2.pl        # runs the embedded tests
  perl ch-2.pl 4      # prints the ordered list of fractions

=head1 DESCRIPTION

Given a positive integer N, generate all unique fractions that can be created
using integers 1..N as numerator/denominator.

Fractions are listed in ascending order. If multiple fractions have the same
value (e.g. 1/2 and 2/4), only the reduced form (smallest numerator) is shown.

=cut

sub gcd ( $a, $b ) {
    ( $a, $b ) = ( $b, $a % $b ) while $b != 0;
    return $a;
}

sub unique_fractions ($n) {
    die 'Expected positive integer N' if $n !~ /^\d+$/ || $n < 1;

    my %seen;
    my @pairs;

    for my $num ( 1 .. $n ) {
        for my $den ( 1 .. $n ) {
            my $g = gcd( $num, $den );
            my ( $p, $q ) = ( $num / $g, $den / $g );
            my $key = "$p/$q";
            next if $seen{$key}++;
            push @pairs, [ $p, $q ];
        }
    }

    @pairs = sort { $a->[0] * $b->[1] <=> $b->[0] * $a->[1] } @pairs;
    return [ map { $_->[0] . '/' . $_->[1] } @pairs ];
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            in  => 3,
            out => [qw(1/3 1/2 2/3 1/1 3/2 2/1 3/1)],
            label => 'Example 1',
        },
        {
            in  => 4,
            out => [qw(1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1)],
            label => 'Example 2',
        },
        { in => 1, out => [qw(1/1)], label => 'Example 3' },
        {
            in => 6,
            out => [
                qw(1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1 6/1)
            ],
            label => 'Example 4',
        },
        {
            in => 5,
            out => [
                qw(1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1)
            ],
            label => 'Example 5',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $t (@cases) {
        Test::More::is_deeply( unique_fractions( $t->{in} ), $t->{out}, $t->{label} );
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <N>\n" if @args != 1;
    my $list = unique_fractions( $args[0] );
    say join ', ', @$list;
}

_run_cli(@ARGV);

