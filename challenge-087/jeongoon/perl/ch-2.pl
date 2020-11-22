#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

# tested with:
# echo "[000111][111111][001001][001111][001111] | sbcl --script ch-2.lsp
# [000111]
# [111111]
# [001001]
# [001111]
# [001111]

# modified from ch-084/ch-2.pl
use strict; use warnings;
use v5.26;

use Class::Struct;

struct PointInMat =>  [ row => '$', col => '$' ];
struct HLineInMat =>  [ row => '$', begin => '$', end => '$' ];
struct RectInMat  =>  [ row_NW => '$', col_NW => '$',
                        row_SE => '$', col_SE => '$' ];
struct RunAndShow =>  [ Run => '$', Show => '$' ];
struct ShowDetails => [ name => '$', attrs => '@' ];

sub rectArea ($) {
    my $rect = shift;

    ($rect->row_SE - $rect->row_NW + 1)
        *
    ($rect->col_SE - $rect->col_NW + 1)
}

sub readContents {
    local $/ = ''; # slurp
    my $contents = <STDIN> // '';
    $contents
}

# return as an ArrayRef of ArrayRef of PointInMat (grouped by row number)
sub getPointsAtEachRows ($) {
    my $raw_string = shift;
    my @lines = split( /\n|]\s*/, $raw_string );

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
        my $prev = shift @$pts_at_the_same_row;
        my @line_so_far = ($prev->col);
        my $row = $prev->row;

        push @$pts_at_the_same_row,
            PointInMat->new( row => $row, # add dummy
                             col => $$pts_at_the_same_row[-1]->col + 2 );
        my @hline;

        for my $curr ( @$pts_at_the_same_row ) {
            if ( $curr->col - $prev->col == 1 ) {
                push @line_so_far, $curr->col
            }
            elsif ( scalar @line_so_far > 0 ) {
                push @hline,
                    HLineInMat->new( row   => $row,
                                     begin => $line_so_far[0],
                                     end   => $line_so_far[-1] );
                @line_so_far = ( $curr->col );
            }
            $prev = $curr;
        }
        # return all possible combinations of sub lines
        # single points are inclusive
        my @sub_hline;
        while (@hline) {
            my $sub_hline = shift @hline;
            push @sub_hline, $sub_hline;                # itself
            my @range = $sub_hline->begin .. $sub_hline->end;
            for my $nsel ( reverse 1 .. $#range ) {     # from larger to smaller
                for my $offset ( 0.. scalar @range - $nsel ) {
                    push @sub_hline,
                      HLineInMat->new( row => $sub_hline->row,
                                       begin => $range[$offset],
                                       end => $range[$offset+$nsel-1] )
                  }
            }
        }
        [ @sub_hline ];
    } @$pts_at_all_rows ]
}

sub showHorizLines ($) {
    @_ = ( $_[0],
           ShowDetails->new( name  => 'horiz line(point inclusive)',
                             attrs => [qw(row begin end)] ),
           1 # flattening? yes
        );
    goto &showSomethingInGroup
}

# take ArrayRef of ArrayRef of HLine
sub findLargestRectanglesFromHorizLines ($) {
    my @hlines_grouped_by_row = @{$_[0]}; # copy
    my @largestRectangles = ();
    my $largestArea = 0;

    # reducing rows: 1,2,3,4 -> 2,3,4 -> 3,4 -> 4
    for ( my $base = 0 ; scalar @hlines_grouped_by_row > 0;
          shift @hlines_grouped_by_row, ++$base ) {
        # initial intersection is same as first row
        my %intersects = map {
            $_->begin."~".$_->end => 1 # "begin~end" as a key
        } @{$hlines_grouped_by_row[0]};

        for my $candi_row (@hlines_grouped_by_row) {
            my %new_inters = ();
            last if scalar %intersects == 0; # no need to go further
            for my $hline (@$candi_row) {
                my $key = $hline->begin."~".$hline->end;

                if ( exists $intersects{$key} ) {
                    $new_inters{$key} = 1;
                    my $rect = RectInMat->new(
                        row_NW => $base,
                        row_SE => $hline->row,
                        col_NW => $hline->begin,
                        col_SE => $hline->end );

                    # check largest
                    my $new_area = rectArea( $rect );
                    if ( $largestArea < $new_area ) {
                        $largestArea = $new_area;
                        @largestRectangles = ( $rect );
                    }
                    elsif ( $largestArea == $new_area ) {
                        push @largestRectangles, $rect;
                    }
                }
                else {
                }
            }
            %intersects = %new_inters;
        }
    }
    [ @largestRectangles ]
}

# return as an ArrayRef of PointInMat
sub showRects ($) {
    @_ = ( $_[0],
           ShowDetails->new( name  => 'rectangles',
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
   RunAndShow->new( Run  => \&findLargestRectanglesFromHorizLines,
                    Show => \&showRects ),
  );

our $debug = 0;
my $ball;

my @progress = map {
    $ball = $_->Run->($ball);
    if ( $debug ) { $_->Show->($ball); }
    $ball
} @solutionComposed;

say "Output: ";
for my $rect (@{$progress[-1]}) {
    say "At (r:".$rect->row_NW.", c:".$rect->col_NW.")";
    say join(" ", (1) x ($rect->col_SE - $rect->col_NW + 1))
      for (0 .. $rect->row_SE - $rect->row_NW);
}
