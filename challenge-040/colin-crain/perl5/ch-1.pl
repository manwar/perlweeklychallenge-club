#! /opt/local/bin/perl
#
#       ch-1.pl
#
#       PWC 40 - TASK #1
#       Show multiple arrays content
#           You are given two or more arrays. Write a script to display values of each list at a given index.
#
#           For example:
#
#               Array 1: [ I L O V E Y O U ]
#               Array 2: [ 2 4 0 3 2 0 1 9 ]
#               Array 3: [ ! ? £ $ % ^ & * ]
#           We expect the following output:
#
#               I 2 !
#               L 4 ?
#               O 0 £
#               V 3 $
#               E 2 %
#               Y 0 ^
#               O 1 &
#               U 9 *
#
#       method: So, the request here is for a Haskell-like,
#           functional-programming-style "list convolution" function,
#           interleaving multiple lists into one aggregate list of lists. This
#           type of function, combining multiple lists into single, aggregate
#           list of tuples by index, is usually called zip. Right out of the
#           gate we need to mention about List::MoreUtils, which has a zip
#           function that does this. Or perhaps not, because we have no
#           intention of using it. Not today, zip, not today. But you should
#           know it's there, along with cousins and variants. On that subject,
#           Haskell, requiring as it does rather explicit definition to offer
#           it's mathematical proof-like certainty in action, has different
#           functions to zip differing numbers of lists, with zip, zip2, zip3
#           all the way to zip7. In perl we can generalize more, and our
#           version will take as many arrays as offered.
#
#           Another question is what to do with differing list lengths, as we can
#           either provide a list of well-defined lists limited to the length of
#           the shortest input, and toss any indexes that can't be completely
#           interleaved, or insert data, even if that data is undef, and fill out
#           the shorter lists to fit the longest. Haskell chooses the former idea,
#           as does perl6. Did we mention Raku? Well it too has a zip function, by
#           the way, like Haskell, built right in. One might even say the ideas
#           are functionally related. See what I did there? Although in Raku one
#           single function can handle any number of input lists to merge; it also
#           has an infix binary Z operator which is pretty nest and can be chained
#           to zip multiple lists. I believe List::MoreUtils::zip takes the latter choice,
#           and will make sure every bit of data in each of the input lists will
#           end up somewhere in the result, null padding the resultant lists with
#           undefs as required.
#
#           There really is no obvious right and wrong in either approach, as
#           one removes data and the the other changes the lengths of shorter
#           lists, which while subtle as it is could easily be construed as
#           corruption. Because any list element can be undefined, a list with
#           additional trailing undefs is not really the same list as one
#           without, is it? Or put another way, the action of interleaving the
#           lists is no longer reversible, as we can no longer distinguish
#           between a short list whose last element is undef and and one that
#           has been extended to create indices to interleave.

#           Then again the same can be said for truncated lists, but in that
#           case the action of truncation is well defined with respect to the
#           data we retain. We can reverse the process, and know for certain
#           that the lists we produce will accurately reflect the data in the
#           originals, even should one of those lists have undef for a trailing
#           element. But we won't know whether there were any lists truncated,
#           or any information about any missing elements. In the end the only
#           way to make the call as to right and wrong is for which behavior is
#           required, or matters. You, perhaps your language and your data can
#           be the only judge.
#
#           The lists to be interleaved will be provided as array references,
#           the output will be a list of lists, or rather a reference to an
#           array of array references.
#
#           I think the well defined version is obviously safer, but have
#           included an undef padded alternate for the brave, the foolish and
#           data horders who just won't ever throw away anything, because you
#           never know. I do that a lot, so I should know.
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


# use warnings;
use strict;
use feature ":5.26";

use Data::Dumper;
## ## ## ## ## MAIN

## the given data:
my $a = ["I", "L", "O", "V", "E", "Y", "O", "U"];
my $b = [ 2, 4, 0, 3, 2, 0, 1, 9 ];
my $c = ['!', '?', '£', '$', '%', '^', '&', '*'];

## add an element to @a to show truncation
push $a->@*, 'X';

my $zipped = zip( $a, $b, $c );

for my $list ( $zipped->@* ) {
    say join ' ', $list->@*;
}

say '=' x 25;

## add more elements to @a to show the new behavior
push $a->@*, ('X') x 2, ('O') x 3;

my $zipped_undef = zip_undef( $a, $b, $c );

for my $list ( $zipped_undef->@* ) {
    say join ' ', $list->@*;
}

## ## ## ## ## SUBS

sub zip {
## interleaves into a list of lists, with an index for every element in the shortest input list
## longer lists will be truncated and the data unused
    my @output;
    my $shortest = (sort {$b <=> $a} map {scalar($_->@*)} @_)[0];
    for my $list ( @_ ){
        for my $idx (0..$shortest-1) {
            push $output[$idx]->@*, $list->[$idx];
        }
    }
    return \@output;
}

sub zip_undef {
## interleaves into a list of lists, with an index for every element in the longest input list
## shorter lists will be null padded with undefs to fit
    my @output;
    my $longest = ( sort {$a <=> $b} map {scalar($_->@*)} @_)[0];

    for my $list ( @_ ){
        for my $idx (0..$longest-1) {
            push $output[$idx]->@*, $list->[$idx];   ## this will autovivate undef elements as required
        }
    }
    return \@output;
}
