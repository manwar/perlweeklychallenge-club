#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

# test with:
# cat *anysudokufile* | perl ch-2.pl

use strict; use warnings;
use v5.32; # syntax for a < x < b

use Class::Struct;
use List::MoreUtils qw(indexes firstidx uniq);

struct RowCandi => [ rowNum => '$', candidates=> '%',
                     NARow => '@', NACol => '@', NAArea => '@',
                     slots => '@', curValues => '@' ];

our $d = 0;
++$|;

sub readInputFromStdin () {
    # identify only [_1-9]
    my @input = ();
    while (<STDIN>) {
        my @line = grep { /[_1-9]/ } split /\b/;

        if ( scalar @line == 9 ) {
            push @input, [ @line ];
        }
        else {
            warn "something I didn't understand line: $.: $_; -> ignored.";
        }
        last if scalar @input == 9;
    }
    @input
}

sub newRowCandi ($$) {
    my ($sketch, $rn) = @_;

    if ($d) {
        say "[$rn] base sketch:";
        say ("[@$_]") for @$sketch;
    }

    my @row = @{$$sketch[$rn]}; # copy
    my @row_range_for_area;
    for ( int($rn / 3) ) {
        @row_range_for_area = 3*$_ .. 3*(1+$_) -1
    }

    # generate unavailable numbers
    my $na_row  = [ uniq @row ];
    my $na_col  = [ map { my $c = $_;
                          [ uniq map { $$sketch[$_][$c] } 0 .. 8 ]
                      } 0 .. 8 ];
    my $na_area = [
                   map {
                       [ uniq
                         map { my $c = $_;
                               map { $$sketch[$_][$c] } @row_range_for_area
                       } 3*$_ .. (3*(1+$_) -1) ]
                    }  0..2  ];         # contains only 3 sections
                                        # where the row is laid on

    my $slots = [ indexes { $_ eq '_' } @row ];
    my $rc = RowCandi->new( rowNum => $rn, candidates => {},
                            NARow => $na_row, NACol => $na_col,
                            NAArea => $na_area,
                            slots => $slots, curValues => [] );
    fillSlots($rc);
    $rc
}

sub fillSlots ($) {
    if ($d) { say "In fillSlots() ..." }
    my $rc = shift;
    my $rn = $rc->rowNum;
    my %avail_nums = map { $_ => 1 } ( 1..9 );
    for (@{$rc->NARow}) { delete $avail_nums{$_} }
    my %avail_nums_bak = %avail_nums;

    # find empty slots at rightmost
    # (where slots[idx] exists but curValue[idx] doesn't)
    for ( my $si = scalar @{$rc->curValues};
          $si < scalar @{$rc->slots};
        %avail_nums = %avail_nums_bak ) {
        my $cn  = $rc->slots->[$si];    # column number;
        my $an  = int( $cn / 3 );       # area number (0 .. 2)
        if ($d) {
            say "[$rn;$cn] idx in slot: $si; col: $cn; area: $an";
            say "      given: @{[keys %avail_nums]}";
            say "      used: @{$rc->curValues}";
            say "      nar: @{$rc->NARow}; nac: @{$rc->NACol->[$cn]};";
            say "      naa: @{$rc->NAArea->[$an]}";

        }

        # remove more NA numbers
        delete $avail_nums{$_} for ( @{$rc->NACol->[$cn]},
                                     @{$rc->NAArea->[$an]},
                                     @{$rc->curValues} );

        if ($d) {
            say "      -> available: ". join( ", ", keys %avail_nums );
        }

        if ( %avail_nums ) {
            my $avn = (keys %avail_nums)[0];
            if ($d) { say "[$rn;$cn] try $avn ->" }
            push @{$rc->curValues}, $avn;       # take one of the available
            delete $avail_nums{$avn};           # reduce available nums.
            $rc->candidates->{$cn} =            # update candiates infos.
              [keys %avail_nums] if (scalar %avail_nums);
            if ($d) {
                say "[$rn;$cn] values in slots: @{$rc->curValues}";
                if ( defined $rc->candidates
                     and defined $rc->candidates->{$cn} ) {
                    say "      and candidates at $cn: @{$rc->candidates->{$cn}}";
                } else  {
                    say "      but no candidate at $cn";
                }
            }
            ++$si;
        }
        else {
            # try next candiates in the current row
            if ( not scalar %{$rc->candidates} ) {
                return undef;                   # no more candidates
                                                # at any columns in the row
            }
            if ($d) { say "[$rn;$cn] no available numbers: try next candidate" }
            for my $colnum ( try_next_candidate_( $rc ) ) {
                return undef unless defined $colnum;
                $si = 1 + firstidx { $_ == $colnum } @{$rc->slots};
                %avail_nums = %avail_nums_bak; # revert available numbers

            }
        }
    }
    !!'succeed'
}

