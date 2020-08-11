#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use utf8;
use strict; use warnings;
use Getopt::Long qw(:config no_ignore_case gnu_compat);
use Pod::Usage;
use Term::ANSIColor;


BEGIN {
    $::debugging = 0;
    $::utf8      = 1;
    $::colour    = 1;
    $::help      = 0;

    GetOptions( 'debug'  => \$::debugging,
                'utf8!'  => \$::utf8,
                'color|colour!' => \$::colour,
                'N=i'       => \$::N,
                'help'      => \$::help,
              ) or pod2usage(2);

    our $dbuff_ = '';
    our $dprint = sub ( @ ) { ++$|;  print STDERR @_;  };
    our $dpush  = sub ( @ ) {  $dbuff_ .= join "", @_; };

    if ( $::utf8 ) {
        binmode( STDERR, ':utf8' );
        binmode( STDOUT, ':utf8' );
        *IC = sub { '↗' };  *DC = sub { '↘' }; }
    else {
        *IC = sub { '/' };   *DC = sub { '\\' }; }

    *::dpush  = $::debugging ? $dpush : sub {};
    *::dmesg  = $::debugging ?
      sub { $dprint->('[DBG] ',$dbuff_,@_ ); $dbuff_='';} : sub {};

}

=pod

=head1 Peak Element

ch-1.pl [--debug] [--help] [--no-utf8] [--no-color] [N (default: 42)]
where  1 < N <= 50

=head1 Challenge

You are given positive integer $N (>1).

Write a script to create an array of size $N with random unique elements between 1 and 50.

 | I'm going to make a list and shuffle (because the list would be not very long.)
 | then return @array[ 0..$N ]

=cut

sub make_random_array_ ( @ ) { # note: this function does not validate parameters
    my %args = @_;
    my $narray = $args{'number-of-array'};
    my $members =$args{'elements'};

    my $n = scalar @$members;

    for ( 0.. $n*2 ) { # shuffle enough
        my ( $l, $r ) = ( int(rand($n)), int(rand($n)) );
        @{$members}[$l, $r] = @{$members}[$r, $l];
    }
    @{$members}[ 0.. $narray-1 ];
}

=pod

=encoding utf8

In the end it should print peak elements in the array, if found.

  An array element is called peak if it is bigger than it’s neighbour.

 Example 1
  Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
  Peak: [ 48, 45, 21 ]
 Example 2
  Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
  Peak: [ 47, 32, 39, 36 ]

=cut

sub get_peak_from_array ( @ ) {
    my $n     =  0;
    my $l     =  1;
    my $pasc  =  1 << 1; # previous ascend value
    my @ps;

    ::dpush "visual list: ";
    for (@_) {

=pod

=head1 My solution

 | So.. I just simply compare current number to next one. if the number increased
 | previouly and will be decreased, which means current number is peak

=cut

        my $d = ( ( $_[$n+1] || 0 ) - $_[$n++] ); # (d)elta
        $d /= abs $d; # need direction only
        my $asc = (0,1,0)[$d]; # d == 1 -> $asc = 0, $t == -1  -> $asc = 1;
        ::dpush $pasc?IC:DC;

        # I found the bit operation is interesting
        # change comparison method a little bit.
        #   pasc   asc     peak
        #   0      0       no (keep decreasing)
        #   1      0       yes
        #   0      1       no (low peak)
        #   1      1       no (keep increasing)
        # not very usueful here but I hope someday it will be :-]
        if ( ($pasc | $asc) == 0b10 ) {  # if $pasc and not $asc;
            push @ps, $_;
            ::dpush " ", colored( ['yellow on_black'], $_ ), " ";
        }
        else {
            ::dpush " $_ ";
        }
        $pasc = $asc << 1;
    }
    ::dmesg " ", ($pasc?IC:DC), "\n";
    return @ps;
}


package main;

defined $::N or
  $::N = 42, warn "Use Default N: 42";

die "Invalid value of N($::N): must be 1 < N <= 50"
  unless $::N > 1 and $::N <= 50;

pod2usage( -exitval => 0, -verbose => 2 ) if $::help;

my @r_array = make_random_array_( 'number-of-array' => $::N,
                                  'elements' => [ 1..50 ] );
$"=", ";

print "Array: [ @r_array ]\n";
print "Peak:  [ ".join($", get_peak_from_array @r_array)." ]";

exit 0;
