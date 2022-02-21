#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       paths-of-least-resistance.pl
#
#       Triangle Sum Path
#         Submitted by: Mohammad S Anwar
#         You are given a triangle array.
# 
#         Write a script to find the minimum sum path from top to bottom.
# 
#         Example 1:
#         Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
# 
#                         1
#                        5 3
#                       2 3 4
#                      7 1 0 2
#                     6 4 5 2 8
# 
#         Output: 8
# 
#             Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8
#         Example 2:
#         Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]
# 
#                         5
#                        2 3
#                       4 1 5
#                      0 1 2 3
#                     7 2 4 1 9
# 
#         Output: 9
# 
#             Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9

#         method:
# 
#             This took me bit, understanding what exactly was meant by the
#             idea of a "minimum sum path". A triangle, to me, implies a
#             directed graph of some sort, which would involve navigating
#             the edges in some optimal fashion.
# 
#             A quick study of the examples shows this not to be the case.
#             In fact, for lack of some flash of insight I can't seem to
#             come up with much of a reason at all for using those terms to
#             descibe what we are being asked to do. I mean, its not wrong,
#             per se, just not very illuminating.
# 
#             The first two ideas, "minimum" and "sum" speak for
#             themselves, and the smallest total value from a sequence of
#             addition is indeed what we want. It's the "path" part that
#             strikes me as the part that will cause confusion. The term
#             path generally spaks to a series of connected steps
#             describing a way to proceed. One might think that the "steps"
#             involved here were somehow the selected minimal digits, but
#             as it turn out the steps are the the descending levels of the
#             triangle, with each level a complete unit. As such the goal
#             is only to select the minimal value from each level, one per
#             level, and sum the collection.
# 
#             As the triangles themselves are delivered transformed into a
#             flat list-of-lists data structure, the levels themseleves are
#             already grouped into groups of elements for us. Although they
#             are constructed as an array-of-arrays, as that is the data
#             structure available to us, in practice the collection is
#             unordered: the "sum" operation is communitive, and does not
#             care about the order of the additions. Likewise the "minimum"
#             operates on a set, finding the smallest value, again without
#             regard to order.
# 
#             So hence my use of the word "lists" before, as the indexing
#             that de facto exists is inconsequential to either the
#             processing or the outcome. What we have is a list of
#             anonymous array units to be processed one-by-one until we are
#             dine, gathering from each the smallest element to an
#             accumulator that is reported.
# 
#             That's a lot of words to very specifically describe a much
#             simpler operation than I first expected.
# 
#             Although just printing the actual sum would be simpler, we'll
#             follow the example and gather the elements selected along the
#             way to produce our "path".
# 
#             ---
# 
#             You know, when I do these challenges, and especially when I
#             review the work of others, I make a concerted effort not to
#             ever use the word "easy". Why? Because it communicates very
#             little informatiion, and none of it useful. When I say
#             something is easy, I can only really mean that it is easy for
#             me. Other people, less familiar with the material, or the
#             required steps to a solution, might find the task
#             considerably more difficult. I don't know what they know, and
#             knowing the solution myself makes me blind to the state of
#             not knowing it.
# 
#             To them, knowing that I found the task easy does not help at
#             all. It's a distraction, or perhaps nothing at all at best,
#             and at worst sets up a judgemental ruling that their own
#             efforts, struggling to put the pieces together, are
#             substandard. I have no idea why I would ever want to do this.
#             Belittleing another person in no way makes me objectively
#             better. I remain exactly as able after as I was before.
# 
#             This isn't to be taken as a rejection of things actually
#             *being* easy mind you. I love that feeling of being overtaken
#             by exhuberance on a job well-done. Confidence is good, as is
#             pride in one's work, up to but not beyond the point of being
#             noticed by the gods. That other related word, hubris, is an
#             important idea to keep around, and I'm quite pleased a
#             clasicist hammered the nuances of the Greek term into my head
#             years ago. It has seved me well in life.
# 
#             So in the end I've decided that declaring things "easy"
#             amounts to nothing but a brag. An empty boast at that, as the
#             claim does not achieve anything of value. The only possible
#             effect it can have, it seems, is to cut someone else down, if
#             they are finding the task difficult.
# 
#             Perhaps I'm being a little hard on the term. It's still a
#             good word, after all. 
# 
#             But I really can't stand braggarts.
# 
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use List::Util qw( sum min );

## default triangle
my $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ] ;

my @out      = map { min( $_->@* ) } $triangle->@*;

say "minimum sum path: ", (join ' + ', @out), " => ", sum @out;
