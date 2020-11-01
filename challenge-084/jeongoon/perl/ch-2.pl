#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;

use Class::Struct;

struct PointInMat =>  [ row => '$', col => '$' ];
struct HLineInMat =>  [ row => '$', begin => '$', end => '$' ];
struct SquareInMat => [ row_NW => '$', col_NW => '$',
                        row_SE => '$', col_SE => '$' ];
struct RunAndShow =>  [ Run => '$', Show => '$' ];
struct ShowDetails => [ name => '$', attrs => '@' ];

sub combiIndex2 ($) {
    my $num_ids = $_[0] -1;

    map { my $sel1 = $_;
          map { [ $sel1, $_ ] } ($sel1+1) .. $num_ids  } 0 .. $num_ids -1;
}

sub readContents {
    local $/ = ''; # slurp
    my $contents = <STDIN> // '';
    $contents
}

# return as an ArrayRef of ArrayRef of PointInMat (grouped by row number)
sub getPointsAtEachRows ($) {
    my $raw_string = shift;
    my @lines = split( /]\s*/, $raw_string );

    [ map {
        my ( $r, $c ) = ( $_, 0 );

        [ map {
            if ( $_ eq '1' ) {
                PointInMat->new( row => $r, col => $c++ );
            } elsif ( $_ eq '0' ) {
                ++$c; ()
            } else {
                ()
            }
        } (split "", $lines[$_]) # charaters
        ] # group by row
      } 0 .. $#lines ]; # return as ArrayRef
}

sub showSomethingInGroup ($$$) {
    my ( $listOflist_ref, $spec, $flattening, $nth ) = ( @_[0..2], 1 );
    my @list;
    if ( $flattening // 1 ) {
        @list = map { @$_ } @$listOflist_ref; # flatten
    }
    else {
        @list = @$listOflist_ref;
    }

    my $listLen = scalar @list;
    my $ww  = length $listLen; # (w)ord (w)idth:  for printf()
    say "$listLen  ".($spec->name)."(s) found:";
    for my $sth (@list) {
        printf("%0*d", $ww, $nth++);
        say ": (".join(", ", map { "$_:".($sth->$_()) } @{$spec->attrs} ).")";
    }
    say "";
}

sub showPoints ($) {
    @_ = ( $_[0], # data (ArrayRef)
           ShowDetails->new( name  => 'points',
                             attrs => [qw(row col)] ),
           1 # flattening? yes
         );
    goto &showSomethingInGroup
}

# return as an ArrayRef of ArrayRef of HLineInMat (grouped by row)
sub getHorizLinesFromPoints ($) {
    my $pts_at_all_rows = shift;
    [ map {
        my $pts_at_the_same_row = $_;
        [ map {
            my ($p1, $p2) = @{$pts_at_the_same_row}[ @$_ ];
            HLineInMat->new( row => $p1->row,
                             begin => $p1->col, end => $p2->col )
        } combiIndex2( scalar @$_ ) ]
    } @$pts_at_all_rows ]
}

sub showHorizLines ($) {
    @_ = ( $_[0],
           ShowDetails->new( name  => 'horiz lines',
                             attrs => [qw(row begin end)] ),
           1 # flattening? yes
        );
    goto &showSomethingInGroup
}

# return as an ArrayRef of PointInMat
sub getSquaresFromHlines ($) {
    my @hls_at_all_rows = @{$_[0]}; # copy for sure
    my $row_to_scan = 0;

    [ map { # combinations of two rows
        my ( $hls_r1, $hls_r2 ) = @hls_at_all_rows[ @$_ ];

        # permutation of pairs of horizontal lines
        # which are selected from one each
        map {
            my $hl1 = $$hls_r1[$_];
            map {
                my $hl2 = $$hls_r2[$_];
                if ( $hl1->begin == $hl2->begin ) {
                    my ( $hlen1, $hlen2 )
                      = map { $_->end - $_->begin } ($hl1, $hl2);
                    if ( $hlen1 == $hlen2 # rectangle
                         and
                         $hlen1 == ( $hl2->row - $hl1->row ) ) {
                        # square
                        SquareInMat->new( row_NW => $hl1->row,
                                          col_NW => $hl1->begin,
                                          row_SE => $hl2->row,
                                          col_SE => $hl2->end )
                    }
                    else {
                        ()
                    }
                }
                else {
                    ()
                }
            } 0 .. $#{$hls_r2}
        } 0 .. $#{$hls_r1}
    } combiIndex2( scalar @hls_at_all_rows ) ] # return as ArrayRef
}

sub showSquares ($) {
    @_ = ( $_[0],
           ShowDetails->new( name  => 'square',
                             attrs => [ qw(row_NW col_NW row_SE col_SE) ] ),
           0 # flattening? no
        );
    goto &showSomethingInGroup
}

my @solutionComposed =
  (
    # pairs of function, logger in top -> bottom in the same order of exe.
   RunAndShow->new( Run  => \&readContents, Show => sub { say @_ } ),
   # ==>
   RunAndShow->new( Run  => \&getPointsAtEachRows,
                    Show => \&showPoints ),
   # ==>
   RunAndShow->new( Run  => \&getHorizLinesFromPoints,
                    Show => \&showHorizLines ),
   # ==>
   RunAndShow->new( Run  => \&getSquaresFromHlines,
                    Show => \&showSquares ),
  );

our $debug = 1;
my $ball;

my @progress = map {
    $ball = $_->Run->($ball);
    if ( $debug ) { $_->Show->($ball); }
    $ball;
} @solutionComposed;

say "Output: ".(scalar @{$progress[-1]});
