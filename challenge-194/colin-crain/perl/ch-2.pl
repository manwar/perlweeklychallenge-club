#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       freak.pl
#
#       Frequency Equalizer
#         Submitted by: Mohammad S Anwar
#         You are given a string made of alphabetic characters only, a-z.
# 
#         Write a script to determine whether removing only one
#         character can make the frequency of the remaining
#         characters the same.
# 
#         Example 1:
#             Input: $s = 'abbc'
#             Output: 1 since removing one alphabet 'b' will give us 'abc'
#                     where each alphabet frequency is the same.
# 
#         Example 2:
#             Input: $s = 'xyzyyxz'
#             Output: 1 since removing 'y' will give us 'xzyyxz'.
# 
#         Example 3:
#             Input: $s = 'xzxz'
#             Output: 0 since removing any one alphabet would not give us
#                     string with same frequency alphabet.
# 

#         method:
# 
#             Let's start this analysis with a definition of terms. What,
#             then, is being asked of us? We are looking for a frequency
#             distribution of latters that can be corrected by the removal
#             of one element to make a set with equal distribution.
# 
#             So we need a set of letters all occuring with a count of x,
#             and one letter with a count of y, where y is not equal to x.
# 
#             So two values for frequncies, one of which only has one
#             occurence. 
# 
#               --- 
# 
#             In every case it seems we will need to make a frequency
#             distibution of the letters, counting the occurences of the
#             values. From there there are a number of ways to proceed,
#             depending on the results. Our goal is to equalize the system
#             so that there is only one frequency remaining. 
# 
#             If there are only two frequencies, and if one of those
#             is for a single letter, we're in. Removal of that letter will
#             eliminate the category, which brings the total count to one
#             and a flat distribution. 
# 
#             But wait! There is another possibility. This is when there
#             are only two frequencies and this incidence of one is one
#             more than the other, say two of one value and three of
#             another. In this case removing one of the letters that there
#             are three of will equilise the distribution at the lower
#             value. So we'll need to take that possibilty into account as
#             well. 
# 
#             A third more exotic case is when there is only one category
#             to start, containing more than one member, and that frequency
#             is 1. In this situation the distribution is already equalized
#             among a set of unique elements, and removal of any single
#             letter changes the total count of the category but does not
#             affect the overall frequency — that there is only one of each
#             member within the multiset. There is still only one category:
#             items with a frequency of 1. One might consider this an
#             edge-case variant of the first scheme outlined above. 
# 
#             And that's it.  I suppose, there's a pathological corner-case
#             of the last scenario that should be considered, where there
#             is only one character in the string. There will only be one
#             frequency, and if the single element is removed there will
#             only be one frequency remainiing. This is the same as above,
#             however that frequency will be zero.
# 
#             Which brings us back to our quote for today:
# 
#             “It’s like, how much more black could this be? And the answer
#             is none — none more black.” — Nigel Tufnel
# 
#             I will go out on a limb here and declare a frequency of zero
#             does not satisfy the conditions, leaving out the debate as to
#             whether a frequency of zero is in fact a frequency, or rather
#             an absence. Zip. Nil. Void. None more black.

# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use constant VERBOSE => 1;


sub free_eq ( $str ) {
    {VERBOSE and say "\nstr  : $str";}
    
    ## make frequency bag
    my %freq;
    $freq{ substr $str, $_, 1 }++ for (0..length($str)-1);
    {VERBOSE and say "freq : char { $_ } freq $freq{$_}" for keys %freq;}
    
    ## make bag of occurrences of individual values in frequency bag
    my %f_incidence;
    $f_incidence{ $_ }++ for values %freq;
    {VERBOSE and 
        say "f_incidence: freq { $_ } => $f_incidence{$_} times" 
            for keys %f_incidence;}

    my @counts  = sort {$a<=>$b} keys %f_incidence;
    my @letters = keys %freq;
    
    ## CASE 1: single frequency only
    if (@counts == 1) {
    
        ## all the letters are different
        return 1 if $counts[0] == 1 and @letters > 1;
        
        ## all the letters are the same (but not only one letter)
        return 1 if $counts[0] > 1  and $counts[0] == length( $str );
    }
   
    ## CASE 2: two frequencies
    if (@counts == 2) {

        ## if at least one of the two frequency classes has only one member
        ## it can be removed
        for (@letters) { return 1 if $freq{$_} == 1 }

        ## if one frequency incidence is one greater than the other and has
        ## exactly one more element in it
        return 1 if  $counts[0] + 1           == $counts[1] 
                 and $f_incidence{$counts[1]} == 1; 
    } 
    
    return 0; 
    
}












use Test::More;

is free_eq ( 'abbc'    ),       1,  'ex-1';
is free_eq ( 'xyzyyxz' ),       1,  'ex-2';
is free_eq ( 'xxyyzz' ),        0,  'ex-3';
is free_eq ( 'aaabbbcccdd' ),   0,  'three triples and one two count    - fail';
is free_eq ( 'aabbccdddeee' ),  0,  'three doubles and two three counts - fail';
is free_eq ( 'aabbccddd' ),     1,  'three doubles and one three count  - true';
is free_eq ( 'abcd'    ),       1,  'unique chars';
is free_eq ( 'a'    ),          0,  'only one char';
is free_eq ( 'aaaaaaa'    ),    1,  'many of only one char';
is free_eq ( 'aaaabbbb'    ),   0,  'pair of 4s';


done_testing();
