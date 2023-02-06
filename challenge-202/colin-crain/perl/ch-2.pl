#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Widest Valley
#         Submitted by: E. Choroba
# 
#         Given a profile as a list of altitudes, return the leftmost
#         widest valley. A valley is defined as a subarray of the profile
#         consisting of two parts: the first part is non-increasing and the
#         second part is non-decreasing. Either part can be empty.
# 
# 
#         Example 1
#             Input:  1, 5, 5, 2, 8
#             Output: 5, 5, 2, 8
# 
#         Example 2
#             Input:  2, 6, 8, 5
#             Output: 2, 6, 8
# 
#         Example 3
#             Input:  9, 8, 13, 13, 2, 2, 15, 17
#             Output: 13, 13, 2, 2, 15, 17
# 
#         Example 4
#             Input:  2, 1, 2, 1, 3
#             Output: 2, 1, 2
# 
#         Example 5
#             Input:  1, 3, 3, 2, 1, 2, 3, 3, 2
#             Output: 3, 3, 2, 1, 2, 3, 3

#         analysis:
# 
#         what an unusual puzzle. It has a few moving parts that will each
#         need to be approached each at their own level of resolution. We
#         have a definition of a valley: a subarray that starts level or
#         descending, then chnages to level or ascending, continuing until
#         direction changes again. When that happens we have spanned a
#         complete valley element. As we need the subarray data for output
#         it, or its end indices, need to be saved out.
# 
#         But we're not done! No, we need to continue searching from the
#         point where the direction turns downwad again and see if we find
#         another, wider valley. THen we can compare the new width to the
#         old and replace our previous maximum if this one is wider.
# 
#         BUT... there's a catch. There's always a catch, right? Real life
#         is a messy tangle of contradictions with no escape. This mortal
#         coil is an abused slinky toy, bent and turn in on itself, no
#         longer able to effortlessly descend a stair, amusing the
#         onlookers with its bouncy physical attributes.
# 
#         Wow that metaphor really took of, didn't it?
# 
#         The problem arises as we have defined our left valley face as
#         non-increasing —  that is, either unchanging or decreasing in
#         value. The same allowance for an unchanging right face is also
#         given.
# 
#         What this means, then, is that, given a flat plateau, the right
#         face of one valley and the left face of the next rightward can
#         occupy the same set of equal values, and must be considered in
#         both structures. We can't just start counting anew when we finish
#         one valley; we need to be alreadly looking ahead into the next
#         before we exit the previous.
# 
#         Consider the stripped-down example:
#         
#             1,0,0,0,1,1,1,0,0,0,0,1
#             |-----------| |-------|
#                   7           5
#                     |-------------| 
#                            8
#         
#         Counting the first valley we descend, remain stationary for a
#         while, then ascend to a plateatu for three positions until the
#         height begins to descend again and we stop. The total width is 7.
#         Counting forward from that position we remain flat for four
#         places, defining the left face, then ascend one for a total width
#         of 5. The first valley is larger using this reckoning.
# 
#         However this is incorrect. The second valley actually starts
#         earlier, at the left edge of the central plateau. Including these
#         positions, the second valley has width 8, and is the larger.
# 
#         We'll have to watch for that. 

#       method:
# 
#         we will need three containers to hold the various valleys we
#         collect as we traverse the input array from left to right. We
#         will also need an iterator index variable, but we can use the
#         topic. 

#         A flag will keep track of which face of the valley we are
#         currently on, the left, descending bank, including the basin at
#         the bottom, or the right, ascending bank and any plateau at the
#         top. The directive that either face can be empty only matters at
#         teh head and tail of the array, as internally any index will be a
#         part of some valley or another, even if there is no elevation at
#         all! In that case the horizontal plain will be considered a
#         valley from teh beginning and will be the widest found.
# 
#         But whichever direction the first pair of indices move in, that
#         will determine our initial face, descending or ascending.
# 
#         The process moves from index to index, but the state of the
#         machine at any given point is dependant on the face we are on and
#         the movement of a value relative to that at the previous index. A
#         further complication is brought in because we have separate
#         criteria for adding values to the hypothetical overlapping left
#         face of the next valley to be examined.
# 
#         Only when an ascending, right face turns down are we definitively
#         out of the current valley and we then compare it to the current
#         stored maximum, replacing that stored array with the current if
#         it is longer. In any case whether the current is long enough or
#         not, it is discarded and replaced with the lookahead next valley
#         we've been watching. At this point after replacing we void out
#         the next array of our stack.
# 
#         We could use a proper stack of array references but this whole
#         process is confusing enough and there would be little gain. But
#         we could do that if we wanted to be algorithmic purists.
# 
#         Observant readers will note that there's a little hiccup when an
#         array is not initialized, where we need to make sure to also add
#         the previous value along with the currently indexed, as this will
#         have been skipped using out look-behind paradigm to determine the
#         slope. This happens with the first value checked, the index [1],
#         and again when we have zeroed out the lookahead next valley after
#         completing a previous and swapping it out.
# 

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my @input = @ARGV;
scalar @input == 0 and @input = (1, 3, 3, 2, 1, 2, 3, 3, 2);

my @valley = get_valley( @input );
say "@valley";


sub get_valley ( @data ) {
    my @max;
    my @curr;
    my @next;
    my $face = 0;

    for (1..$#data) {   

        if  (@curr == 0) {                      ## UNINITIALIZED, no current
            push @curr, @data[$_-1, $_];            ##   always add value and previous
        
            $data[$_] <= $data[$_-1]      
                ? $face = 0                         ##   descending or plateau  
                : $face = 1;                        ##   ascending , left is empty
            next;
        }
        
        if ($face == 0) {                       ## LEFT FACE (or basin), descending               
            push @curr, $data[$_];                  ##   always add
            
            $face = 1 if $data[$_] > $data[$_-1];   ##   upturn, switch faces
            next;
        }

        if ($face == 1) {                       ## RIGHT FACE              
            if ($data[$_] >= $data[$_-1]) {         ## ASCENDING (or plateau)
                push @curr, $data[$_];              ##   add value
                if ($data[$_] == $data[$_-1]) {     ##   plateau add to next    
                    @next                           ##   add previous if new
                        ? push @next, $data[$_]
                        : push @next, @data[$_-1, $_];
                }
            }
            
            else {                                  ## DOWNTURN, «END OF VALLEY»
                @max  = @curr if @curr > @max;      ##   check current against max
                @next                               ##   always add to next
                    ? push @next, $data[$_]
                    : push @next, @data[$_-1, $_];  ##   add previous if new

                @curr = @next;                      ##   move next to current and void
                @next = ();
                $face = 0;                          ##   switch faces
            }          
        }
    }
    
    @max  = @curr if @curr > @max;              ## final check of current

    return @max;  
}

