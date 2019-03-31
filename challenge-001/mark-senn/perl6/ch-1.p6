#
# Retrieved from
#     https://perlweeklychallenge.org/blog/a-new-week-a-new-challenge
# on 2019-03-27 at 11:28 -04:
#
#     Challenge #1
#
#     Write a script to replace the character ‘e’ with ‘E’ in the
#     string ‘Perl Weekly Challenge’. Also print the number of times
#     the character ‘e’ found in the string.
#

$_ = 'Perl Weekly Challenge';

# See
#     https://docs.perl6.org/syntax/tr$SOLIDUS$SOLIDUS$SOLIDUS
# and
#     https://docs.perl6.org/type/StrDistance
# for more information about "tr///" and the "StrDistance" object.
my $distance = tr/e/E/;
say +$distance;