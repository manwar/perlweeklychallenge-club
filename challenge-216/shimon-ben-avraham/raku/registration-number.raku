#! /usr/bin/env raku

# Perl Weekly Challenge #216, Challenge 1
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Thu 11 May 2023 07:36:57 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;

=begin pod
=TITLE 
=head1 Task 1: Registration Number

=SUBTITLE 

=head2 Submitted by: Mohammad S Anwar

You are given a list of words and a random registration number.

Write a script to find all the words in the given list 
that has every letter in the given registration number.

=head3 Example 1

    Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
    Output: ('abcd')

The only word that matches every alphabets 
in the given registration number is 'abcd'.

=head3 Example 2

    Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
    Output: ('job', 'bjorg')

=head3 Example 3

    Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
    Output: ('crack', 'rac')                                        

=SOLUTION
=end pod

multi MAIN (Str $reg, *@words) {
    my Str @result;
=begin pod
We're going to use the C<comb> method to determine if any of the input words
fulfill the requirements.  

First, remove all the non-alphabetics from the registration number.
=end pod
    my Junction $reg-letters = $reg.subst(/<-alpha>/, :g)
=begin pod
We don't care about the case of the letters.
=end pod
        .lc
=begin pod

Now create an array of the letters remaing in the registration number.

=end pod
        .comb
=begin pod
Create an C<any> junction from the letters.

=end pod
        .any;
=begin pod

In example 3, above, C<$reg-letters> will be 
=begin code :lang<raku>
any("a", "r", "c")
=end code
Now, collect the words that match the registration in the C<@result> array.
=end pod
    @result.push($_) if 
=begin pod
We don't care about the case of the words being tested.
=end pod
        .lc
=begin pod
Here's the heart of the algorithm.  C<comb> the word with the previously
made C<Junction>.  This will create a C<Junction> of I<n> C<Seq>uences, where
I<n> is the number of letters in the registration number.  
=end pod
        .comb($reg-letters)
=begin pod

When we C<comb> the words in the third example, we will get these C<Junction>s:
=begin code :lang<raku>
# for "crack"
any(("c", "c").Seq, ("r",).Seq, ("a",).Seq)

# for "road"
any(().Seq, ("r",).Seq, ("a",).Seq)

# for "rac"
any(("c",).Seq, ("r",).Seq, ("a",).Seq)

=end code

The word "road" does not meet the challenge's requirements, because it lacks
the letter 'c'. This is reflected in the empty C<Seq>uence: 

=begin code :lang<raku>
().Seq
=end code

The other two examples pass the requirements, and so do not include an empty
C<Seq>uence in their C<any Junction>s.  =end pod

so to find the good words, match the C<Junction> against an empty list; those
that B<don't> match are the good ones.

=end pod
    !~~ () 
=begin pod

Finally, make sure we test every word in the C<@words> array...
=end pod
        for @words;
=begin pod
...and print the results!
=end pod

    say @result.map({"'$_'"}).join(', ').map({ ($_) } );
} # end of multi MAIN (Str $reg, *@words)

#| Run with the option '--test' to test the program
multi MAIN (Bool :$test!) {
    use Test::Output;
    
    output-is {samewith('AB1 2CD', <abc abcd abd>)}, "('abcd')\n", 'Example 1 OK';
    output-is {samewith('007 JB', <job james bjorg>)}, "('job', 'bjorg')\n", 'Example 2 OK';
    output-is {samewith('C7 RA2', <crack road rac>)}, "('crack', 'rac')\n", 'Example 3 OK';
}

