#! /opt/local/bin/perl
#
#       palindrome_thunderdome.pl
#
#         TASK #2 › Palindrome Partition
#         Submitted by: Mohammad S Anwar
#         Looked Over by: Ryan Thompson
#
#             You are given a string $S. Write a script print all possible
#             partitions that gives Palindrome. Return -1 if none found.
#
#             Please make sure, partition should not overlap. For example,
#             for given string “abaab”, the partition “aba” and “baab”
#             would not be valid, since they overlap.
#
#             Example 1
#                 Input: $S = 'aabaab'
#                 Ouput: 'aa', 'baab'
#             Example 2
#                 Input: $S = 'abbaba'
#                 Output:
#                      There are 2 possible solutions.
#                          a) 'abba'
#                          b) 'bb', 'aba'
#
# # # # # #
#
#         METHOD
#
#             First things first, we’re going to have to define some
#             terms. I’d say on the face of it, the specification is
#             ambiguous. So let’s break it down: we are asked for “all
#             possible partitions that gives Palindrome“. In the
#             examples given, the solutions find ways to split the
#             string to reveal palindromes contained within, but some
#             parts of the string are not included in the answer,
#             suggesting that we are in fact being asked to find all
#             sets of non-overlapping palindromes that can be found
#             within the string. I also note there is also one
#             additional solution to Example 1:
#
#                 aa aa
#
#             which is not listed, but as far I understand fits the
#             criteria, as the two aa groups do not reference the same
#             characters in the string. So by “partition” we mean to
#             divide into an ordered list of segments, and then select
#             out those segments that are palindromes. Which leads to my
#             second clarification, what is a palindrome? Technically
#             any single letter is read the same backwards and forwards,
#             and as such is, technically, a palindrome. But that, to
#             use technical term, is stupid. So we won’t count them. The
#             examples given, however, allow for two letter groupings,
#             which I also consider a pretty degenerate form and not
#             very interesting, but on this I will concede. I do think
#             as the only reason we care at all about palindromes is
#             because they’re interesting, so I think that’s a pretty
#             powerful for excluding common double letters from the
#             club. But no mind.
#
#             So with our interpretation nailed down, we will proceed.
#
#             Lets just go out and say I really wanted to do this with a
#             single regex somehow, to parse the whole thing out using
#             the RE sublanguage. I then realized that this is a tall
#             order, that I didn’t have all week to think this over, and
#             it’s not even necessarily even possible. So, one night
#             when out on a walk, I thought up the process below, which
#             is more of a hybrid approach.
#
#             Browsing through the perl RE tutorial, I had wandered
#             across a nice version of a regex to identify whether a
#             given string is indeed a palindrome. But I didn’t like it,
#             because I had a different idea in mind, and in the first
#             place I was there to check the syntax for embedding a code
#             block that evaluates to a regex on execution. But it was
#             encouraging. In any case I found what I was looking for,
#             and so made my own.
#
#             There are two forms of code block, the first,
#
#                 (?:{ your_code_here })
#
#             allows the insertion of a logical test, or really any
#             arbitrary piece of code, as part of the match process;
#             this is a zero-width assertion that must evaluate to a
#             true value to continue.
#
#             The second form,
#
#                  (??:{ evaluation_becomes_part_of_the_match_expression }
#
#             is what we want. I find the doubling of the ?? as
#             analogous to the /ee doubled eval switch. First the code
#             is run, the result is inserted in place into the regex and
#             then the match evaluated. Ideal.
#
#             The idea here is to match one or more characters and
#             capture, then possibly a central pivot character, then
#             reverse the captured string to check the match: instant
#             palindrome. To do this the construct
#
#                 (.+).?(??:(reverse $1))
#
#             will do the job for us nicely.
#
#             To find all the internal palindromes we will need to check
#             each substring of at least two characters starting from
#             each position in the original string. This is likely to be
#             the most expensive operation, but we can constrain it a
#             little to keep things manageable. We run the successful
#             matches through a hash to keep the list elements unique.
#
#             Once we have a master list of palindromes can construct
#             individual sets of internal palindromes by recursively
#             iterating through the list and passing $’ to the next
#             function, adding to the chain until there are no more
#             matches to be made. This familiar path walking exercise
#             will produce all possible match sequences, so hence all
#             ways to divide out internal palindromes, if we allow that
#             some of the partitions are not to be counted in the result
#             set.
#
#             Which is what we decided earlier was what the challenge
#             was asking for.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $string = prepare_input( @ARGV );
$string ||= "aaabaaabaaa";

my @palins = all_palindromes($string);

my $solutions = [];
get_lists( $string, [], $solutions, \@palins);

for ($solutions->@*) {
    say "$_->@*";
}

## ## ## ## ## SUBS:

sub all_palindromes {
## extract every possible palindrome from the input string
    my $string = shift;
    my %palins;
    my $target;
    my $start = -1;
    while ( $start++ < length($string)-2 ) {
        for (2..length($string)-$start) {
            $target = substr( $string, $start, $_);
            if( $target =~ m/^(.+).?(??{reverse($1)})$/)  {
                $palins{$target}++;
            }
        }
    }
    return sort keys %palins;
}

sub get_lists {
## recursively walk lists of combinations of palindrome matches
    my ($string, $list, $solutions, $palins, ) = @_;
    my $joined = join '|', $palins->@*;
    if ($string !~ /$joined/) {
        push $solutions->@*, $list;
        return;
    }
    for ( $palins->@* ) {
        if ($string =~ /$_/) {
            my @list = ( $list->@*, $_ );
            get_lists( $', \@list, $solutions, $palins);
        }
    }
}

sub prepare_input {
    $_ = join '', @_;
    s/\W//g;
    s/_//g;
    return lc;
}
