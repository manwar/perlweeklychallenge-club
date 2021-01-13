use v6.d;

#
#       vowel-wow-wow.raku
#
#         TASK #2
#         Vowel Strings
#             Write a script to accept an integer 1 <= N <= 5 that would print all
#             possible strings of size N formed by using only vowels (a, e, i, o,
#             u).
#
#             The string should follow the following rules:
#
#                 ‘a’ can only be followed by ‘e’ and ‘i’.
#
#                 ‘e’ can only be followed by ‘i’.
#
#                 ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
#
#                 ‘o’ can only be followed by ‘a’ and ‘u’.
#
#                 ‘u’ can only be followed by ‘o’ and ‘e’.
#
#             For example, if the given integer N = 2 then script should print the
#             following strings:
#
#                 ae
#                 ai
#                 ei
#                 ia
#                 io
#                 iu
#                 ie
#                 oa
#                 ou
#                 uo
#                 ue
#
#         method: Well just to get this out of the way:
#
#               chaos, audio, teal, video, deuce, poet, coin, dual, guide
#
#             not to mention
#
#               bazaar, teen, skiing, cool, and vacuum
#
#             The practical upshot being, the rules stated in the challenge are
#             just rules that resemble the way vowels group in English, and
#             don't really reflect the way this crazy mixed-up language actually
#             works. But this is all just in fun, right? So who cares? In any
#             case a part of me needed to make that list, just to be clear that up.
#
#             Incidently, it was only the 'aa' combination that was difficult to
#             come up with, avoiding obscure loan words (think Dutch, or, you
#             know, Afrikaans). So "krall" almost made the cut, because I know
#             some South Africans (think "corral"). "Aarkvark" is also Afrikaans
#             but rather more well-known. "Bazaar" has remarkably been around
#             since the 16th century and is part of the name of a popular
#             magazine, so that wins out. It may well be the only candidate that
#             fits those criteria.
#
#             So the rules are just some rules, but that doesn't make them less
#             important; they define connections of the data set. We start with
#             the five most common vowels, as apparently we're ignoring "y" and
#             "w" as well.* Moving on, moving on...
#
#             The problem becomes, like many, a problem of structuring data. The
#             core components are a list of vowel combinations and a mapping of
#             letters to an array of next letter possibilities. We transverse
#             the list, shifting off elements of a given length and looking at
#             the last letter in the string, adding new combinations to the end
#             of the list as we go. By carefully keeping track of the indices,
#             we can shift off a complete set of strings of a given length, then
#             repeat the process to add another letter until our output strings
#             are the desired length.
#
#             The method works for any positive vowel string length, not just
#             1 <= n <= 5 as required, but as the output grows exponentially,
#             things get out of hand quickly.

#         comment: The question of how the list of solutions grows is an
#             interesting one. I made a little meta-analytical loop wrapper and
#             solved for 1..15, only counting the solutions rather than printing
#             them out, with results summarized below:
#
#                  n     clusters
#                 ----+--------
#                  1     5
#                  2     11
#                  3     23
#                  4     50
#                  5     107
#                  6     230
#                  7     494
#                  8     1061
#                  9     2279
#                 10     4895
#                 11     10514
#                 12     22583
#                 13     48506
#                 14     104186
#                 15     223781
#
#             The sequence is clearly exponential, but exactly how that growth
#             progresses is not obvious.
#
#             One fairly expeditious way to proceed is to just give WolframAlpha
#             the data and have it do a least-squares fit:
#
#                  exponential fit 5,11,23,50,107,230,494,1061,2279,4895,10514,22583,48506,104186,223781
#
#             through which we find a good approximation can be made by the
#             equation:
#
#                  f(x) = 2.34215 e^(0.76449 * x)       R^2 = 1.
#
#             So:
#
#                  f(20)        =  10,230,300  to 6 significant digits
#                  clusters(20) =  10,239,398  the actual count computed
#
#             With a little over 10 million results for n=20 the computational
#             effort is becoming impractical. However if we double the length to
#             n=40 things have just exploded:
#
#
#                  f(40)        = 44,685,500,000,000
#
#             It does seem exponential growth is all the rage these days, no?
#
#             * For the record, I look forward to day I figure out how to use
#             "cwtch" in a sentence in an unforced manner. "Why" you ask? See
#             what I did there? Why does only "y" get the love? Cwtch has been
#             in the OED since 2005. Unlike "cwm", being a rather obscure name
#             for the rounded divit at the end of a valley, a cwtch means the
#             special comfort of a hug from a loved one. Now there's a word the
#             world needs if I ever heard one.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int:D $length where {$length > 0} = 3) {
    my @output    = qw< a e i o u >;
    my %following =  a => qw< e i     > ,
                     e => qw< i       > ,
                     i => qw< a e o u > ,
                     o => qw< a u     > ,
                     u => qw< o e     > ;
    my $count = 1;

    while $count < $length {
        my $num_clusters = @output.elems;
        for ^$num_clusters {
            my $vowel_cluster = @output.shift;
            my $vowel = substr $vowel_cluster, *-1, 1;
            for %following{$vowel}.list {
                @output.push: $vowel_cluster ~ $_;
            }
        }
        $count++;

    }

    .say for @output;
}
