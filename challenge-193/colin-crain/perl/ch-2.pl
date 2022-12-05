#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       odd-one-out.pl
#
#       Odd String
#         Submitted by: Mohammad S Anwar
#         You are given a list of strings of same length, @s.
# 
#         Write a script to find the odd string in the given list. Use
#         positional value of alphabet starting with 0, i.e. a = 0, b = 1,
#         ... z = 25.
# 
#         Find the difference array for each string as shown in the
#         example. Then pick the odd one out.
# 
#         Example 1:
#             Input: @s = ("adc", "wzy", "abc")
#             Output: "abc"
#     
#             Difference array for "adc" => [ d - a, c - d ]
#                                        => [ 3 - 0, 2 - 3 ]
#                                        => [ 3, -1 ]
#     
#             Difference array for "wzy" => [ z - w, y - z ]
#                                        => [ 25 - 22, 24 - 25 ]
#                                        => [ 3, -1 ]
#     
#             Difference array for "abc" => [ b - a, c - b ]
#                                        => [ 1 - 0, 2 - 1 ]
#                                        => [ 1, 1 ]
#     
#             The difference array for "abc" is the odd one.
#     
#         Example 2:
#             Input: @s = ("aaa", "bob", "ccc", "ddd")
#             Output: "bob"
#     
#             Difference array for "aaa" => [ a - a, a - a ]
#                                        => [ 0 - 0, 0 - 0 ]
#                                        => [ 0, 0 ]
#     
#             Difference array for "bob" => [ o - b, b - o ]
#                                        => [ 14 - 1, 1 - 14 ]
#                                        => [ 13, -13 ]
#     
#             Difference array for "ccc" => [ c - c, c - c ]
#                                        => [ 2 - 2, 2 - 2 ]
#                                        => [ 0, 0 ]
#     
#             Difference array for "ddd" => [ d - d, d - d ]
#                                        => [ 3 - 3, 3 - 3 ]
#                                        => [ 0, 0 ]
#     
#             The difference array for "bob" is the odd one.
# 
# 
#       analysis:
# 
#         There are three distinct parts of this puzzle. In order of
#         appearance, firstly we have an two-part encoding scheme, where we
#         take a string as an array of characters, and then convert the
#         letters to a numeric equivalent using a fixed mapping.
# 
#         In the second phase we take one of these encoded arrays and
#         calculate what is known as a "difference array", where we note
#         the net change between successive elements, using the
#         numeric encoding we came up with previously.
# 
#         Lastly we need a way to compare and categorize these difference
#         arrays corresponding to the input strings and find "the odd one
#         out". Exactly what this last determination means is left without
#         further definition.
# 
#         We will note, though, that being the odd element out is generally
#         in reference to not being part of any group. It's my
#         understanding this definition is based in ancient belief systems.
# 
#         The idea of oddness is very old, going back to Pythagorian mystic
#         mathemeticians, who decided numbers divisible by two were good,
#         and those not were bad. Parity was born. In any collection of
#         items, each element in the set can be paired (good) with another
#         (also good). However with an odd number of elements in the set,
#         one item will be left over (bad). This, then, the unpairable one,
#         would be the odd item. Alone in the world, it is caught driftless,
#         without a moral compass, unable to couple, mate or create more
#         items. 
# 
#         I believe that is the crux of the matter.
# 
#         Also, apparently the Pythogorian mystics were unaware of
#         parthenogenetic mitosis.
# 
#         Before continuing I will mention that most of what I just wrote
#         is highly speculative as to the origins of even numbers being
#         good and odd bad, a topic I have written about before with
#         varying degrees of seriousness. I find the subject very
#         interesting, albeit odd. See what I did there? The English word
#         "odd" comes from the Old Norse *oddi*, which curiously refers a
#         triangular point of land, and from that pointy things, and
#         suddenly in a more general way to the part in excess of a sum.
#         This was extended to "odda-maðr", meaning the third man in the
#         context of casting a tiebreaker vote. This last semantic twist is
#         limited amongst similar Germanic variants to Old Norse, which is
#         interesting. Norse traditions had a lot of practical democracy,
#         relatively speaking, in the management of social balance. So the
#         creation of a unique term supporting these actions is not
#         surprising. I think it stands to reason you will find similar
#         patterns surrounding the concept of oddness evolving
#         spontaneously back with the creation of numbers themselves, as a
#         natural extension of grouping objects. But the time-frame
#         of that origin is lost in prehistory. 
#         
#         Ancient numero-analytical mysticism aside, however, we do have a
#         real, immediate problem in front of us now with vagaries as to
#         the specifics of this concept of displaced oddness. We will need
#         to address that. The numerological rabbit-hole will be there
#         waiting for us later.
# 
#         I think the eseential quality here is not not-evenness but rather
#         the ungrouped aspect. It thus doesn't matter what the makeup is
#         of any larger groupings our candidate is not a part of — these
#         may be of any size greater than one. The only criterium is that
#         within the set of all such objects the one under inspection
#         remains unique. 
# 
#         Another question is what if there is more than one unique
#         element? Yea, well who knows? Seriously, there is no explicit
#         statement  that there can and will be only one. We only have the
#         inference we can gather from the tense of the directive to "pick
#         the odd one out". 

