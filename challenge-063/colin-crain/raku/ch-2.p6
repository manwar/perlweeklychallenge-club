#!/usr/bin/env perl6
#
#       chopped_and_screwed.pl
#
#         TASK #2 › Rotate String
#         Submitted by: Mohammad S Anwar
#         Lovingly Crafted by: Ryan Thompson
#
#             Given a word made up of an arbitrary number of x and y
#             characters, that word can be rotated as follows: For the
#             ith rotation (starting at i = 1), i % length(word)
#             characters are moved from the front of the string to the
#             end. Thus, for the string xyxx, the initial (i = 1) % 4 =
#             1 character (x) is moved to the end, forming yxxx. On the
#             second rotation, (i = 2) % 4 = 2 characters (yx) are moved
#             to the end, forming xxyx, and so on. See below for a
#             complete example.
#
#             Your task is to write a function that takes a string of xs
#             and ys and returns the maximum non-zero number of
#             rotations required to obtain the original string. You may
#             show the individual rotations if you wish, but that is not
#             required.
#
#             Example Input: $word = 'xyxx';
#
#             Rotation 1: you get yxxx by moving x to the end.
#             Rotation 2: you get xxyx by moving yx to the end.
#             Rotation 3: you get xxxy by moving xxy to the end.
#             Rotation 4: you get xxxy by moving nothing as 4 % length(xyxx) == 0.
#             Rotation 5: you get xxyx by moving x to the end.
#             Rotation 6: you get yxxx by moving xx to the end.
#             Rotation 7: you get xyxx by moving yxxx to the end which is same as the given word.
#             Output: 7
#
#         ANALYSIS AND METHOD
#
#             One obvious way to proceed is to build a loop, do the
#             transform, and jump out if the transformed string is the
#             same as the initial. This is all well and good, but does
#             follow through to the next question, which is whether it
#             will always eventually find a solution, or whether we
#             might perchance get stuck in an infinite stable
#             oscillation of some sort.
#
#             This got me thinking more about what we’re actually doing
#             here. And the big reveal is that looked at the right way,
#             the sequence of characters never changes. When we move the
#             first character of the string to the end, the last
#             character is now followed by the first. No matter how many
#             characters are moved over at a time, this relationship
#             will always remain true, and each character within the
#             string will at all times be followed (and proceeded by)
#             the same characters as in the original untransformed
#             string. All we have done is created a new rule, that the
#             end of the string is immediately followed by the
#             beginning. In topology this is known as a loop, a function
#             over an interval where the state at the end of the
#             interval is exactly the same as the beginning. Think of a
#             donut, being a circle rotated in space to form a torus. We
#             have made something quite like that, but with a string.
#
#             We have no natural data type for a loop of string, but
#             using modular arithmetic we can pretend we do, leaving the
#             string alone and just changing the index of the start
#             point, or, in topology what is known as the base point. As
#             long as when moving forward we treat the current position
#             as mod the length of the string, we will remain on the
#             loop. This is akin to pointing to a point on a circle and
#             declaring that the circle starts here: no matter where you
#             start, one can always trace a complete circle from that
#             point. As a matter of fact, once we have the logic to move
#             the starting point in our loop according to the rules of
#             the given progression, we can then determine that we have
#             worked our way through a complete cycle by observing when
#             our start point returns to 0. At this level of
#             abstraction, we have completely abandoned our actual text;
#             we don’t even need the string anymore to do our math, and
#             can just count the iterations. Neat!
#
#             It is worth noting before we get too excited that what
#             we’ve solved here this isn’t exactly our problem. It does
#             however give a lot of insight into what we were tasked
#             with. In our thought experiment, it doesn’t matter what
#             the characters of the string are, because given enough
#             rotations the start point will work its way back to 0. But
#             for our challenge we do care: in a random assemblage of xs
#             and ys, an objectively differently ordered but identical
#             pattern might arise by happenstance, so we will need to
#             construct and examine the intermediate steps to check for
#             this. But before that, to follow through in our analysis,
#             what we can do is construct a little program:
#
#                 for my $len (1..500) {
#                     my $idx = 0;
#                     my $i;
#
#                     while (++$i) {
#                         $idx = ($idx + ($i % $len)) % $len;
#                         last if $idx == 0;
#                     }
#                     say "$len     $i";  ## string length and number of rotations to cycle
#                 }
#
#             which, for any arbitrary length of string, will provide an
#             upper bound of the maximum number of steps required to
#             come full circle.
#
#             Notable in the Raku solution is how elegant it is to
#             create a string of random xs and ys between 4 and 12
#             characters long. These constraints are rather arbitrary,
#             but demonstrate the function well. To move the string
#             parts we use a substitution routine.
#
# # # # # # # # # 2020 colin crain


sub MAIN (Bool :$v = False) {
    say "\nrotations required: ", churn( xys, $v );
}

sub xys {
    # creates a string of xs and ys of random length 4..12
    return [~] <x y>.roll( (4 .. 12).pick );
}

sub churn ($base, $v) {
    my $shifted = $base;
    my $i = 1;

    say "starting string:      ", $base, "\n" if $v;
    while (1) {
        my $moves = $i % $base.chars;
        $shifted ~~ s/(\S ** { $moves })(.*)/$1$0/;

        printf "move %-2d  shifting %2d chars:     %s\n", $i, $moves, $shifted if $v;
        return $i if $shifted eq $base;
        $i++;
    }
}
