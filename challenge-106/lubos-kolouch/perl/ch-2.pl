#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Decimal String

=head1 SYNOPSIS

  perl ch-2.pl           # runs the embedded tests
  perl ch-2.pl 5 66      # prints "0.0(75)"

=head1 DESCRIPTION

Convert a fraction N/D into its decimal string representation.
If the fractional part is recurring, enclose the repeating part in
parentheses.

=cut

sub decimal_string ( $num, $den ) {
    die "Denominator must be non-zero\n" if $den == 0;

    my $sign = ( $num < 0 ) ^ ( $den < 0 ) ? '-' : '';
    $num = abs($num);
    $den = abs($den);

    my $int = int( $num / $den );
    my $rem = $num % $den;
    return $sign . $int if $rem == 0;

    my %seen_at;
    my @digits;
    my $pos = 0;

    while ( $rem != 0 && !exists $seen_at{$rem} ) {
        $seen_at{$rem} = $pos++;
        $rem *= 10;
        push @digits, int( $rem / $den );
        $rem %= $den;
    }

    if ( $rem == 0 ) {
        return $sign . $int . '.' . join '', @digits;
    }

    my $start = $seen_at{$rem};
    my $nonrep = join '', @digits[ 0 .. $start - 1 ];
    my $rep    = join '', @digits[ $start .. $#digits ];

    return $sign . $int . '.' . $nonrep . '(' . $rep . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 3 );
    Test::More::is( decimal_string( 1, 3 ),  '0.(3)',  'Example 1' );
    Test::More::is( decimal_string( 1, 2 ),  '0.5',    'Example 2' );
    Test::More::is( decimal_string( 5, 66 ), '0.0(75)', 'Example 3' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <N> <D>\n" if @args != 2;
    say decimal_string( 0 + $args[0], 0 + $args[1] );
}

_run_cli(@ARGV);

