#! /usr/bin/env raku

# Perl Weekly Challenge 217-2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:07:42 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;

sub max-number (@list where .all ~~ UInt) {
   my UInt $retval = 0; 

   return $retval
} # end of sub max-number (UInt @list)

multi MAIN (:$test! ) {
    use Test;

    my @tests = [
        %{ input => (1, 23),          output => 231,    text => 'Example 1' },
        %{ input => (10, 3, 2),       output => 3210,   text => 'Example 2' },
        %{ input => (31, 2, 4, 10),   output => 431210, text => 'Example 3' },
        %{ input => (5, 11, 4, 1, 2), output => 542111, text => 'Example 4' },
        %{ input => (1, 10),          output => 110,    text => 'Example 5' },
    ];

    for @tests {
        is max-number( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN ( )


