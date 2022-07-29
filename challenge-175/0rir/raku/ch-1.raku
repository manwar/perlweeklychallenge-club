#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin comment

Task 1: Last Sunday     Submitted by: Mohammad S Anwar
List the last Sunday of every month in the given year.
=end comment

sub infix:<dif> ( Int $lhs, Int $rhs --> Int) is tighter(&infix:<+>) {
    ( $lhs - $rhs).abs 
}

sub last-dow-in-month( Int $want-dow, Int $year, Int $month --> Date ) {
        my $the-day = Date.new: :year( $year), :month( $month);
        $the-day.=last-date-in-month;
        my $got = $the-day.day-of-week;
        my $return = $got == $want-dow ?? $the-day
                          !! $got > $want-dow
                          ?? $the-day - $got dif $want-dow
                          !! $the-day - 7 + $got dif $want-dow;
}

sub last-dow-in-month4year( Int $want-dow, Int $year --> Array ) {
    my @return = gather for 1..12 -> $m {
        take last-dow-in-month( $want-dow, $year, $m );
    }
}

sub MAIN( Int $day-of-week=7, Int $year=2022) {
    say last-dow-in-month4year( $day-of-week, $year).join( " ");
}

