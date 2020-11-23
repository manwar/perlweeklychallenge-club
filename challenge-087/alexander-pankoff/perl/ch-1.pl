#!/usr/bin/env perl
package wk087::ch1;
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(first reduce uniq);
use Scalar::Util qw(looks_like_number);

use Getopt::Long qw(:config auto_help);
use Pod::Usage;

run() unless caller();

sub run() {
    my $NUMBERS;
    GetOptions( 'numbers=s' => \$NUMBERS, )
      or pod2usage( -exitval => 1 );

    $NUMBERS = slurp( *STDIN ) if !$NUMBERS;

    my @NUMBERS = split( /,?\s+/, $NUMBERS );

    my $invalid = first( sub { !looks_like_number( $_ ) || $_ <= 0 || int( $_ ) != $_ }, @NUMBERS );
    pod2usage(
        -exitval => 1,
        message  => "unexpected value in input list: $invalid"
    ) if $invalid;

    my @sequence = longest_consecutive_sequence( @NUMBERS );

    say scalar @sequence ? ( '(' . join( ', ', @sequence ) . ')' ) : 0;

    exit 0;
}

sub longest_consecutive_sequence(@xs) {
    my $res = reduce {
        my $cur = $a->{cur};
        if ( !@{$cur} || $cur->[-1] == $b - 1 ) {
            push @{$cur}, $b;
            $a->{longest} = ( @{$cur} > 1 && @{$cur} > @{ $a->{longest} } ) ? $cur : $a->{longest};
        }
        else {
            $a->{cur} = [];
        }

        return $a;
    }
    { cur => [], longest => [] }, uniq( sort { $a <=> $b } @xs );

    return @{ $res->{longest} };

}

sub slurp($fh) {
    local $/ = undef;
    my $out = <$fh>;
    return $out;
}

=pod

=head1 NAME

wk-087 ch-1 - Longest Consecutive Sequence

=head1 SYNOPSIS

ch-1.pl [options]

  This program fill print the longest consecutive sequence found in numbers.
  If none is found it will print 0 instead.

  Options:
    --numbers    a list of integer numbers (e.g. "10, 8, 12, 15, 5")
    --help       print this help text

    If --numbers is omitted input will be read from stdin instead

=cut