#         In fact, choosing random equal length words as input will be more
#         suited to a task of finding words with equal difference sets than a single
#         odd one out. We will have to assume the input comes structured in
#         a specific way, but we have no idea where these lists come from. 
# 
#         The last part we need to finish the challenge is a method of
#         performing a deep numeric analysis of arrays to test for
#         equality, disallowing any found from further consideration. In
#         short, we need some sort of a unique filter for arrays, only
#         allowing things there are only one of. Limiting the values to
#         integers as we have done will make this a little easier.
# 
#       method:
# 
#         Breaking the task down as we have done will require three
#         routines and some sort of framework to call them. 
# 
#         The initial encoding is pretty straightforward, and
#         possibly could be rolled up inline with the later processing, but
#         for clrity we will keep it separate. This whole process is in
#         danger of becoming compliated enough already without making the
#         code unnecessarily dense. 
# 
#         Likewise the function for creating an array of deltas from a and
#         encoded array.
#         
#         As we're looking for *strings* without matching *difference
#         arrays*, these ideas are linked in a hash table. We can then
#         iterate through these pairs and count the frequencies of the
#         difference arrays by constructing a unique stringified key from
#         the data. This is accomplished by separating the integers with
#         the colon character.  At the same time we'll construct another
#         hash using these keys to point back to their original string
#         antecedents.  
# 
#         "But wait!" You might say. Those stringified keys aren't unique!
#         You'll overwrite the strings! This is a very good point. But the
#         thing is: we don't care. Any overwritten values will never be
#         used anyway as they will refer to non-unique differences. So
#         please settle down. Everything is going to be all right. 
# 
#         A consequence of doing things this way is it becomes
#         straightforward to allow for multiple unique strings, which are
#         returned as an array. 
        
        
        
        
        

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';




my @s = @ARGV;
@s == 0 and @s = ("aaa", "bob", "ccc", "ddd", 'ray');


say for odd_man_out( @s );


sub odd_man_out ( @strings ) {
## a procedural wrapper for find_unique_strings(), setting up the correct input
    my %input_hash;
    $input_hash{$_} = difference_array( encode($_) ) for @strings;
    
    return find_unique_strings( %input_hash );
}

sub find_unique_strings( %string_hash ) {
## given a hash of strings to their difference arrays, 
## finds all strings with a difference map frequency of 1 and returns them
    my %freq;
    my %rev_lookup;     ## %freq keys to original strings
    while ( my ($str, $arr) = each %string_hash ) {
        my $key = join ':', $arr->@*;
        $freq{$key}++;
        $rev_lookup{$key} = $str;
    }
    
    my @singles = grep { $freq{$_} == 1 } keys %freq;
    return map { $rev_lookup{$_} } @singles;
}

sub difference_array ( $aref ) {
## given an array of numeric elements, compute and return the 
## array of differences between successive elements
    my @out;
    push @out, $aref->[$_] - $aref->[$_-1] for 1..$aref->$#*;
    return \@out;
}

sub encode ( $str ) {
## convert a string into an array of digits, mapped to the 
## lowercase alphabet starting at 0.
## a => 0, b => 1, ... z => 25
    return [ map { ord($_)-97 } split '', lc($str) ]
}




