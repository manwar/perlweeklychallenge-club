use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 061
=========================

Task #2
-------
*IPv4 Partition*

*Reviewed by: Ryan Thompson*

You are given a string containing only digits *(0..9)*. The string should have
between *4* and *12* digits.

Write a script to print every possible valid *IPv4* address that can be made by
partitioning the input string.

For the purpose of this challenge, a valid *IPv4* address consists of *four
"octets"* i.e. *A*, *B*, *C* and *D*, separated by dots (.).

Each octet must be between *0* and *255*, and must not have any leading zeroes.
(e.g., *0* is OK, but *01* is not.)

*Example*
Input: 25525511135,

Output:

 255.255.11.135
 255.255.111.35

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my constant PARTITION-TABLE =                                #      No. Possible
   [                                                         #        Partitions
       [  [ 1, 1, 1, 1 ], ],                                 #  4 digits:      1
       [  [ 1, 1, 1, 2 ], ],                                 #  5 digits:      4
       [  [ 1, 1, 1, 3 ], [ 1, 1, 2, 2 ]  ],                 #  6 digits:     10
       [  [ 1, 1, 2, 3 ], [ 1, 2, 2, 2 ]  ],                 #  7 digits:     16
       [  [ 1, 1, 3, 3 ], [ 1, 2, 2, 3 ], [ 2, 2, 2, 2 ]  ], #  8 digits:     19
       [  [ 1, 2, 3, 3 ], [ 2, 2, 2, 3 ]  ],                 #  9 digits:     16
       [  [ 1, 3, 3, 3 ], [ 2, 2, 3, 3 ]  ],                 # 10 digits:     10
       [  [ 2, 3, 3, 3 ], ],                                 # 11 digits:      4
       [  [ 3, 3, 3, 3 ], ],                                 # 12 digits:      1
   ];

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    #| a string of 4-12 decimal digits

    Str:D $str where { $str.chars >=  4 &&
                       $str.chars <= 12 &&
                       $str ~~ / ^ <[ 0 .. 9 ]>+ $ / }
)
#===============================================================================
{
    "Challenge 061, Task #2: IPv4 Partition (Raku)\n".put;

    my Array[UInt] @addresses = find-partitions( $str );

    if (my UInt $solns = @addresses.elems) == 0
    {
        "The string \"$str\" cannot be partitioned into a valid IPv4 address"
            .put;
    }
    else
    {
        "The string \"%s\" can be partitioned into %d valid IPv4 address%s:\n"
            .printf: $str, $solns, ($solns == 1 ?? '' !! 'es');

        "  %s\n".printf: .join: '.' for @addresses.sort: { .chars, .Str };
    }
}

#-------------------------------------------------------------------------------
sub find-partitions( Str:D $str --> Array[Array[UInt]] )
#-------------------------------------------------------------------------------
{
    my Array[UInt] @addresses;

    for PARTITION-TABLE[ $str.chars - 4 ].list -> List $partition-template
    {
        # The Raku permutations() routine/method produces duplicates when the
        # list elements are not unique. Here, duplicates are filtered out by
        # assigning the permutations to a hash with keys formed by concatenation
        # of the elements.

        my %partitions;
           %partitions{ .join: '' } = $_ for $partition-template.permutations;

        my @partitions = %partitions.values;

        LOOP: for @partitions -> List $partition
        {
            my UInt @digits = $str.split('', :skip-empty).map: { .UInt };
            my UInt @octets;

            for 0 .. 3 -> UInt $i
            {
                my Str $octet  = '';
                       $octet ~= @digits.shift for 1 .. $partition[ $i ];

                next LOOP if $octet > 255 ||
                            ($octet.chars > 1 && $octet.substr(0, 1) eq '0');

                @octets.push: $octet.UInt;
            }

            @addresses.push: @octets;
        }
    }

    return @addresses;
}

################################################################################
