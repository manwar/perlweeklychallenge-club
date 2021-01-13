#! /opt/local/bin/perl
#
#       versions_of_you.pl
#
#         PWC 58 TASK #1 › Compare Version
#             by Ryan Thompson
#             Compare two given version number strings v1 and v2 such that:
#
#                 If v1 > v2 return 1
#                 If v1 < v2 return -1
#                 Otherwise, return 0
#
#             The version numbers are non-empty strings containing only digits,
#             and the dot (“.”) and underscore (“_”) characters. (“_” denotes an
#             alpha/development version, and has a lower precedence than a dot,
#             “.”). Here are some examples:
#
#                    v1   v2    Result
#                 ------ ------ ------
#                   0.1 < 1.1     -1
#                   2.0 > 1.2      1
#                   1.2 < 1.2_5   -1
#                 1.2.1 > 1.2_1    1
#                 1.2.1 = 1.2.1    0
#
#             Version numbers may also contain leading zeros. You may handle
#             these how you wish, as long as it’s consistent.
#
#         method: When asked to compare two version strings, it's important to
#             qualify that there is no single methodology out in the wild for
#             versioning. So this is really a task to distinguish and rank
#             within a certain versioning system.
#
#             This system uses the common scheme of numbers separated by dots,
#             with the added rule that alpha and other pre-release verions are
#             given an underscore separator rather than a dot; these versions
#             are counted as higher than the previous release they superceed,
#             but lower than that same numbering using dot notation.
#
#             It's not defined exactly where this underscore will lie, but for
#             the sake of completeness we should declare before beginning that
#             1.2_1 == 1_2.1 == 1_2_1, although I'm sure whoever is using this
#             system would have something to say to their developers on using
#             only one correct form. Best to make any such distinction not
#             matter, to be sure. There are no "double alpha code secret
#             special" versions.
#
#             Leading zeroes in a given grouping will have no effect on a
#             numeric sort, so 1.0002.001 > 1.2, which is sort of what one might
#             expect. Only the major release need be defined, to give us
#             something to start with. Leaving the 0 off of 0.9 is a no-no, as
#             writing release .9 leaves way too much room for misreading; this
#             pratice shouldn't be tolerated by decent, civilized people.
#             Trailing dots and dashes should reasonably result in much head
#             shaking and tut-tuting but the abomination 1.2_ will parse just
#             fine as a prerelease 1.2.
#
#             But not _1.2. No, that's too far by far. Pretty sure will get you
#             fired, or hurt, or both, which again is as it should be. It's not a
#             private method. It's a versioning system, not your personal
#             plaything.
#
#             Anyways, the numeric relative equality operator <=> already
#             returns 1, 0 or -1, so we'll be using that whenever we can.
#
#             The numeric components of major, minor and point release can be
#             numerically sorted in that order, falling through in granularity
#             if a given level is equal. A level of granularity if left
#             undefined can be considered 0, so in comparing 1.2 with 1.2.3 we
#             first compare 1 with 1; they are equal so we fall through and
#             compare 2 with 2, equal again. Then we compare an undefined value
#             with 1; the undefned value can be considered 0 for this purpose
#             and the 1 value is greater, so we return -1. In other words, the
#             versions 1.2 and 1.2.0 are to be considered the same. Additional
#             sub-point releases will also be handled just fine if we wish to go
#             there: 1.2.1.1 vs. 1.2.1.1.1, whatever it takes. The sky's the limit.
#
#             Only if no clear greater version is determined by this point do we
#             need to evaluate whether either is an alpha release. To do this we
#             can search for an underscore: if either both or neither contain
#             the character, the versions are still declared equal; if only one
#             does, the other version is the greater.
#
#
#
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $one = '1.02.1';
my $two = '1.2_1';

print compare_versions($one, $two);


## ## ## ## ## SUBS:

sub compare_versions {
    my ($v1str, $v2str) = @_;

    ## isolate the numeric portions
    my @v1 =  split /[._]/, $v1str;
    my @v2 =  split /[._]/, $v2str;
    my $index_max = @v2 > @v1 ? @v2-1 : @v1-1;

    ## iterate through the numerical portions by common index
    ## if a clear winner emerges, return immediately with the decision
    for my $index (0..$index_max) {
        my $v1 = $v1[$index] // 0;
        my $v2 = $v2[$index] // 0;
        return $v1 <=> $v2 if ($v1 <=> $v2) != 0;               ## -1 or 1
    }

    ## if we are still equal at this point, evaluate dot vs dash releases:

    ## neither or both are alpha then they are in fact equal
    if ( "$v1str$v2str" !~ /_/ or ("$v1str" =~ /_/ and "$v2str" =~ /_/)) {
        return 0;
    }
    elsif ("$v1str" =~ /_/ ) {          ## if 1 is alpha 2 is larger
        return -1;
    }

    return 1;                           ## then 2 is alpha and 1 is larger
}
