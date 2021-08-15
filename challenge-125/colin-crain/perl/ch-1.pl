#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       triple-play.pl
#
#       Pythagorean Triples
#         Submitted by: Cheok-Yin Fung
#         You are given a positive integer $N.
# 
#         Write a script to print all Pythagorean Triples containing $N as
#         a member. Print -1 if it can’t be a member of any. i
# 
#         Triples with the same set of elements are considered the same,
#         i.e. if your script has already printed (3, 4, 5), (4, 3, 5)
#         should not be printed.
# 
#         The famous Pythagorean theorem states that in a right angle
#         triangle, the length of the two shorter sides and the length of
#         the longest side are related by a2+b2 = c2.
# 
#         A Pythagorean triple refers to the triple of three integers whose
#         lengths can compose a right-angled triangle.
# 
#         Example
#             Input: $N = 5
#             Output:
#                 (3, 4, 5)
#                 (5, 12, 13)
# 
#             Input: $N = 13
#             Output:
#                 (5, 12, 13)
#                 (13, 84, 85)
# 
#             Input: $N = 1
#             Output:
#                 -1

#       background color commmentary:
# 
#         "It's triangles all the way down, man! Just look at my hands!
#         Dude! They're like — a triangle! Far out!" -- attributed to
#         Pythagorous, after visiting the Oracle at Dephi
# 
#         It is said that Pythagorous was obsessed with triangles, to put
#         it mildly. He spent his life searching for the music of the
#         spheres inside the triangle, and to this day we name a basic
#         relationship between squared numbers and the lengths of the sides
#         of certain triangles in his honor.
# 
#         And this is not a footnote in a mathematical journal honor, but
#         rather the relationship works its way into the voice of the Tin
#         Man in the Wizard of Oz of all places. Taught to every
#         grade-school student, it's everywhere.
# 
#         This relationship, that the squares of the two shorter sides of a
#         right triangle when summed equal the square of the length of the
#         third, fascinated him, and when a triangle could be composed such
#         that all of the side lengths were whole, integral numbers was
#         seen to be a window into a divine world of perfection.
# 
#         More than a mathematical oddity, it was a transcendental
#         experience. The fact that the first such triple is 3, 4 and 5 —
#         that is 3^2 + 4^2 = 5^2 — really clinched the deal that this
#         reflected a cosmic purity of truth that reached out to us in our
#         flawed human existence.
# 
#         method:
# 
#         I went at this one completely blind, disconnected from the
#         internet and its presumably easy answers. No, I took a nod to the
#         big man himself and decided to study it out instead.
# 
#         A few brisk internet-free hours later (I really must do this more
#         often), I had a little understanding of the ground-rules. I had,
#         first with pencil and paper, then later on to a spreadsheet,
#         created a list of numbers with their squares, then deltas betwen
#         adjacent squares, then deltas between squares two numbers apart,
#         then three, etc. I discovered the adjacent squares covered all
#         odd numbers in their values, starting odd and incrementing by 2
#         in a sequence. The next set, two apart, incremented by 4 and were
#         all even numbers, and quite importantly covered all even squares.
# 
#         A casual explanation for this is that all even squares are the
#         product of even numbers, and even numbers can be produced by
#         multiplying some whole number by 2, so the square will be a
#         multiple of 4.
# 
#         What this establishes is that aside from a few trivial edge-cases
#         at the beginning, all numbers above 2 can be used to construct a
#         Pythaogorian triple.
# 
#         Wait, what?
# 
#         Yes, really. All odd numbers, and all even squares, can be found
#         in the first two differential columns, and the values on the
#         columns represent the difference between two squares.
#         Cross-referencing back to the values that composed the
#         differential, we have the three values for a triple.
# 
#         If all we wanted was an example, we'd be done here. But CY has
#         asked us for *all* triples, so we must needs press on. You didn't
#         really think it would be so easy, did you?
# 
#         Yea, for a minute there, I did.
# 
#         If we continue the table, though, another fact comes to light:
#         the next column grows by 6, the following 8, every expansion
#         scaling at 2 times the column index, with index 0 being the
#         square value itself. With the scaling as it is, the occurrence in
#         one of these first two columns will represent the largest square
#         associated with it to compose a triple, and all other occurrences
#         of the value on the table will associated with wider
#         differentials and hence smaller squares. A number can come up
#         either as the greater or lesser summand or the sum, and may also
#         be a multiple of some other triple.
# 
#         For example, the square 144, 12 squared, shows up a lot:
#        
#          5² + 12² = 13² as the lesser summand            25  + 144  = 169 
#         12² + 35² = 37² as the greater summand           144 + 1225 = 1369
#         12² + 16² = 20² as the lesser in  {3,4,5} × 4    144 + 256  = 400
#          9² + 12² = 15² as the greater in {3,4,5} × 3    81  + 144  = 225
#         
#         Coming up with all of these possiblilites sounds pretty intensive
#         if we were to assemble combinations of squares to see which ones
#         work. However, all of the triples will be located somewhere in
#         our table already, and our table can even be constructed using
#         iteration rules. We only need to figure out how large to draw it
#         and how to seek values.
# 
#         And the thing is, we don't even need to construct the table, but
#         rather more construct the idea of a table: as all the columns are
#         well defined sequences, we only need to construct the cells that
#         match, if present. And once matched, we don't actually need to
#         put them in a table, but can then use the index directly as there
#         will always be only one match per column. 

