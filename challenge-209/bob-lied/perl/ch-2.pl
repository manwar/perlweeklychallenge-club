#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 209 Task 2 Merge Account 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of accounts i.e. name with list of email addresses.
# Write a script to merge the accounts where possible. The accounts can only
# be merged if they have at least one email address in common.
# Example 1:
#   Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                        ["B", "b1@b.com"],
#                        ["A", "a3@a.com", "a1@a.com"] ]
#   Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"], ["B", "b1@b.com"] ]
#
# Example 2: Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                                 ["B", "b1@b.com"],
#                                 ["A", "a3@a.com"],
#                                 ["B", "b2@b.com", "b1@b.com"] ]
# Output: [ ["A", "a1@a.com", "a2@a.com"],
#           ["A", "a3@a.com"],
#           ["B", "b1@b.com", "b2@b.com"] ]
# 
#=============================================================================

use v5.36;

use List::Util qw/uniq first/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Merge two lists if they have an element in common.  If they can be
# merged, then the first list will be modified.
sub merge($one, $two)
{
    # For each email in the first list (first element is account name)
    for my $email ( $one->@[1 .. $#{$one}] )
    {
        # If it exists in the second list, then they have something
        # in common and should be merged.
        if ( first { $_ eq $email } $two->@[1 .. $#{$two}] )
        {
            # Make a combined list, but with unique elements
            return [ sort { $a cmp $b } uniq @$one, @$two ];
        }
    }
    return undef;
}

sub mergeAccount($accounts)
{
    my @merged;

    # Collect all the account names, first element in each array
    my @acctName = sort { $a cmp $b } uniq map { $_->[0] } @$accounts;
    for my $n ( @acctName )
    {
        my @list = ( grep { $_->[0] eq $n } @$accounts );
        for ( my $i = 0 ; $i < $#list ; $i++ )
        {
            for ( my $j = 0; $j <= $#list ; $j++ )
            {
                next if $j == $i;
                next unless defined $list[$j];
                if ( my $m = merge($list[$i], $list[$j]) )
                {
                    $list[$i] = $m;
                    $list[$j] = undef;
                    $j = 0; # Rescan
                }
            }
        }
        push @merged, grep { defined $_ } @list;
    }
    return \@merged;
}

sub runTest
{
    use Test2::V0;
    my @accounts = ( ["A", 'a1@a.com', 'a2@a.com'],
                     ["B", 'b1@b.com'],
                     ["A", 'a3@a.com', 'a1@a.com'] );

    is( mergeAccount(\@accounts), 
        [ [ qw(A a1@a.com a2@a.com a3@a.com) ], [ qw(B b1@b.com) ] ],
        , "Example 1");

    @accounts = ( ['A', 'a1@a.com', 'a2@a.com'],
                  ['B', 'b1@b.com'],
                  ['A', 'a3@a.com'],
                  ['B', 'b2@b.com', 'b1@b.com'] );

    is( mergeAccount(\@accounts), 
        [ [ qw(A a1@a.com a2@a.com) ],
          [ qw(A a3@a.com) ],
          [ qw(B b1@b.com b2@b.com) ] ],
        , "Example 2");

    @accounts = ( ['A', 'a1@a.com', 'a2@a.com'],
                  ['B', 'b1@b.com'],
                  ['A', 'a3@a.com'],
                  ['B', 'b2@b.com', 'b1@b.com'],
                  ['A', 'a3@a.com', 'a4@a.com' ],
                  ['A', 'a1@a.com', 'a4@a.com' ],
                  ['B', 'b3@b.com'] );
    my $expected = [ [ qw(A a1@a.com a2@a.com a3@a.com a4@a.com) ],
                     [ qw(B b1@b.com b2@b.com) ],
                     [ qw(B b3@b.com) ] ];

    my $actual = mergeAccount(\@accounts);
    is( $actual, $expected, "Transitive merge all A");

    done_testing;
}
