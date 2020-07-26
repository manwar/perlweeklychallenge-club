#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use Getopt::Long qw(:config no_ignore_case);
use Pod::Usage;

BEGIN {
    $::debugging = 0;

    my $help = 0;

    GetOptions( 'debug' => \$::debugging,
                "help"  => \$help
        ) or pod2usage(2);

    pod2usage( -exitval => 0, -verbose => 2 ) if $help;

    our $dprint = sub( @ ) {
        ++$|;
        print STDERR "[DBG] ",@_;
    };

    *::dprint = $::debugging ? $dprint : sub {};
}

=pod

=head1 Character Swapping

ch-1.pl [--debug] [--help] "String to swap" [Count] [Offset]

=cut

sub charactersSwappedAsExplain ( $$$ ) {

=pod

=head1 Challenge

You are given a string $S of size $N.

=cut

my ( $S, $C, $O ) = @_;
my $N = length $S;

=pod

You are also given swap count $C and offset $O such that
$C >= 1, $O >= 1 and $C + $O <= $N.

=cut

::dprint "in charactersSwappedAsExplain:\n";
die_if_invalid_value( $C, $O, $N );

=pod

 Write a script to perform character swapping like below:

 $S[ 1 % $N ] <=> $S[ (1 + $O) % $N ]
 $S[ 2 % $N ] <=> $S[ (2 + $O) % $N ]
 $S[ 3 % $N ] <=> $S[ (3 + $O) % $N ]
 ...
 ...
 $S[ $C % $N ] <=> $S[ ($C + $O) % $N ]

=cut

for my $c ( 1 .. $C ) {
    my $bak;
    my $bak_r = '';
    $bak_r = substr $S, ( $c + $O ) % $N, 1 if $::debugging;
    $bak = substr $S, $c % $N, 1,
      ( defined $bak_r  ? $bak_r : substr( $S, ( $c + $O ) % $N, 1 ) );
    substr $S, ( $c + $O ) % $N, 1, $bak;
    # or according to https://perldoc.perl.org/functions/substr.html
    #substr( $S, ( $c + $O ) % $N, 1 ) = $bak;

    ::dprint "Character Swapping:\n";
    ::dprint "swap $c: $bak <=> $bak_r = $S\n";
}

=pod

 Input:
     $S = 'perlandraku'
     $C = 3
     $O = 4

 Character Swapping:
     swap 1: e <=> n = pnrlaedraku
     swap 2: r <=> d = pndlaerraku
     swap 3: l <=> r = pndraerlaku

 Output:
     pndraerlaku

=cut

return $S;
}

=pod

=head1 My Solution
 I could simplyfy the process a little bit because I ccould divide the
pattern into 3 groups ( I wrote alphabet `O' as Ou for clearity of meaning. )

=over

=item 1. when C < O, each index numbers are devided into 5 groups

 [ 0 ] [ C+2 .. C+Ou ] [ C+1 .. Ou ] [ 1 .. C ] [ C+Ou+1 .. N-1 ]

=item 2. C == 0

 [ 0 ] [ C+2 .. C+Ou ] [ 1 .. C ] [ C+Ou+1 .. N-1 ]

=item 3. C > 0

 [ 0 ] [ C+2 .. C+Ou ][ C-Ou .. C ] [ 1.. C+Ou+ 1 ] [ C+O+2 .. N-1 ]

=back

 So I realized that part #1, #2 are always has the same rule, and follow things.
( note: K = boolean( C > Ou ) )

=over

=item Part #3

 part #3 can rewritten as if K { [ (C-O) .. C ] } else { [ C+1 .. Ou ] }

=item Part #4

 part #4 can be rewritten as [ 1 .. ( C + ( K *(Ou+1) ) ) ]

=item Part #5

 part #5 can be rewritten as [ ( C+Ou+1+K ) .. N-1 ]

=back

=cut

sub charactersSwapped_DBG ( $$$ ) {
    my ( $S, $C, $O ) = @_;
    my $N = length $S;
    my $K = int( $C > $O );

    ::dprint "in charactersSwapped_DBG:\n";
    die_if_invalid_value( $C, $O, $N );

    my $n;
    my $part = substr $S, 0, 1;                         # P1
    ::dprint "P".++$n.": $part\n";
    my $result = $part;
    $part = substr $S, $C+2, ( $O-1 );                  # P2
    ::dprint "P".++$n.": $part\n";
    $result .= $part;
    $part = ( $K ? substr( $S, $C-$O, $O+1 )
              : substr( $S, $C+1, ( $O-$C ) ) );        # P3
    ::dprint "P".++$n.": $part\n";
    $result .= $part;
    $part = substr( $S, 1, $C + ( $K*($O+1) ) );        # P4
    ::dprint "P".++$n.": $part\n";
    $result .= $part;
    $part =substr( $S, ($C+$O+1+$K), ($N-$C-$O-$K-1) ); # P5
    ::dprint "P".++$n.": $part\n";
    $result .= $part;

    return $result;
}

sub charactersSwapped ( $$$ ) {
    my ( $S, $C, $O ) = @_;
    my $N = length $S;
    my $K = int( $C > $O );

    ::dprint "in charactersSwapped:\n";
    die_if_invalid_value( $C, $O, $N );

    my $result = substr $S, 0, 1;                       # P1
    $result .= substr $S, $C+2, ( $O-1 );               # P2
    $result .= ( $K ? substr( $S, $C-$O, $O+1 )
              : substr( $S, $C+1, ( $O-$C ) ) );        # P3
    $result .= substr( $S, 1, $C + ( $K*($O+1) ) );     # P4
    $result .=substr( $S, ($C+$O+1+$K), ($N-$C-$O-$K-1) ); # P5

    return $result;
}

sub die_if_invalid_value( $$$ ) {
    my ( $C, $O, $N ) = @_;
    unless ( $C >=1 || $O >=1 ) {
        die "[ERR] C(count) and O(Offset) must be equal or more than 1";
    }
    unless ( ( $C + $O ) <= $N ) {
        die "[ERR] \$C($C) + \$O($O) <= \$N($N)";
    }
}

package main;

my $Str = shift // 'perlandraku';
my $Cnt = shift // 3;
my $Off = shift // 4;

my $answer = '';
my $try;
if ( $::debugging ) {
    $answer = charactersSwappedAsExplain( $Str, $Cnt, $Off );
    $try = charactersSwapped_DBG( $Str, $Cnt, $Off );
}
else {
    $try = charactersSwapped( $Str, $Cnt, $Off );
}



print STDERR "Output:\n";
::dprint "Expected Answer: ".$answer.$/;
::dprint "And.. my Answer: ";
print $try.$/;