sub try_next_candidate_ ($) {
    my $rc = shift;
    return undef unless scalar %{$rc->candidates};

    my $rn = $rc->rowNum;
    my $cn = (sort keys %{$rc->candidates})[-1];
    my $si = firstidx { $_ == $cn } @{$rc->slots};

    my $candis = $rc->candidates->{$cn};

    if ($d) {
        say "[$rn;$cn] trying anohter candiate($$candis[0]) at column: $cn";
    }
    splice @{$rc->curValues}, ($si), (scalar @{$rc->slots}),
      shift @{$candis}; # set candiate at cn and remove any after col num.
    if (scalar @{$candis} == 0) {
        delete $rc->candidates->{$cn};
    }
    if ($d) {
        say "      after choosing values in slots: @{$rc->curValues}";
        say "      and candidates at $cn: @{$rc->candidates->{$cn}}"
          if defined $rc->candidates
          and defined $rc->candidates->{$cn};
    }

    $cn
}

sub tryNextCandidate ($) {
    my $rc = shift;
    if ( try_next_candidate_( $rc ) ) {
        return fillSlots($rc)
    }
    undef
}

sub isAllFilledRow ($) {
    my $rc = shift;
    scalar @{$rc->slots} == scalar @{$rc->curValues};
}
sub getRefRowSnapshot ($$) {
    my ( $sketch, $rc ) = @_;
    my @vals = @{$rc->curValues};
    push @vals, ("?") x ((scalar @{$rc->slots}) - @vals);

    my $row = [ @{$sketch->[$rc->rowNum]} ]; # copy
    @$row[ @{$rc->slots} ] = @vals;
    return $row;
}

sub getRefWholeSnapshot ($$) {
    my ( $sketch, $rcs ) = @_;
    [ map {
        my $row = [ @$sketch[$_] ]; # copy
        my $rc  = $$rcs[$_];
        if ( defined $rc ) {
            my @vals = @{$rc->curValues};
            push @vals, ("?") x ((scalar @{$rc->slots}) - @vals);
            @$row[ @{$rc->slots} ] = @vals;
        }
        $row
    } (0..$#{$sketch}) ]
}

=pod Example

my @P = ( [ qw[_ _ _ 2 6 _ 7 _ 1] ],
          [ qw[6 8 _ _ 7 _ _ 9 _] ],
          [ qw[1 9 _ _ _ 4 5 _ _] ],
          [ qw[8 2 _ 1 _ _ _ 4 _] ],
          [ qw[_ _ 4 6 _ 2 9 _ _] ],
          [ qw[_ 5 _ _ _ 3 _ 2 8] ],
          [ qw[_ _ 9 3 _ _ _ 7 4] ],
          [ qw[_ 4 _ _ 5 _ _ 3 6] ],
          [ qw[7 _ 3 _ 1 8 _ _ _] ] );

=cut

my @P = readInputFromStdin();

my $ri;
my @rowCandidates = ();
my @canvas = map { [ @$_ ] } @P; # copy
say STDERR "Input:";
say STDERR ("[@$_]") for @canvas;

for ( $ri = 0; 0 <= $ri < 9; ) {
    # $r will be increase or decreased
    my $good = 1;
    if ( defined $rowCandidates[$ri] ) {        # we get here when solving
                                                # lower case ($r+1) was
                                                # not successful
        tryNextCandidate( $rowCandidates[$ri] )
          or $good = 0;
    }
    else {
        $rowCandidates[$ri] = newRowCandi( \@canvas, $ri );
    }

    if ( $good and
         isAllFilledRow( $rowCandidates[$ri] ) ) {
         my $snp = getRefRowSnapshot( \@P, $rowCandidates[$ri] );
        if ($d) {
            say "[$ri] current snapshot: @$snp";
        }
                                                # all good so far
        @canvas[$ri++] = $snp;                  # paint and go next row
    }
    else {
        if ($d) {
            say "[$ri] no more useful candidates";
        }
        $rowCandidates[$ri] = undef;          # no more useuful candiates
        if (defined $rowCandidates[$ri-1]) {      # go previous row
            if ($d) {
                say "[$ri] going to previous row";
            }
            --$ri;
            $canvas[$ri] = $P[$ri];
            next;
        }
    }
}

if ($ri < 9) {
    say "Failed!!!";
    exit 1;
}

say STDERR "\nOutput:";
say("[@$_]") for @canvas;