#         With this done we're almost home. We've found all the triples
#         with the target square in a summand, but those that sum to the
#         target remain to be found. Fortunately this too yields to the
#         almight power of maths. If we presume the target square is a sum,
#         then that defines an index row, and because the row across is
#         comprside of deltas from the target square and the square one row
#         above, then two rows above, then three all the possible summands
#         will be expressed somewhere on the row.
# 
#         Not only this, but the values can be derived mathematically as
#         well without constructing the table this time either. A simple
#         formula hinged off the iterator and the index determines every
#         element, and if the value is determined to be a square it is kept
#         to an array of summands.
# 
#         This summand array can have more than two elements, but there
#         will always be a multiple of 2, and pairs from the outside
#         working in will always sum to the square of the index. How
#         convenient. So that makes short work of those soultions.
# 
#         Gathering all the triples together we can now report on the
#         results.
# 
#         It wasn't very long to code in the end, but it was a long road
#         getting there, and remarkably no conmbinatorics were involved at
#         all. Now I *really* wonder what the right way to do this is. Still no
#         internet so I'll just have to wait. I do like this freedom from
#         distraction though. It's the best. Must do this more often.

        
        
        
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use open ':std', ':encoding(UTF-8)';



my $n = shift @ARGV || 60;
my $sq = $n ** 2;
my @triples;
my @summands;

for my $t (1..$n) { 
    ## first we check table columns for summands 
    ## the column index is the "triangle length", $t, and the equations
    ## combine this with the index to produce the values
    my $idx = 0;
    my $start = ($t ** 2) + (2 * $t);           ## start index   
    ## triangle equation column-wise
    ## skipping by 2t from from start index
    ## if the target square is present get its index
    if ( ($sq - $start) % (2 * $t) == 0 ) {
        $idx = $t + 1 + (($sq - $start) / (2 * $t)); 
        my @triple = sort {$a<=>$b} ($idx, $n, $idx - $t);
        push @triples, \@triple if $idx > $t; 
    }
    ## then we check sum row for summands
    ## all the table fields follow an iterative pattern based off their
    ## index and the column position, the "triangle length" back to the
    ## 0-index and then up the same distance. 
    last if $t == $n;                           ## last column is at $n-1
    my $test = (2 * $t * $n) - ($t ** 2);       ## triangle equation
    if ( (int(sqrt($test)))**2 == $test ) {     ## perfect square test
        push @summands, sqrt $test;
    }
}
say "summands @summands";
push @triples, [shift @summands, pop @summands, $n] while @summands;

say sprintf "%4d² + %4d² = %d²", $_->@* for @triples;


