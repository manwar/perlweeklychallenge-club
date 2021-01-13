#! /opt/local/bin/perl
#
#       wassup.pl
#
#         PWC 57 TASK #2
#         Shortest Unique Prefix
#             Write a script to find the shortest unique prefix for each each
#             word in the given list. The prefixes will not necessarily be of
#             the same length.
#
#             Sample Input
#                 [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
#             Expected Output
#                 [ "alph", "b", "car", "cadm", "cade", "alpi" ]
#
#         method: This is another tree based solution, this time constructing a
#             linked hash of hashes. The structure has a root node, a hash with
#             keys defined by the first letters of the words in the word list.
#             Each of these keys in turn points to another hash, that hash with
#             keys of the second letter set of those following the first; this
#             pattern continues until we have mapped every letter of every word.
#             The value of each node hash is thus held in the key to the link to
#             it rather than within itself. This structure is known as a trie.
#
#             To build the trie we need to first reduce every word to an array
#             of characters, then follow that sequence from node to node. If we
#             arrive at a node without a required character key, we create a new
#             key for that character, with its associated hash. The magic to our
#             solution happens when we keep track of every traversal we make
#             during construction, keeping a count of every time we visit a
#             given key in a {count} key alongside the {link} to the next hash.
#
#             Once we have built the trie, we can revisit it with each word in
#             our list and solve the challenge. We break down the word into an
#             array of letters exactly as we did before; only this time we know
#             that a pathway between letters to construct the word already
#             exists within the trie. Instead we create a shortest unique prefix
#             string (sup) for that word; as we iterate through the letters, at
#             each node we visit we add the letter to the string and check the
#             count. Once that count reaches 1, it indicates the word we are
#             searching through was the only word to make that particular link,
#             and we have found the shortest prefix for it.
#
#             But wait. There's still a problem. What if one word is completely
#             contained within another? If we have the two words "court" and
#             "courtship", the prefix "court" cannot distinguish between the
#             two.
#
#             To resolve this requires some metaknowledge about the data set,
#             and the choices in implimentation a trade-off.
#
#             This problem is in a way similar to that of encoding a string in
#             memory as an array of chars. How do we know we are at the end? We
#             need knowledge beyond just the characters that make up the string:
#             a string terminator, either implicit or explicit.
#
#             Explicitly, we could add some character not present in any word as
#             a terminator. For a list of English words this could be the number
#             0, for example. But this would need to be determined by the data
#             set for final use, which is not defined here. If the "words" given
#             were URLs, for instance, or codes, it would be altogether possible
#             that a given string could contain the 0 digit.
#
#             We could add something unique to our trie, for example the array
#             element '00', which cannot ever result from slicing on nullspace.
#             This is concrete evidence of string termination, but then we are
#             given the choice to either keep it in the prefix for output nor
#             not: if we chose to, we sully the data, and add ambiguity as to
#             whether the character as printed was originally present, if we
#             delete it, we have the same original ambiguity we started with.
#             Each decision for this fix creates ambiguity again, so that solves
#             nothing. The idea that coming to the end of the word array before
#             triggering the last escape clause would set an external "terminator
#             found" flag does hold some merit and might be useful in some
#             situations, however.
#
#             Another approach is to make the terminator implicit: the fact that
#             a string has termininated is evidence itself of a teminator. If we
#             hold external knowledge of the length of a string, we know when we
#             have arrived at the end. To acknowledge this need to add a rule
#             that given ambiguity between "court" associating to either "court"
#             or "courtship", the exact match is always the one. I find this
#             solution more elegant, but it requires the added step in lookup to
#             determine whether such ambiguity exists.
#
#             One approach requires metaknowledge of the data set on creating of
#             the trie, to determine a non-colliding terminator to be added, the
#             other metaknowledge on retrieval (see the "trie" in there?) to
#             determine whether there is any ambiguity to be resolved. I'm going
#             to go here with the latter, with adding the knowledge of the
#             algoritm's limitations to the the broader implimentation and call
#             this challenge complete.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @input = ("alphabet", "book", "carpet", "cadmium", "cadeau", "alpine", "court", "courtship") ;

my $trie = {};

## build the trie structure
for my $word ( @input ) {
    my $node = $trie;                   ## reset to root

    for my $letter ( split //, $word ) {
        ## if a node for the char exists, up the count, if not create it with count 1
        if (exists $node->{$letter} ) {
            $node->{$letter}->{count}++;
        }
        else {
            $node->{$letter} = {  link  => {},
                                  count => 1   } ;
        }
        ## reassign the base node to a reference to the new letter node and repeat
        $node = $node->{$letter}->{link};
    }
}

my %output;

## walk down the trie until count == 1 -- this is the shortest unique prefix
for my $word ( @input ) {
    my $node = $trie;                   ## reset to root
    my $sup;

    for my $letter ( split //, $word ) {
        $sup .= $letter;
        ## if the count drops to 1 this word is the only one to have walked this path,
        last if $node->{$letter}->{count} == 1;
        $node = $node->{$letter}->{link};
    }
    $output{$word} = $sup;
}

## output
printf "%-10s => %-10s \n", $_, $output{$_} for (sort keys %output) ;
