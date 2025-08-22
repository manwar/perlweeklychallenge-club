#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 335-2,
written by Robbie Hatley on Mon Aug 18, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 335-2: Find Winner
Submitted by: Mohammad Sajid Anwar
You are given an array of all moves by the two players. Write a
script to find the winner of the TicTacToe game if found based
on the moves provided in the given array. Order move is in the
order - A, B, A, B, A, ….

Example 1
Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
Output: A
Game Board:
[ A _ _ ]
[ B A B ]
[ _ _ A ]

Example 2
Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
Output: B
Game Board:
[ A A B ]
[ A B _ ]
[ B _ _ ]

Example 3
Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
Output: Draw
Game Board:
[ A A B ]
[ B B A ]
[ A B A ]

Example 4
Input: @moves = ([0,0],[1,1])
Output: Pending
Game Board:
[ A _ _ ]
[ _ B _ ]
[ _ _ _ ]

Example 5
Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
Output: B
Game Board:
[ B B B ]
[ A A _ ]
[ _ _ A ]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

There are exactly 8 winning patterns in 3x3 TicTacToe, so finding if someone has won is just a matter of
checking the board for each of those 8 patterns, for A and B.

Any one given 3x3 grid is "invalid" if it contains any character other than "A", "B", or "_", or if the
number of "winning" patterns is other than 0 or 1.

Any one given 3x3 grid is "won" if exactly one winning pattern is present in either A or B.

Any one given 3x3 grid is "drawn" if every cell is either "A" or "B" and no winning pattern is present.

Any one given 3x3 grid is "pending" if at least one cell is "_" and no winning pattern is present.

So, I'll make a sub that checks for those 5 things and gives either "invalid", "A", "B", "drawn", or "pending"
as its output.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of x-y coordinates for cells of a 3x3 grid, in proper Perl syntax, like so:

./ch-2.pl '([],[])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # TicTacToe:
   sub tictactoe ($aref) {
      my @grid = (["_","_","_"],
                  ["_","_","_"],
                  ["_","_","_"]);
      my $idx = 0;
      foreach my $move (@$aref) {
         if (0!=$move->[0]&&1!=$move->[0]&&2!=$move->[0]) {return "invalid"}
         if (0!=$move->[1]&&1!=$move->[1]&&2!=$move->[1]) {return "invalid"}
         $grid[$move->[0]]->[$move->[1]] = ((0==$idx%2)?"A":"B");
         ++$idx}
      my @winners;
      # Check Pattern 1 of 8:
      if ("A" eq $grid[0]->[0] && "A" eq $grid[0]->[1] && "A" eq $grid[0]->[2]) {push @winners, "A"}
      if ("B" eq $grid[0]->[0] && "B" eq $grid[0]->[1] && "B" eq $grid[0]->[2]) {push @winners, "B"}
      # Check Pattern 2 of 8:
      if ("A" eq $grid[1]->[0] && "A" eq $grid[1]->[1] && "A" eq $grid[1]->[2]) {push @winners, "A"}
      if ("B" eq $grid[1]->[0] && "B" eq $grid[1]->[1] && "B" eq $grid[1]->[2]) {push @winners, "B"}
      # Check Pattern 3 of 8:
      if ("A" eq $grid[2]->[0] && "A" eq $grid[2]->[1] && "A" eq $grid[2]->[2]) {push @winners, "A"}
      if ("B" eq $grid[2]->[0] && "B" eq $grid[2]->[1] && "B" eq $grid[2]->[2]) {push @winners, "B"}
      # Check Pattern 4 of 8:
      if ("A" eq $grid[0]->[0] && "A" eq $grid[1]->[0] && "A" eq $grid[2]->[0]) {push @winners, "A"}
      if ("B" eq $grid[0]->[0] && "B" eq $grid[1]->[0] && "B" eq $grid[2]->[0]) {push @winners, "B"}
      # Check Pattern 5 of 8:
      if ("A" eq $grid[0]->[1] && "A" eq $grid[1]->[1] && "A" eq $grid[2]->[1]) {push @winners, "A"}
      if ("B" eq $grid[0]->[1] && "B" eq $grid[1]->[1] && "B" eq $grid[2]->[1]) {push @winners, "B"}
      # Check Pattern 6 of 8:
      if ("A" eq $grid[0]->[2] && "A" eq $grid[1]->[2] && "A" eq $grid[2]->[2]) {push @winners, "A"}
      if ("B" eq $grid[0]->[2] && "B" eq $grid[1]->[2] && "B" eq $grid[2]->[2]) {push @winners, "B"}
      # Check Pattern 7 of 8:
      if ("A" eq $grid[0]->[0] && "A" eq $grid[1]->[1] && "A" eq $grid[2]->[2]) {push @winners, "A"}
      if ("B" eq $grid[0]->[0] && "B" eq $grid[1]->[1] && "B" eq $grid[2]->[2]) {push @winners, "B"}
      # Check Pattern 8 of 8:
      if ("A" eq $grid[2]->[0] && "A" eq $grid[1]->[1] && "A" eq $grid[0]->[2]) {push @winners, "A"}
      if ("B" eq $grid[2]->[0] && "B" eq $grid[1]->[1] && "B" eq $grid[0]->[2]) {push @winners, "B"}
      # If we have MORE than one winner, grid is invalid:
      if (scalar(@winners) >1) {return "invalid"}
      # If we have EXACTLY one winner, return that:
      if (scalar(@winners)==1) {return $winners[0]}
      # If we get to here, we have no winners, so we're either drawn or pending:
      for    ( my $i = 0 ; $i < 3 ; ++$i ) {
         for ( my $j = 0 ; $j < 3 ; ++$j ) {
            if ("_" eq $grid[$i]->[$j]) {
               return "pending"}}}
      return "drawn"}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [[0,0],[2,0],[1,1],[2,1],[2,2]],
   # Expected output: A

   # Example 2 input:
   [[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]],
   # Expected output: B

   # Example 3 input:
   [[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]],
   # Expected output: Draw

   # Example 4 input:
   [[0,0],[1,1]],
   # Expected output: Pending

   # Example 5 input:
   [[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]],
   # Expected output: B
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @move_strings;
   for my $move (@$aref) {
      push @move_strings, "[@$move]"
   }
   say "Given these moves: (@move_strings)";
   my $outcome = tictactoe($aref);
   say "Winner is $outcome";
}
