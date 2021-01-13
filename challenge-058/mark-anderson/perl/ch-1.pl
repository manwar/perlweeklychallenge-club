#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
use feature qw(signatures);
no warnings qw(experimental);

# Leading zeroes are ignored.

foreach ( 
    #example tests
    "0.1   < 1.1    -1",
    "2.0   > 1.2     1",
    "1.2   < 1.2_5  -1",
    "1.2.1 > 1.2_1   1",
    "1.2.1 = 1.2.1   0",

    #more tests
    "1.2.1   < 1.11.1  -1",
    "1.2_2   < 1.2_11  -1",
    "001.2_3 = 1.2_03   0",
    "1.0     < 10      -1"
) {
      my ($str1, $sign, $str2, $result) = split /\s+/;

      ok compare($str1, $str2) == $result, 
              sprintf "%8s %s %-8s %2s\n", $str1, $sign, $str2, $result; 
}

done_testing;

sub compare($str1, $str2) {
    my @elems1 = $str1 =~ /\d+|[._]/g;
    my @elems2 = $str2 =~ /\d+|[._]/g;

    my $result;

    while (@elems1 and @elems2) {
        $result = compare_elems(shift @elems1, shift @elems2);
        last unless $result == 0;
    }

    if ($result == 0) {
        if (@elems1 > @elems2) { $result =  1 }
        if (@elems1 < @elems2) { $result = -1 }
    }

    $result;
}

sub compare_elems($e1, $e2) {
    given ($e1) {
        when (/\d+/) {
              $e1 =~ s/\A0+(\d+)\z/$1/;
              $e2 =~ s/\A0+(\d+)\z/$1/;
              $e1 <=> $e2
        }

        when (".")  {
            given ($e2) {
                when (".") {  0 }
                when ("_") {  1 }
            }
        }

        when ("_")  { 
            given ($e2) {
                when (".") { -1 }
                when ("_") {  0 }
            }
        }
    }
}
