#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 280 Task 2: Count Asterisks
#
#       Perl solution by Matthias Muth.
#

use v5.36;

# My 'single regex' version.
# Use a list assignment to an empty list in scalar context
# to get the number of elements returned by the regex match operator.
# (see here:
# https://stackoverflow.com/questions/2225460/how-do-i-find-the-number-of-values-in-a-perl-list).
sub count_asterisks_single_regex( $str ) {
    return scalar( () = $str =~ /\G(?:\|[^|]*\||[^*])*+\*/g );
}

sub count_asterisks_single_regex_x( $str ) {
    return scalar( () = $str =~ / \G (?: \| [^|]* \| | [^*] )*+ \* /xg );
}

sub count_asterisks_verbose( $str ) {
    my $bar         = qr( \| )x;
    my $no_bar      = qr( [^|] )x;
    my $bar_pair    = qr( $bar ${no_bar}* $bar )x;
    my $wanted      = qr( \* )x;
    my $not_wanted  = qr( [^*] )x;
    my $skip        = qr( (?: ${bar_pair} | ${not_wanted} )*+ )x;
    my $next_wanted = qr( ${skip} ${wanted} )x;

    # while ( $str =~ /\G $next_wanted /xg ) {
    #     say "match '$&'";
    # }
    return scalar( () = $str =~ /\G $next_wanted /xg );
}

# My 'two regexes' version.
sub count_asterisks_two_regexes( $str ) {
    return scalar( () = ( $str =~ s/ \| [^|]* \| //xgr ) =~ / \* /xg );
}

# My favorite (and shortest) solution, which looks quite readable.
# Remove pairs of '|' using the 'r' flag of s/// to return what is left,
# then let an identity 'tr' count the asterisks.
# Using redundant parentheses to show the order of execution.
sub count_asterisks( $str ) {
    return ( $str =~ s/ \| [^|]* \| //xgr ) =~ tr/*/*/;
}


use Test2::V0 qw( -no_srand );

my $sub_name = "count_asterisks";
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "Testing $sub:";

    no strict 'refs';
    is $sub->( "p|*e*rl|w**e|*ekly|" ), 2,
        'Example 1: count_asterisks( "p|*e*rl|w**e|*ekly|" ) == 2';
    is $sub->( "perl" ), 0,
        'Example 2: count_asterisks( "perl" ) == 0';
    is $sub->( "th|ewe|e**|k|l***ych|alleng|e" ), 5,
        'Example 3: count_asterisks( "th|ewe|e**|k|l***ych|alleng|e" ) == 5';
}
done_testing;
