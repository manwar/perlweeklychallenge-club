#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use Getopt::Long qw(:config no_ignore_case);
use Pod::Usage;


BEGIN {
    $::debugging   = 0;
    $::maximum = 5;

    my $help = 0;

    GetOptions( 'debug'         => \$::debugging,
                "help"          => \$help,
                'max=i'         => \$::maximum,
        ) or pod2usage(2);

    pod2usage( -exitval => 0, -verbose => 2 ) if $help;

    our $dprint = sub( @ ) {
        ++$|;
        print STDERR "[DBG] ",@_;
    };

    *::dprint = $::debugging ? $dprint : sub {};
}

=pod

=head1 2-bit Gray Code Sequence

ch-2.pl [--debug] [--help] [--max=N] [N]

    new-max: if you want increase the maximum value
    N: where  2 <= N <= 5

=cut

our $seq_two = [ 0, 1, 3, 2 ];
our @seq_all = ( $seq_two );

sub makeNextSequenceOf ( $ ) { # basic method : not used here
    my $prev = shift;  # ref !!!
    my $len = scalar @{$prev};
    if ( $len % 2 ) {
        warn 'invalid sequence given: return Nil';
        return undef;
    }
    my $n = 1;
    while ( $len * 0.5 != 1 ) {
        ++$n;
        $len = 0.5 * $len;
    }

    my ( @left, @right );
    for ( @$prev ) {
        push @left, $_;  unshift @right, ( $_ + 2**$n );
    }
    return [ @left, @right ];
}

sub getRef_NBitGrayCodeSeq ( $ ) {

=pod

=head1 Challenge

You are given an integer 2 <= $N <= 5.

Write a script to generate $N-bit gray code sequence.

=cut

    my $N = shift;
    if ( not defined $N or int($N) ne $N
         or not ( 2 <= $N and $N <= $::maximum ) ) {
        # but 5 is too short, I think.
        die "N is not a number or out of range ( 2 <= N <= $::maximum )";
}

=pod

To generate the 3-bit Gray code sequence from the 2-bit Gray code sequence, follow the step below:

 2-bit Gray Code sequence
 [0, 1, 3, 2]
 
 Binary form of the sequence
 a) S1 = [00, 01, 11, 10]
 
 Reverse of S1
 b) S2 = [10, 11, 01, 00]
 
 Prefix all entries of S1 with '0'
 c) S1 = [000, 001, 011, 010]
 
 Prefix all entries of S2 with '1'
 d) S2 = [110, 111, 101, 100]
 
 Concatenate S1 and S2 gives 3-bit Gray Code sequence
 e) [000, 001, 011, 010, 110, 111, 101, 100]
 
 3-bit Gray Code sequence
 [0, 1, 3, 2, 6, 7, 5, 4]

=head1 Example:

Input: $N = 4

Output: [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]

=cut

=pod

=head1 My Solution

if we are looking at the 4th sequence and 2nd sequence we found some similarity
when we devide 4th sequence into 4 parts it looks like below

 [ 0, 1, 3, 2 ] [ 6, 7, 5, 4 ] [ 12, 13, 15, 14 ] [ 10, 11, 9, 8 ]

and when we number the each part by ascending order it would be

 [ 0, 1, 3, 2 ] [ 6, 7, 5, 4 ] [ 12, 13, 15, 14 ] [ 10, 11, 9, 8 ]
 ~~~~~  0 ~~~~~  ~~~~~ 1 ~~~~~ ~~~~~~~~~ 3 ~~~~~~ ~~~~~~ 2 ~~~~~~~

this is exactly same as 2nd sequence's number, and we already know what is the
minimum number and maximum number of each sequence, we can calculate based on
the 2nd sequence,

Generally speaking, in this case,
I found that we could skip one step to find out N'th step if we know (N-2)'th sequence.

and every 8 digits must be in order like

 [ 0, 1, 3, 2 ] [ 2, 3, 1, 0 ] [ 0, 1, 3, 2 ] [ 2, 3, 1, 0 ]

which means that if we know the order of each group (in which 4 number is) we can
sort them in that order.

=cut

    return $seq_all[0] if $N == 2;

    my ( $base, $depth, $is_odd );
    if ( $N == 3 ) {
        return makeNextSequenceOf( $seq_two );
    }
    else {
        $base = $N - 4;
        for ( $depth = 0; not defined $seq_all[$base - $depth]; ++$depth ){ 1 }

        $is_odd = $depth %2;
    }
    ::dprint "base = $base;  depth = $depth\n";

    # make bases if needed
    for ( my $i = 0; $i <= $depth; $i += 2 ) {
        ::dprint "\$i+2 = ".($i+2). " from \$i = $i\n";
        my $offset = $base - $depth + $i;
        $seq_all[$offset+2] = get_sequence_by_using_base( $seq_all[$offset],0 );
    }
    $is_odd and
      $seq_all[$base+2] = get_sequence_by_using_base( $seq_all[$base+1], 1 );

    return $seq_all[$N-2];
}

sub get_sequence_by_using_base ( $$ ) {
    my $base_seq = shift;
    my $first_half_only = shift;
    my $last_idx = $#{$base_seq};
    $last_idx *= 0.5 if $first_half_only;

    my @ret;

    my $odd_filp = 1; # initial: odd
    for my $q ( 0.. $last_idx ) {
        my $pt = 4* $$base_seq[$q];
        my @real_value;
        if ( $odd_filp ) {  # 0      1      3      2
            @real_value = ( $pt, $pt+1, $pt+3, $pt+2 );
        } else {            #   2      3     1    0
            @real_value = ( $pt+2, $pt+3, $pt+1, $pt );
        }
        push @ret, @real_value;
        $odd_filp ^= 1;
    }
    return \@ret;
}

package main;

my $N = shift;
my $n_seq = getRef_NBitGrayCodeSeq( $N );

die unless scalar @$n_seq;

print STDERR "Input: \$N = $N\n";
print STDERR  "Output: ";
$" = ', ';
print "[@{$n_seq} ]\n";
