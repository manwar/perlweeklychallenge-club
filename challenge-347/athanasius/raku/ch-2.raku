use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 347
=========================

TASK #2
-------
*Format Phone Number*

Submitted by: Mohammad Sajid Anwar

You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

  1. Removing all spaces and dashes
  2. Grouping digits into blocks of length 3 from left to right
  3. Handling the final digits (4 or fewer) specially:
     - 2 digits: one block of length 2
     - 3 digits: one block of length 3
     - 4 digits: two blocks of length 2
  4. Joining all blocks with dashes

Example 1

  Input: $phone = "1-23-45-6"
  Output: "123-456"

Example 2

  Input: $phone = "1234"
  Output: "12-34"

Example 3

  Input: $phone = "12 345-6789"
  Output: "123-456-789"

Example 4

  Input: $phone = "123 4567"
  Output: "123-45-67"

Example 5

  Input: $phone = "123 456-78"
  Output: "123-456-78"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A phone number is entered on the command-line as a single string containing
   digits, spaces, and dashes (hyphens) only.

Assumptions
-----------
1. A phone number contains at least 2 digits.
2. Spaces and dashes in a phone number are separators, and so do not occur in
   either initial or final position.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 347, Task #2: Format Phone Number (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string containing digits, spaces, and dashes only

    Str:D $phone where { / ^ \d <[ \d \s - ]>* \d $ / }
)
#===============================================================================
{
    qq[Input:  \$phone = "$phone"].put;

    my Str $formatted-num = format-phone-number( $phone );

    qq[Output: "$formatted-num"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub format-phone-number
(
    Str:D $phone where { / ^ \d <[ \d \s - ]>* \d $ / }
--> Str:D
)
#-------------------------------------------------------------------------------
{
    my $str =  $phone;
       $str ~~ s:g/ \s //;
       $str ~~ s:g/ \- //;

    my Match @matches = m:g/ (. ** 1..3) / given $str;
    my Str   @blocks  = @matches.map: { ~$_ };
    
    if  @blocks[*-1].chars == 1
    {
        my $ult := @blocks[*-1];
        my $pen := @blocks[*-2];

        my Str $c = $pen.substr:    *-1, 1;
                    $pen.substr-rw( *-1, 1 ) = '';
        $ult = $c ~ $ult;
    }

    return @blocks.join: '-';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $phone, $expected) = $line.split: / \| /;

        for     $test-name, $phone, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $formatted-num = format-phone-number( $phone );

        is $formatted-num, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|1-23-45-6  |123-456
        Example 2|1234       |12-34
        Example 3|12 345-6789|123-456-789
        Example 4|123 4567   |123-45-67
        Example 5|123 456-78 |123-456-78
        END
}

################################################################################
