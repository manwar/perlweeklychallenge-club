#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 277 Task 1: Count Common
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub count_common_1( $words1, $words2 ) {
    my ( %frequencies_1, %frequencies_2 );
    ++$frequencies_1{$_}
        for $words1->@*;
    ++$frequencies_2{$_}
        for $words2->@*;
    return scalar grep
        $frequencies_1{$_} == 1 && ( $frequencies_2{$_} // 0 ) == 1,
        keys %frequencies_1;
}

use Statistics::Frequency;

sub count_common_2( $words1, $words2 ) {
    my %frequencies_1 = Statistics::Frequency->new( $words1 )->frequencies;
    my %frequencies_2 = Statistics::Frequency->new( $words2 )->frequencies;
    return scalar grep
        $frequencies_1{$_} == 1 && ( $frequencies_2{$_} // 0 ) == 1,
        keys %frequencies_1;
}

use List::MoreUtils qw( singleton );
use Set::Scalar;

sub count_common_3( $words1, $words2 ) {
    return Set::Scalar->new( singleton $words1->@* )
        ->intersection( Set::Scalar->new( singleton $words2->@* ) )
        ->size;
}

sub count_common_4( $words1, $words2 ) {
    my $singletons_1 = Set::Scalar->new( singleton $words1->@* );
    my $singletons_2 = Set::Scalar->new( singleton $words2->@* );
    return $singletons_1->intersection( $singletons_2 )->size;
}

use Test2::V0 qw( -no_srand );

my $sub_name = "count_common";
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "Testing $sub:";

    no strict 'refs';
    is $sub->( ["Perl", "is", "my", "friend"], ["Perl", "and", "Raku", "are", "friend"] ), 2,
        'Example 1: count_common( ["Perl", "is", "my", "friend"], ["Perl", "and", "Raku", "are", "friend"] ) == 2';
    is $sub->( ["Perl", "and", "Python", "are", "very", "similar"], ["Python", "is", "top", "in", "guest", "languages"] ), 1,
        'Example 2: count_common( ["Perl", "and", "Python", "are", "very", "similar"], ["Python", "is", "top", "in", "guest", "languages"] ) == 1';
    is $sub->( ["Perl", "is", "imperative", "Lisp", "is", "functional"], ["Crystal", "is", "similar", "to", "Ruby"] ), 0,
        'Example 3: count_common( ["Perl", "is", "imperative", "Lisp", "is", "functional"], ["Crystal", "is", "similar", "to", "Ruby"] ) == 0';
}
done_testing;
