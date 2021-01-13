use v6.d;

#
#       48-2-palindrome_dates.raku
#
#       PWC 48 - TASK #2
#         Palindrome Dates
#         Write a script to print all Palindrome Dates between 2000 and 2999.
#         The format of date is mmddyyyy. For example, the first one was on
#         October 2, 2001 as it is represented as 10022001.

#         method: constructing a list of palindrome candidates is in itself
#             little problem, merely reverse the year as a string and prepend
#             it. The primary challenge is evaluating whether this candidate can
#             be viewed as a valid mmddyyyy date. This is ascertained by
#             limiting 0 < m < 13 and that the day falls within the span of a
#             given month, determined by a lookup.
#
#             Leap years need not be considered as the date 02-29 reverses to
#             9220, which when considered as a year is outside the 2000-2999
#             range specified. We can see the largest possible day in our given
#             span will be the 22nd of any month, as any year past 2299 will
#             produce a date of the 32nd of the month and be invalid. In fact,
#             the only valid days in the range are the 2nd, the 12th, and the
#             22nd, corresponding to the century components 20xx, 21xx and 22xx.
#             All 12 months can be formed by the years after the centuries;
#             combining 12 months and 3 possible days = 36 results, which is
#             what is observed.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    ## make a list of valid candidates
    my @candidates = (2000..2999).map({$_.flip ~ $_}).grep({validate($_)});

    ## a little prettification and output
    .map({S/^(..)(..)/$0-$1-/}).put for @candidates;

}

sub validate ($candidate) {
## returns true is the given string represents a valid mmddyyyy date
## does not consider leap years, in this case they are logically irrelevant
    my @mlen  = 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31;
    my ($m, $d ) = $candidate.comb(2);

    return      $m > 12
             || $m == 0
             || $d > @mlen[$m-1]
             || $d == 0             ?? 0 !! 1;
}


