#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge Week 183 Task 1 Unique Array
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# You are given list of arrayrefs.
# Write a script to remove the duplicate arrayrefs from the given list.
# 
# Example 1
# Input: @list = ([1,2], [3,4], [5,6], [1,2])
# Output: ([1,2], [3,4], [5,6])
# 
# Example 2
# Input: @list = ([9,1], [3,7], [2,5], [2,5])
# Output: ([9, 1], [3,7], [2,5])
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub hashArray($arr)
{
    # Assuming $arr is an array of scalars
    # ASCII Record Separator code 30 (\036, 0x1e)
    return join("\036", $arr->@*);
}

# To avoid a O(n^2) pairwise comparison, reduce each array
# to a hash and keep a lookup table of hashes we've seen.
sub uniqArray($arr)
{
    my @result;
    return [] if ! scalar($arr->@*);

    my %hash;
    for my $ref ( $arr->@* )
    {
        push @result, $ref unless $hash{hashArray($ref)}++;
    }
    return \@result;
}

sub runTest
{
    use Test::More;

    my @TestCase = (
        { input => [ ],
          output => [ ],
          desc => "Empty",
        },
        { input => [ [1,2] ],
          output => [ [1,2] ],
          desc => "Singleton",
        },
        { input => [ [1,2], [3,4] ],
          output => [ [1,2], [3,4] ],
          desc => "Two unique",
        },
        { input => [ [1,2], [1,2] ],
          output => [ [1,2] ],
          desc => "One duplicate"
        },
        { input => [ [1,2], [1,2], [1,2], [1,2] ],
          output => [ [1,2] ],
          desc => "Multiple duplicate",
        },
        { input => [ [3,4], [1,2], [1,2] ],
          output => [ [3,4], [1,2] ],
          desc => "Dup pair at end",
        },
        { input => [ [1,2], [3,4], [5,6], [1,2] ],
          output => [ [1,2], [3,4], [5,6] ],
          desc => "Dup at end"
        },
        { input => [ [9,1], [3,7], [2,5], [3,7] ],
          output => [ [9, 1], [3,7], [2,5] ],
          desc => "Dup in middle"
        },
        { input => [ [9,1], [3,7], [2,5], [2,5], [3,7], [9,1] ],
          output => [ [9, 1], [3,7], [2,5] ],
          desc => "All dups"
        },
        { input => [ ["a","b"], ["c","d"] ],
          output => [ ["a","b"], ["c","d"] ],
          desc => "Strings"
        } 
    );

    while ( my ($no, $tc) = each(@TestCase) )
    {
        is_deeply( uniqArray($tc->{input}), $tc->{output}, $tc->{desc} );
    }

    done_testing();
}
