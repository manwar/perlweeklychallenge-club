#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       unzip.pl
#
#       Split Array
#         Submitted by: Mohammad S Anwar
#         You are given list of strings containing 0-9 and a-z separated by
#         space only.
# 
#         Write a script to split the data into two arrays, one for
#         integers and one for alphabets only.
# 
#         Example 1
#             Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
#             Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]
#             
#         Example 2
#             Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
#             Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]
# 
#
#       method
# 
#         Another cryptic puzzle as to the "Why?", but at least the request
#         seems unambiguous. Given a list of strings we need to tease out
#         two arrays of digit and letter components from each and present
#         each new anonymous array within its own larger array of all
#         number list and all letter lists.
# 
#         Kind of complicated, but ultimately with regular expressions much
#         of that vanishes. The real tricky part, which is also arguably
#         completely unnecessary, is to faithfully reproduce the output of
#         the examples. Because the collected data is stored in arrays of
#         arrays, a nested dereferencing is required, along with the
#         addition of the brackets enclosing the collected array data,
#         interior and exterior. Of particular note is the letters, which
#         are displayed in qingle quotes, but of course should just be
#         stored as array elements, as characters the way they were
#         originally delivered. The single quotes would only be required
#         were we to `eval` the string and receive a proper Perl rvalue. 

#         To pull that off we need to nest a `map` block to enclose every
#         letter before it's further processed with commas and square
#         brackets

# 

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


# my @list = ( 'a 1 2 b 0', '3 c 4 d');
my @list = ( '1 2', 'p q r', 's 3', '4 5 t');

my (@numbers, @letters);

for (@list) {
    /\d/       and push @numbers, [  /(\d)/g         ];
    /[a-zA-Z]/ and push @letters, [  /([a-zA-Z])/g   ];

}

## output is tricky to match the examples. Here are two ways to do it:


say '[' . (join ', ', map { '[' . (join ',', $_->@*) . ']' } @numbers) 
        . '] and ['
        . (join ', ', map { '[' . (join ',', map { "\'$_\'" } $_->@*) . ']' } @letters)
        . ']' ; 


## or maybe, alternately, overriding the double-quote operator for lists

local $" = ',';
say '[' . (join ', ', map { '[' . "$_->@*" . ']' } @numbers) 
        . '] and [' 
        . (join ', ', map { '[' . "@{[ map { q(') . $_ . q(') } $_->@* ]}" . ']' } @letters) 
        . ']' ;

## think I like the first way better
