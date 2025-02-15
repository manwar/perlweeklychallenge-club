#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 308 Task 1: Count Common
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub count_common_counts( $str1, $str2 ) {
    my %word_counts;
    ++$word_counts{$_}
        for $str1->@*, $str2->@*;
    return scalar grep $_ == 2, values %word_counts;
}

use List::Util qw( uniq );
sub count_common_uniq( $str1, $str2 ) {
    my %word_counts;
    ++$word_counts{$_}
        for uniq( $str1->@* ), uniq( $str2->@* );
    return scalar grep $_ == 2, values %word_counts;
}

sub count_common( $str1, $str2 ) {
    my %words_1 = map { $_ => 1 } $str1->@*;
    my %words_2 = map { $_ => 1 } $str2->@*;
    return scalar grep $words_2{$_}, keys %words_1;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

#
#   Flexible testing.
#

my $sub_name = "count_common";
my @tests = (
    [ "Example 1:", [ ["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"] ], 2 ],
    [ "Example 2:", [ ["perl", "raku", "python"], ["python", "java"] ], 1 ],
    [ "Example 3:", [ ["guest", "contribution"], ["fun", "weekly", "challenge"] ], 0 ],
    [ "Extra Example 1:",
	[ ["perl", "weekly", "challenge", "weekly"], ["raku", "weekly", "challenge"] ], 2 ],
);

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $output ) = $_->@*;
        $descr .= " $sub" . pp( $input->@* ) . " == $output"
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
	is $sub->( $input->@* ), $output, $descr;
    }
}

done_testing;
