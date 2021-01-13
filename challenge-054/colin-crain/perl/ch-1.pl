#! /opt/local/bin/perl
#
#       kth_me_kate.pl
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
#         method: Now before we continue, let it be known that these days I'm
#             not shooting for the fastest, most sensible nor efficiant
#             methodology to go about solving these challenges. For instance,
#             there exist some quite good modules in CPAN to make permutations
#             simple, painless and fast. Of these I prefer and recommend
#             Algorithm::Permute, it's written in XS and very good, albeit with
#             some odd quirks. I even used it here previously for the wordgame
#             challenge. No, these days I view these excursions as thought
#             experiments and just prefer, if I have time, to explore the
#             problem space and see whats there. Modules are an integral part of
#             the Perl ecosystem but today I'm just going to have at it and roll
#             my own. I have my own idiosyncratic rules for proceeding, and
#             these rules are by no means fixed nor consistent.
#
#             I suppose I'm drawing on an old artist technique in my toolbox, to
#             artificially add constraints to a challenge. Combined with my
#             apparent fascination with parsing the minutiae of the challenge
#             questions, and you get a little slice of my brain. Welcome to my
#             world, we have snacks.
#
#             To obtain the kth lexicographically sorted permutation sequence
#             the first approach was to generate a list of permutations and
#             select the kth element of that list. Seems reasonable. So we use a
#             recursive routine, constructing the patterns from left to right,
#             and at each element iterate through the remaining numbers in the
#             starting pattern in a well ordered way. The resulting list of
#             patterns will come out lexicographically sorted. We can accomplish
#             this by passing a set of remaining numbers, a working permutaion
#             under construction, and a results set to hold the permutaions once
#             finished.
#
#             This is all well and good, and works fine for reletively small
#             values of n, but as-is it needs to construct all of the patterns
#             first and then select the kth member. Furthermore, it will
#             obviously blow up with all that recursion and looping; even though
#             the sets shrink by one element each time we proceed the time will
#             still be n! to finish. We can improve this dramatically for
#             smaller numbers of k by coupling in some reference slots to store
#             the number requested and the the permutation produced, and
#             short-circuiting to collapse the remaining recursion if we have
#             our answer, but this is by no means a universal safeguard. The
#             final routine is quite workable within reason, and is located in
#
#                 permute_recursive( \@set, \@working, $permutations, $data)
#
#             There is of course a better way to do this, which is to rearrange
#             the sequences in place, using an algorithm that only requires
#             the current permutation to generate the next. One such algorithm
#             is Knuth's Algoritm L (Lexicographic permutation generation),
#             which he notes is only describing a method that had been invented
#             some 600 years previous. This is implimented as
#
#                 compute_next_permutation( \@set )
#
#             with a wrapper to apply it the correct number of times.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ( $number_elements, $sequence_requested ) = @ARGV ;

my $result  = permute_with_recursion( $number_elements, $sequence_requested );
say "recursion: the " . $sequence_requested . "th permutation sequence is $result->@*";

my $result2 = permute_in_place( $number_elements, $sequence_requested );
say "in place : the " . $sequence_requested . "th permutation sequence is ", join ' ', $result2->@*;



## ## ## ## ## SUBS:

sub permute_with_recursion {
    my ( $end, $selected_sequence ) = @_;
    my @set          = (1..$end);
    my @working;
    my $permutations = [];
    my $data         = { seq_number => $selected_sequence,
                         result     => undef };

    permute_recursive( \@set, \@working, $permutations, $data);

    return $data->{result};
}

sub permute_recursive {
## given a starting set, a working list and a permutations set
## computes complete permutations as arrays and places the arrays on the permutations array
## which is maintained throughout by reference
    my ($setref, $workref, $permutations, $data) = @_;
    my @set = $setref->@*;

    ## if there is only one element left, push it on the working list,
    ## push that array reference onto the permutations array and return.
    ## This unique permutation list is complete.
    if ( scalar @set == 1 ) {
        my @working = $workref->@*;
        push @working,      $set[0];
        if (scalar $permutations->@* == $data->{seq_number} - 1) {
            $data->{result} = \@working;
        }
        else {
            push $permutations->@*,  \@working;
        }
        return;
    }

    ## iterate through the remaining elements of the set,
    ## creating  new copy of the working list, moving the element
    ## from the set to the working list and recursing with these
    ## new lists. The permutations list reference is passed through unchanged.
    for my $element ( @set ) {

        ## collapse the recursion if we have our result
        last if defined $data->{result};

        my @working = $workref->@*;
        push @working, $element;
        my @subset = grep { $_ != $element } @set;
        permute_recursive( \@subset, \@working, $permutations, $data );
    }
}

sub permute_in_place {
    my ( $end, $selected_sequence ) = @_;
    my @set = (1..$end);

    ## the unrearranged sequence, the identity permutation,
    ## counts as sequence #1 as per the task
    for (1..$selected_sequence-1) {
        compute_next_permutation( \@set );
    }

    return \@set;
}

sub compute_next_permutation {
## in place algorithm (from Knuth Algorithm L, The Art of Computer Programming)
#
#      «before we start we assume a sorted sequence a[0] <= a[1] <= ... <= a[n]»
# L1.  «Visit»  Take the given arrangement
# L2.  «Find j»  Find the largest index j such that a[j] < a[j + 1]. If no such index
#         exists, terminate the algorithm and we are done
# L3.  «Increase a[j]»  Find the largest index k greater than j such that a[j] < a[k],
# L3a.    then swap the values of a[j] and a[k].
# L4.  «Reverse a[j+1]..a[n]»  Reverse the subsequence starting at a[j + 1] through the end of the permutation,
#         a[n]. Do nothing if j+1 >= n. Return to L1.

    ## L1
    my $set = shift;
    my $end = scalar $set->@* - 1;

    ## L2
    my @one = grep { $set->[$_] < $set->[$_+1] } (0..$end-1);
    my $j = $one[-1];
    return if ! defined $j;

    ## L3
    my @two = grep { $_ > $j and $set->[$_] > $set->[$j] } (0..$end);
    my $k = $two[-1];

    ## L3a
    ($set->[$j], $set->[$k]) = ($set->[$k], $set->[$j]);

    ## L4
    return unless ( $j+1 < $end ); # {

    my @reversed = reverse($set->@[ ($j+1)..$end ]);
    splice $set->@*, $j+1, $end-$j, @reversed;
}
