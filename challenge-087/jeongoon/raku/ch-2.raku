#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# tested with:
# echo "[000100][111000][001001][111110][111110]" | raku ch-2.raku
# -> example #1
# echo "[100][010][000]" | raku ch-2.raku
# -> 0
# echo "[10110][11110][01110][01110][10110]" | raku ch-2.raku
#[1 0 ▨ ▨ 0]
#[1 1 ▨ ▨ 0]
#[0 1 ▨ ▨ 0]
#[0 1 ▨ ▨ 0]
#[1 0 ▨ ▨ 0]


use v6.d;

sub USAGE {
    say "Usage:";
    say '    echo -e "[000100][111000][001001][111110][111110]" | raku ch-2.raku',"\n";
    say "# or input ending with EOF (Ctrl-D or Ctrl-Z)";
    say "# you might need to filter the STDERR to get only answer.";
}

unit sub MAIN;

$*ERR.say("Input: (Ctrl-D or Ctrl-Z to finish to input.)");
my @lines = $*IN.split(/"]" \s* "\n"* | "\n"/); # split rows by newline or `]'

my @matrix =
@lines.elems < 1                                # need one row at least
?? (
     <1 0 1 0 1 0>,
     <0 1 0 1 0 1>,
     <0 0 1 0 0 1>,
     <1 1 1 1 1 0>,
     <1 1 1 1 1 0>, )  # example #1

!! @lines.
map( -> $ln { next if $ln eq "";                # skip empty line
              S:g/ '[' || \s+ //.comb.cache     # remove unused chars.
                 with $ln } );

# confirm input
$*ERR.say(.Array) for @matrix;
$*ERR.say;

@matrix andthen .kv.map(
    -> $ri, $rw {
        # find all lines which has consecutive element of "1"
        ## a. find cells has value of 1
        $rw.pairs.grep( { .value eq 1 }, :k ).Slip.
        ## b. make combinations from 1 to elems
        combinations( 1..* ).                   # one column is *maybe* okay
                                                # except when the column have
                                                # one row (-> point)
        ## c. grep only consecutive points
        map( -> $cmb {
                   $cmb.rotor( 2 => -1 ).
                   map({ [-] .reverse }).       # distance between two points
                   all == 1                     # are all equal to one.
        ## d. as ( points array , row index )
                   ?? ( $cmb, $ri )
                   !! Empty } ).Array.Slip

    } ).


classify( {.[0].Str}, :as{ .[1] } ).            # group by same point or line
map( { my ($pts-str, $rows) = $_.kv;
       my $pts = $pts-str.split(/\s+/)>>.Int.Array;     # note: >>.Int required
       next if $pts.elems == 1 == $rows.elems;  # skip if point

       my $found = False;
       ($rows.elems ... 1).                     # try from largest area
       map( { last if $found;
              $rows.rotor( $_ => -($_.pred) ).  # check rows are consecutive
              map( -> $sub-rows
                   { last if $found;
                     if $sub-rows.rotor( 2 => -1 ).
                     map( { [-] .reverse } ).all == 1 {
                         $found = True;
                         ($pts.clone, $sub-rows.clone).Slip
                     }
                   } ).cache } ).Slip } )

==> my @candidates;

my $largest = @candidates < 1
?? @candidates[0]
!! @candidates.reduce( ( -> \α, \β {            # reduce by find max size
                               ([*] α>>.elems)  # *if* shape of α
                               >                #       is larger than
                               ([*] β>>.elems)  #      shape of β
                               ?? α !! β } ) ); # leave α only

$largest

==> my @solution;                               # print the largest rectangle

if @solution[0].defined.not {                   # XXX: this is a bit tricky
    say "0 as no rectangle found."
}
else {
    for @matrix.kv -> $r, $row {
        $row.kv.
        map( -> $c, $cv {
                   $r ∉ @solution[1]
                   ?? $cv
                   !! ( $c ∉ @solution[0]
                        ?? "$cv" !! '▨' )} ).Array.say;
    }
}
