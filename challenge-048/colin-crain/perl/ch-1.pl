#! /opt/local/bin/perl
#
#       ugandan_firing_squad.pl
#
#         TASK #1 Survivor
#             There are 50 people standing in a circle in position 1 to 50. The
#             person standing at position 1 has a shovel. He kills the next
#             person i.e. standing at position 2 and pass on the shovel to the
#             immediate next i.e. person standing at position 3. Now the person
#             at position 3 does the same and it goes on until only one
#             survives.
#
#             Write a script to find out the survivor.
#
#         comments: this is much like PWC 46-2, "Is the Room Open?" albeit with
#             a shockingly un-healthy dose of inhumanity and horror. In
#             keeping with that spirit, I've changed the title and the supplied weapon
#             from sword to shovel. I'm sure there are other options of
#             historical precedence to choose from, but for some reason I went
#             with Idi Amin. We will not speak to that sordid reference again.
#
#             In the Hotel challenge, the second employee merely closes every
#             second door, which is tidy and well mannered. In this version we
#             have two changes to that alternating pattern, the first that
#             "closing" the element removes it from play, the second that the
#             process is circular, so that once the last person is reached the
#             slaughter continues unabated as the last person is still adjacent
#             to the first. As such the processing, the elimination of the
#             person to one's immediate side*, continues until there's no one
#             remaining for the sole survivor to murder.
#
#             * left or rightward implementation of the death-dealing is neither
#             specified, nor does it matter. Feel free to infer a political
#             metaphor here if you wish.
#
#         method: We will create a list of people and number them 0-49. The
#             actual naming convention does not matter, we only need a unique
#             label to keep track of the individuals as the winnowing
#             progresses. Indexing on 0, though, instead of 1 will help us
#             later, to reveal patterns in the process. So the result, position
#             36, according to the original spec is postion 37. As stated, we're
#             going to go head and keep this change, as it makes the pattern
#             easier to see.
#
#             When we step through the process defined, the person at a given
#             index kills the next person, at index + 1. That person is
#             eliminated, and the person beyond moves into the empty slot. The
#             shovel is then handed to that person, now at slot index + 1, who
#             eyes the person at index + 2. The circular aspect is modeled by
#             applying a modulus equal to the number of remaining people in the
#             circle at a given moment. That number is always one more than the
#             array index, so when we are at the end of the array, index + 1 is
#             equal to the size of the array, the index is reset to position 0,
#             who becomes the next unlucky target, and the horror continues
#             unabated. No rest for the wicked.
#
#             In a post-analysis, a loop construct over a range of inputs
#             reveals a simple underlying progression based around powers of 2,
#             resulting in a practical survival plan:
#
#         conclusion: if one ever has the misfortune to be in this terrible
#             situation, quickly count the size of the group. Subtract the
#             largest smaller power of two from that number and double the
#             remainder. Counting from zero, make sure you are in that position
#             in line and you will live. (Assuming you wish to survive, of
#             course. That ethical morass is beyond the scope of the current
#             discussion.) For example, if you have 57 people in the group,
#             subtract 32, yielding 25, doubled to 50. Counting from 0, insert
#             yourself at position 50. Easy peasy. Now all you have to do is
#             kill 5 people. Sorry.
#
#             Or at the bare minimum, (remember you are counting from 0!) make
#             sure you are in an even-numbered position (that's position, not
#             count). Then at least you have a chance, as all the odds are
#             always killed.
#
#             In a more sobering note, if you are unable to control your
#             position in the circle and conclude you are lost, the best play
#             may be to strip naked and try and beguile the guards. If
#             successfully distracted, or perhaps confused, grab a pistol and
#             start shooting. The outcome will likely be the same, however you
#             may at least have the satifaction of taking a few of the bastards
#             with you. May the odds be in your favor.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN
my $victims = 50;  ## I think the last person standing still qualifies as a victim in this
                   ## psychopath's fever-dream battle royal
my @circle = (0..$victims-1);
say join ", ", @circle;
my $next = 0;

while ( scalar @circle > 1 ) {
    $next = ++$next % scalar @circle;    ## find the next target position
    splice @circle, $next, 1;            ## do the dirty deed and the next person slide into that spot
    say join "  ", @circle;              ## not necessary but makes the progression visible
}

say "survivor: ", $circle[0], "\n";



## ## ## ## ##

## now let's take a moment to look at an overview of the positional standing of
## the last survivor as we vary the starting number of victims in the circle:

for (2..100) {
    printf "%2d --> %d\n", $_, survivor($_);
}

sub survivor {
    my @circle = (0..shift(@_)-1);
    my $next = 0;

    while ( scalar @circle > 1 ) {
        $next = ++$next % scalar @circle;
        splice @circle, $next, 1;
    }

    return $circle[0];
}
