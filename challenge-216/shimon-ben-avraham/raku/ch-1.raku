#! /usr/bin/env raku

# Perl Weekly Challenge #216, Challenge 1
# © 2023 Shimon Bollinger. All rights reserved.
<<<<<<< HEAD
# Last modified: Thu 11 May 2023 06:24:39 PM EDT
=======
# Last modified: Thu 11 May 2023 07:36:57 PM EDT
>>>>>>> 0c0e20987dc5677805c95f8e2471492515be32c3
# Version 0.0.1

# always use the latest version of Raku
use v6.*;


multi MAIN (Str $reg, *@words) {
    my Str @result;
    my Junction $reg-letters = $reg.subst(/<-alpha>/, :g)
        .lc
        .comb
        .any;
    @result.push($_) if 
        .lc
        .comb($reg-letters)
<<<<<<< HEAD
    !~~ () for @words;

    say @result.List;
=======
    !~~ () 
        for @words;

    say @result.map({"'$_'"}).join(', ').map({ ($_) } );
>>>>>>> 0c0e20987dc5677805c95f8e2471492515be32c3
} # end of multi MAIN (Str $reg, *@words)

#| Run with the option '--test' to test the program
multi MAIN (Bool :$test!) {
    use Test::Output;
    
<<<<<<< HEAD
    output-is {samewith('AB1 2CD', <abc abcd abd>)}, "(abcd)\n", 'Example 1 OK';
    output-is {samewith('007 JB', <job james bjorg>)}, "(job bjorg)\n", 'Example 2 OK';
    output-is {samewith('C7 RA2', <crack road rac>)}, "(crack rac)\n", 'Example 3 OK';
=======
    output-is {samewith('AB1 2CD', <abc abcd abd>)}, "('abcd')\n", 'Example 1 OK';
    output-is {samewith('007 JB', <job james bjorg>)}, "('job', 'bjorg')\n", 'Example 2 OK';
    output-is {samewith('C7 RA2', <crack road rac>)}, "('crack', 'rac')\n", 'Example 3 OK';
>>>>>>> 0c0e20987dc5677805c95f8e2471492515be32c3
}

