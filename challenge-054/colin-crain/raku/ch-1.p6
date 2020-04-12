use v6.d;

#
#       kth-me-kate.raku
#
#         TASK #1
#         kth Permutation Sequence
#             Write a script to accept two integers n (>=1) and k (>=1). It
#             should print the kth permutation of n integers. For more
#             information, please follow the wiki page.
#
#                 https://en.wikipedia.org/wiki/Permutation#k-permutations_of_n
#
#             For example, n=3 and k=4, the possible permutation sequences are
#             listed below:
#
#                 123
#                 132
#                 213
#                 231
#                 312
#                 321
#             The script should print the 4th permutation sequence 231.
#
#         notes on the question: So what exactly are we looking for here?
#
#             Despite the wiki link given, which sends us to the subheading
#             "#k-permutations_of_n", we do not appear to be looking to
#             calculate here what is known as nPk, or the k-permutations of n,
#             and so we will neither quantify, enumerate nor ruminate on any
#             possible ordered groupings of k items selected from a set of n
#             elements. That's a really interesting puzzle in its own right, but
#             that does not jibe with the rest of the challenge description. We
#             can only infer that the specific subheading portion of the link
#             given is what as known as a red herring, or false lead, or perhaps
#             wild goose chase.
#
#             The rest of the page is informative reading, though, and holds
#             clues as to the intent of the challenge. The first is a
#             permutation is an expression of a particular rearrangement, or
#             remapping, of a sequence; the verb rather than the noun.
#
#             Thus the actual items being permuted are irrelevant, and as such
#             when speaking of permutations it is common to use an ascending
#             sequence of natural numbers, 1 2 3 4 5... as tokens representing
#             the elements to be rearranged. So n here is the number of
#             elements, which is what we expect, and the ordered start set will
#             be of the form
#
#                 ( 1  2  3  ...  n-2  n-1  n)
#
#             The task seems to ask us to establish a list of all permutations
#             of this ordered set and then locate and output the kth member of
#             that list. The problem arises when one takes into account there is
#             no one single way to sequence the order of possible permutations
#             of a starting set. There are commonly accepted ways to label
#             premutations with unique identifiers for later reference, but no
#             one way to enumerate them. Mathematically it is the relationships
#             between individual permutations that are interesting, rather than
#             their positional information in a list.
#
#             The list of n=3 in the task outline is sorted ascending as though
#             the individual permutations were strings; "1 2 3" is followed by
#             "1 3 2". This is known as lexicographic order, and is what we will
#             assume is requested.
#
#             The description also notably starts the list of permutaions with
#             the identity permutation, the mapping of each element to its
#             original place. So we need to make sure we start counting from
#             there, rather than the first alteration. Remember, to choose to do
#             nothing is still a choice.
#
#
#         method: In the Perl 5 version of this challenge, I took a little
#             excursion into routines for constructing permutations, eschewing
#             modules like Algorithm::Permute for the task and perfering to roll
#             my own routines, finally landing on an implimentation of Knuth's
#             Algorithm L.
#
#             In the Raku language, the operation of permutation is built in for
#             positional types, albeit not exactly well defined in the
#             documentation as to how it's executed. However calling
#
#                     @array.permutations
#
#             to construct a list of lists of purmutations is trivially
#             straightforward. A close examination of the lists produced appears
#             to show the algorithm used produces lexicographically sorted
#             permutations. Dumping these lists into an array and indexing on
#             the $sequence_requested variable ( -1, to allow for 0-indexing )
#             produces the result.
#
#             Because the algorithm used is not specified, it seemed reasonable
#             to double check the ordering against a known lexicographically
#             sorted algorithm, Knuth's Algorithm L. This is implimented in
#
#                     apply-algorithm-L ( @set )
#
#             below. Cross-referencing results for various inputs suggests there
#             is no variance in the outputs of the twon functions.
#
#             One glaring difference dows arise, though, and that is time of
#             execution for larger permutation lists. By the time we get to
#             n=10, the built in permutaions method takes about 10 seconds to
#             produce a result. Examination shows that we are producing the
#             entire permutaion set for the given list before selecting the
#             permutation requested, and changing this behavior is not well
#             documented. As it turns out, after some digging I was able to
#             determine the output of .permutaions is a Seq, and can be coerced
#             by the .lazy method. Applying this wrapper transfers to the Array
#             assignment, so we are only evaluating the sequences we need and
#             the execution time is reduced proportionally.
#
#             It's worth noting that for large values of n and k, the built in
#             routine, with or without lazy evaluation, so easily outstrips the
#             raku implimentation of Algorithm L for speed I can't see any
#             optimizing to close that gap.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN ( $number_elements, $sequence_requested where {$sequence_requested > 0}) {

## built in routine
    my @array = 1..$number_elements;
    my @perm = @array.permutations.lazy;

    ## the challenge is indexing from 1, the first sequence is the identity permutation
    say "using permutations routine:" ;
    say @perm[$sequence_requested-1].join(' ');

## algorithm L
    my @result = permute_in_place( $number_elements, $sequence_requested );
    say "using Algorithm L";
    say @result.join(' ');

}

sub permute_in_place ( $number_elements, $sequence_requested is copy) {
    my @set = 1 .. $number_elements;

    ## the challenge is indexing from 1, the first sequence is the identity permutation
    ## if requested == 1, range is 0..0 (one less) which goes to -1 and the algorithm is not executed
    apply-algorithm-L( @set ) while --$sequence_requested;

    return @set;
}

sub apply-algorithm-L ( @set ) {
## in place algorithm (from Knuth Algorithm L, The Art of Computer Programming)
#      «before we start we assume a sorted sequence a[0] <= a[1] <= ... <= a[n]»
# L1.  «Visit»  Take the given arrangement
# L2.  «Find j»  Find the largest index j such that a[j] < a[j + 1]. If no such index
#         exists, terminate the algorithm and we are done
# L3.  «Increase a[j]»  Find the largest index k greater than j such that a[j] < a[k],
# L3a.    then swap the values of a[j] and a[k].
# L4.  «Reverse a[j+1]..a[n]»  Reverse the subsequence starting at a[j + 1] through the end of the permutation,
#         a[n]. Do nothing if j+1 >= n. Return to L1.

    ## L1
    # @set is the standing iteration to be modified

    ## L2
    my @indexes = (^@set.end).grep( { @set[$_] < @set[$_+1] } );
    my $j = @indexes.tail;
    return if ! defined $j;

    ## L3
    @indexes    = (^@set.end+1).grep( { $_ > $j and @set[$_] > @set[$j] } );
    my $k = @indexes.tail;

    ## L3a
    (@set[$j], @set[$k]) = (@set[$k], @set[$j]);

    ## L4
    return unless $j+1 < @set.end;
    @set[$j+1..@set.end] = @set[$j+1..@set.end].reverse;
    return;
}
