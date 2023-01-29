#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 184 Task 2 Split Array
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given list of strings containing 0-9 and a-z separated by space only.
# Write a script to split the data into two arrays, one for integers and one
# for alphabets only.
# Example 1 Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
#          Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]
# Example 2 Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
#          Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]
#=============================================================================

use v5.36;

use constant NUMBER => 0;
use constant LETTER => 1;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Use this module to show output of nested array references.
# Doesn't exactly match the spec because it quotes numbers
# and has no white space.
use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

my $numLet = splitArray(@ARGV);
say Dumper($numLet->[NUMBER]), ' and ', Dumper($numLet->[LETTER]);

# Input is an array of strings.
sub splitArray(@array)
{
    # Split each string into an array of digits and letters.
    # Use _splitList to turn each string in the array into a pair of lists.
    # The result is an array of pairs, where each pair contains two
    # array references, [NUMBER] for numbers and [LETTER] for letters.
    my @nlListPair = map { _splitList( split(' ', $_) ) } @array;

    # This array will be our result.
    my @numberLetter = ( [], [] );

    for my $p ( @nlListPair )
    {
        # Notice that Example 2 implies that an empty list should be removed
        # from the output. [1,2] has no letters and [p q r] has no numbers,
        # but there are no corresponding empty lists in the output.
        for my $type ( NUMBER, LETTER )
        {
            my $list = $p->[$type];
            push @{$numberLetter[$type]}, $list if scalar(@$list);
        }
    }
    return \@numberLetter;
}

# Given a list of digits and letters, partition the list into
# an array of numbers and an array of letters.  Returns a reference
# to a pair of arrays where the first element is a list of numbers
# and the second element is a list of letters.
# Example: ('a', 1, 'x', 3) ==> [ [1,3], ['a','x'] ]
sub _splitList(@list)
{
    my @numberLetter = ( [], [] );

    for ( @list )
    {
        my $which = (m/\d/ ? NUMBER : LETTER);
        push @{$numberLetter[$which]}, $_;
    }

    return \@numberLetter;
}

sub runTest
{
    use Test2::V0;

    is( _splitList( qw(a 1 2 b 0) ), [[1,2,0], ['a','b'    ]], 'Split a 1 2 b 0');
    is( _splitList( qw(3 c 4 d  ) ), [[3,4  ], ['c','d'    ]], 'Split 3 c 4 d');
    is( _splitList( qw(1 2      ) ), [[1,2  ], [           ]], 'Split 1 2');
    is( _splitList( qw(p q r    ) ), [[     ], ['p','q','r']], 'Split p q r');
    is( _splitList( qw(s 3      ) ), [[3    ], ['s'        ]], 'Split s 3');
    is( _splitList( qw(4 5 t    ) ), [[4,5  ], ['t'        ]], 'Split 3 c 4 d');

    is( splitArray( 'a 1 2 b 0', '3 c 4 d' ),
                    [ [[1,2,0], [3,4]], [['a','b'], ['c','d']] ], 'Example 1');
    is( splitArray( '1 2', 'p q r', 's 3', '4 5 t' ),
                    [ [[1,2], [3], [4,5]], [['p','q','r'], ['s'], ['t']] ], 'Example 2');

    is( splitArray( '1 2', '3 4', '5 6' ),
                    [ [[1,2], [3,4], [5,6]], [] ], 'No letters');
    is( splitArray( 'a b', 'c d' ),
                    [ [] , [['a','b'], ['c','d']] ], 'No numbers');

    done_testing;
}

