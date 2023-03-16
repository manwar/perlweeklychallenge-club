#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 208 Task 1 Minimum Index Sum 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two arrays of strings.
# Write a script to find out all common strings in the given two arrays with
# minimum index sum. If no common strings found returns an empty list.
# Example 1 Input: @list1 = ("Perl", "Raku", "Love")
#                  @list2 = ("Raku", "Perl", "Hate")
#          Output: ("Perl", "Raku")
#   There are two common strings "Perl" and "Raku".
#   Index sum of "Perl": 0 + 1 = 1
#   Index sum of "Raku": 1 + 0 = 1
# Example 2 Input: @list1 = ("A", "B", "C")
#                  @list2 = ("D", "E", "F")
#          Output: ()
#   No common string found, so no result.
# Example 3 Input: @list1 = ("A", "B", "C")
#                  @list2 = ("C", "A", "B")
#          Output: ("A")
#   There are three common strings "A", "B" and "C".
#   Index sum of "A": 0 + 1 = 1
#   Index sum of "B": 1 + 2 = 3
#   Index sum of "C": 2 + 0 = 2
#=============================================================================

use v5.36;

use List::Util qw/min/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

#########
# Command line 
#########
use feature 'try'; no warnings "experimental::try";
my @list1 = ();
my @list2 = ();
try
{
    @list1 = defined $ARGV[0] && split(/[ ,]/, $ARGV[0]);
    @list2 = defined $ARGV[1] && split(/[ ,]/, $ARGV[1]);
}
catch ($e) {
    say "Caught: ", $e;
}

say "LIST1: [@list1]\nLIST2: [@list2]" if $Verbose;

say "(", join(",", map { qq("$_") } minIndexSum(\@list1, \@list2)->@*), ")";

# Convert a list to an index lookup hash.  Example:
#   [ a, b ]  becomes  { a => 0, b => 1 }
sub asHash($list)
{
    my %h;
    # If there are duplicate values in the list, we want to
    # retain only the first, lesser, index.
    while ( my ($i, $val) = each @$list )
    {
        $h{$val} = $i unless exists $h{$val};
    }
    return \%h;
}

sub minIndexSum($list1, $list2)
{
    my ($h1, $h2) = ( asHash($list1), asHash($list2) );

    my %indexSum = map { $_ => ( $h1->{$_} + $h2->{$_} ) }
                            grep { exists $h2->{$_} } keys %$h1;

    my $min = min(values %indexSum);

    return [ sort grep { $indexSum{$_} == $min } keys %indexSum ];
}

sub runTest
{
    use Test2::V0;

    is( minIndexSum( [ qw(Perl Raku Love) ], [ qw(Raku Perl Hate) ] ),
            [ qw(Perl Raku) ], "Example 1");

    is( minIndexSum( [ qw(A B C) ], [ qw(D E F) ] ), [], "Example 2");

    is( minIndexSum( [ qw(A B C) ], [ qw(C A B) ] ), [ "A" ], "Example 3");

    is( minIndexSum( [ ], [ qw(A B C) ] ), [], "list 1 empty");
    is( minIndexSum( [ qw(A B C) ], [ ] ), [], "list 2 empty");
    is( minIndexSum( [ ], [ ] ), [], "both lists empty");

    is( minIndexSum( [ qw(A B C) ], [ qw(C B B) ] ), [ "B","C" ], "Non-unique list");

    done_testing;
}

