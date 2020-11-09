#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(any first sum0);
use Scalar::Util qw(looks_like_number);

use Getopt::Long qw(:config auto_help);
use Pod::Usage;

use FindBin;
use lib File::Spec->join( $FindBin::RealBin, '..', '..', '..', 'challenge-083',
    'alexander-pankoff', 'perl', 'lib' );

use Combinations qw(combinations);

{
    my $REALS;
    my $MIN = 1;
    my $MAX = 2;
    GetOptions(
        'reals=s' => \$REALS,
        "min=f"   => \$MIN,
        "max=f"   => \$MAX,
    ) or pod2usage( -exitval => 1 );

    $REALS = slurp(*STDIN) if !$REALS;

    my @REALS = split( /,?\s+/, $REALS );

    my $invalid = first( sub { !looks_like_number($_) || $_ <= 0 }, @REALS );
    pod2usage(
        -exitval => 1,
        message  => "unexpected value in input list: $invalid"
    ) if $invalid;

    say triplet_sum_between( $MIN, $MAX, @REALS ) ? 1 : 0;
}

sub triplet_sum_between ( $min, $max, @xs ) {
    any(
        sub {
            between( $min, $max, sum0(@$_) );
        },
        combinations( 3, @xs )
    );
}

sub between ( $min, $max, $x ) {
    $min < $x && $x < $max;
}

sub slurp($fh) {
    local $/ = undef;
    my $out = <$fh>;
    return $out;
}

=pod

=head1 NAME

wk-085 ch-1 - Triplet Sum

=head1 SYNOPSIS

ch-1.pl [options]

  This program prints 1 if there is a triplet of numbers in the input that sums
  up to a value between min and max, otherwise it prints 0.

  Options:
    --reals      a list of postive real numbers (e.g. "1.2 0.4 0.1 2.5")
    --min        minimum bound (default: 1)
    --max        maximum bound (default: 2)
    --help       print this help text

    If --reals is omitted input will be read from stdin instead

=cut
