#!/usr/bin/perl
use 5.038;
use warnings;
use Time::Piece;

my $str = shift;
$str =~ s/st|nd|rd|th//;

say Time::Piece->strptime($str, '%d %b %Y')->ymd;