#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       get-in-line.pl
#
#       Ordered Letters
#         Submitted by: E. Choroba
# 
#         Given a word, you can sort its letters alphabetically (case
#         insensitive). For example, “beekeeper” becomes “beeeeekpr” and
#         “dictionary” becomes “acdiinorty”.
# 
#         Write a script to find the longest English words that don’t change
#         when their letters are sorted.
# 
#         method:
#             the trick here is not to find an efficient sorting method for the words,
#             comparing pre and post, but rather to find an eficient manner
#             of determining whether a word is already sorted, as any word 
#             requiring any rearangement fails the test. 
#             
#             By starting at the front and comparing adjacent pairs of letters
#             using the `sort` comparison operators, we can avoid sorting the 
#             words entirely. If in any pair the right letter if lexicographically
#             smaller than the left, the word fails and me move to the next word 
#             immediately. 
#
#             The longest alphaliteral word I could find anywhere was "aegilops" at 8
#             letters, being an variant spelling of 'egilops'. The longest in
#             in any dictionary I had was 7 letters.
#             
#             
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( max );

my $dict = '/usr/share/dict/words';

open(my $fh, "<", $dict) or die "can't open dict $dict: $!";

my %bag;

for (<$fh>) {
    s/[\n\r]//g;                    ## general-purpose chomp
    $_ = lc;                        ## lowercase the word (if in ALLCAPS, for instance)
    $bag{$_} = length $_ if is_sorted($_);
}

my $max = max (values %bag);
say "max length $max\n";

my @longest = sort grep { $bag{$_} == $max } keys %bag;

say $_ for @longest;



sub is_sorted ($word) {
    return 0 if length($word) < 3;  ## reject short words
    for (1 .. length($word)-1) {
        return 0 if (substr($word, $_-1, 1) cmp substr($word, $_, 1)) == 1 ;
    }
    return 1;
}


=cut

max length 7

adelops
alloquy
beefily
begorry
billowy
egilops
