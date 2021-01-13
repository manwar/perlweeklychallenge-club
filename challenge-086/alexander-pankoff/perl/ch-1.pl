#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(any first pairfirst);
use Scalar::Util qw(looks_like_number);

use Getopt::Long qw(:config auto_help);
use Pod::Usage;

use FindBin;
use lib File::Spec->join( $FindBin::RealBin, '..', '..', '..', 'challenge-083', 'alexander-pankoff', 'perl', 'lib' );

use Combinations qw(combinations);

{
    my $NUMBERS;
    my $TARGET;
    GetOptions(
        'numbers=s' => \$NUMBERS,
        "target=i"  => \$TARGET,
      )
      && defined $TARGET
      or pod2usage( -exitval => 1 );

    $NUMBERS = slurp( *STDIN ) if !$NUMBERS;

    my @NUMBERS = split( /,?\s+/, $NUMBERS );

    my $invalid = first( sub { !looks_like_number( $_ ) || $_ <= 0 || int( $_ ) != $_ }, @NUMBERS );
    pod2usage(
        -exitval => 1,
        message  => "unexpected value in input list: $invalid"
    ) if $invalid;

    my @pair = pair_difference( $TARGET, @NUMBERS );
    my $out  = ( @pair ? 1 : 0 );

    print $out;

    if ( $ENV{DEBUG} && @pair ) {
        printf( ' as %d - %d  = %d', ( sort { $b <=> $a } @pair ), $TARGET );
    }

    print "\n";

    exit 0;
}

sub pair_difference ( $target, @numbers ) {

    # reusing `combinations` from ch-083 again to build our pairs.
    # we will calculate the absolute difference between the pair members so
    # that order of the memebers doesn't matter
    my @pairs = combinations( 2, @numbers );

    # find the first pair whose difference is $target
    # this returns the pair in list context or a boolean `found` value in
    # scalar context
    return pairfirst { abs( $a - $b ) == $target } ( map { @$_ } @pairs );
}

sub slurp($fh) {
    local $/ = undef;
    my $out = <$fh>;
    return $out;
}

=pod

=head1 NAME

wk-086 ch-1 - Pair Difference

=head1 SYNOPSIS

ch-1.pl [options]

  This programm will print '1' if there is a pair in `numbers` whose difference is `target`

  Options:
    --numbers    a list of integer numbers (e.g. "10, 8, 12, 15, 5")
    --target     the target value
    --help       print this help text

    If --numbers is omitted input will be read from stdin instead

=cut
