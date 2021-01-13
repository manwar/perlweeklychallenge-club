#!/usr/bin/env perl6

#       palindrome_thunderdome.raku
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
#             In Raku side, the get_all_palindromes() routine is straightforward
#             with the :exhaustive adjective. Oddly, calling
#             .Str on the .list of @matches produces a list containing
#             one element of a stringification of all the matches
#             separated by spaces, rather than providing access to the
#             matches as a list of strings. A one might easily imagine
#             this would be a hard bug to catch, as the printed
#             representation of the lists are the same, and you would be
#             right. As always, dd, with it’s nicely verbose output, is
#             your friend. We can then call .unique before returning.
#
#             The special variables $&, $` and $' are replaced by $/,
#             the current match object, which knows all kinds of things
#             about itself. This includes the parts of the original
#             string before and after, which are accessed with
#             $/.prematch and $/.postmatch. Another thing to notice is
#             again we need pointy brackets within the regex we have
#             constructed in order to get proper variable interpretation
#             for our joined up string of palindrome options.
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

#             2020 colin crain
#####################################



sub MAIN( *@input ) {
    my $string = process_input(@input);
    $string ||= "aaaBBaacXXyz";                 ## default processed input
    my @palins = get_all_palindromes($string);

    my @solutions;
    get_lists($string, [], @solutions, @palins);

    .put for @solutions;
}

sub get_all_palindromes ( $string ) {
    my @matches =  $string ~~ m:ex/ (.+) {} .? "{$0.flip}" /;
    my @list = @matches.map: {.Str};
    return @list.unique;
}

sub get_lists ($string, @list, @solutions, @palins) {
## recursively walk lists of combinations of palindrome matches

    my $joined = @palins.join: '||';
    unless $string ~~ m/<$joined>/ {
        @solutions.push: @list;
        return;
    }
    for ( @palins) -> $item {
        if ($string ~~ m/$item/) {
            my @newlist = @list;
            @newlist.push: $item ;
            get_lists( $/.postmatch, @newlist, @solutions, @palins);
        }
    }
}

sub process_input ( @input ) {
    my $string = @input.join;
    $string ~~ s:g/\W//;
    return $string;
}
