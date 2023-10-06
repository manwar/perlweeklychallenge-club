#!/usr/bin/perl
use v5.36;
use DateTime;

my ($year, $month, $wom, $dow) = @ARGV;
my $obj = DateTime->new(year => $year, month => $month, day => 1);
if($obj->dow() <= $dow) {
    $obj->add(days => (($dow - $obj->dow()) + (($wom - 1) * 7)));
} else {
    $obj->add(days => ((7 - ($obj->dow() - $dow)) + (($wom - 1) * 7)));
}
say 0 and exit if $obj->month() != $month;
say $obj->day();
