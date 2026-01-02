#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given m x n matrix and an integer, $k > 0.

Write a script to shift the given matrix $k times.

Each shift follow the rules:

Rule 1:
Element at grid[i][j] moves to grid[i][j + 1]
This means every element moves one step to the right within its row.

Rule 2:
Element at grid[i][n - 1] moves to grid[i + 1][0]
This handles the last column: elements in the last column of row i wrap to the first column of the next row (i+1).

Rule 3:
Element at grid[m - 1][n - 1] moves to grid[0][0]
This is the bottom-right corner: it wraps to the top-left corner.

Example 1

Input: @matrix = ([1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9],)
       $k = 1
Output: ([9, 1, 2],
         [3, 4, 5],
         [6, 7, 8],)

Rule 1: grid[i][j] -> grid[i][j+1] for j < n-1.

We take elements from the original grid at (i, j) and put them into new_grid[i][j+1].

From original:

(0,0): 1 -> new_grid[0][1] = 1
(0,1): 2 -> new_grid[0][2] = 2
(1,0): 4 -> new_grid[1][1] = 4
(1,1): 5 -> new_grid[1][2] = 5
(2,0): 7 -> new_grid[2][1] = 7
(2,1): 8 -> new_grid[2][2] = 8

New grid looks after Rule 1:

([?, 1, 2],
 [?, 4, 5],
 [?, 7, 8],)

Rule 2: grid[i][n-1] -> grid[i+1][0] for i < m-1.

Elements from original last column (except last row) go to next row's first column.

From original:

(0,2): 3 -> new_grid[1][0] = 3
(1,2): 6 -> new_grid[2][0] = 6

Now new grid after Rules 1 + 2:

([?, 1, 2],
 [3, 4, 5],
 [6, 7, 8],)

Rule 3: grid[m-1][n-1] -> grid[0][0].

Original (2,2): 9 -> new_grid[0][0] = 9.

Now new_grid is complete:

([9, 1, 2],
 [3, 4, 5],
 [6, 7, 8],)


Example 2

Input: @matrix = ([10, 20],
                  [30, 40],)
       $k = 1
Output: ([40, 10],
         [20, 30],)

Rule 1 (move right in same row if not last column):

(0,0): 10 -> new[0][1] = 10
(1,0): 30 -> new[1][1] = 30

After Rule 1:

([?, 10],
 [?, 30],)

Rule 2 (last col -> next row’s first col, except last row):

(0,1): 20 -> new[1][0] = 20

After Rule 2:

([?,  10],
 [20, 30],)

Rule 3 (bottom-right to top-left):

(1,1): 40 -> new[0][0] = 40

After Rule 3:

([40, 10],
 [20, 30],)


Example 3

Input: @matrix = ([1, 2],
                  [3, 4],
                  [5, 6],)
      $k = 1
Output: ([6, 1],
         [2, 3],
         [4, 5],)

Rule 1:
(0,0): 1 -> new[0][1] = 1
(1,0): 3 -> new[1][1] = 3
(2,0): 5 -> new[2][1] = 5

After Rule 1:
( [?, 1],
  [?, 3],
  [?, 5],)

Rule 2:
(0,1): 2 -> new[1][0] = 2
(1,1): 4 -> new[2][0] = 4

After Rule 2:
([?, 1],
 [2, 3],
 [4, 5],)

Rule 3:
(2,1): 6 -> new[0][0] = 6

After Rule 3:
([6, 1],
 [2, 3],
 [4, 5],)


Example 4

Input: @matrix = ([1, 2, 3],
                  [4, 5, 6],)
       $k = 5
Output: ([2, 3, 4],
         [5, 6, 1],)

Shift 1

Rule 1
1 -> (0,1)
2 -> (0,2)
4 -> (1,1)
5 -> (1,2)

Rule 2
3 -> (1,0) (last column of row 0)

Rule 3
6 -> (0,0) (bottom-right corner)

Result
[6, 1, 2]
[3, 4, 5]

----------------------------

Shift 2

Starting from the previous matrix:

[6, 1, 2]
[3, 4, 5]

Rule 1
6 -> (0,1)
1 -> (0,2)
3 -> (1,1)
4 -> (1,2)

Rule 2
2 -> (1,0)

Rule 3
5 -> (0,0)

Result
[5, 6, 1]
[2, 3, 4]

----------------------------

Shift 3

[5, 6, 1]
[2, 3, 4]

Rule 2: 1 -> (1,0)
Rule 3: 4 -> (0,0)

Others follow Rule 1

Result
[4, 5, 6]
[1, 2, 3]

----------------------------

Shift 4

[4, 5, 6]
[1, 2, 3]

Result
[3, 4, 5]
[6, 1, 2]

----------------------------

Shift 5
[3, 4, 5]
[6, 1, 2]

Result
[2, 3, 4]
[5, 6, 1]

Final Output (after k = 5 shifts)
([2, 3, 4],
 [5, 6, 1])


Example 5

Input: @matrix = ([1, 2, 3, 4])
       $k = 1
Output: ([4, 1, 2, 3])

Rule 1:
(0,0): 1 -> new[0][1] = 1
(0,1): 2 -> new[0][2] = 2
(0,2): 3 -> new[0][3] = 3

After Rule 1:
([?, 1, 2, 3])

Rule 2:
(0,3): 4 -> new[1][0] ??

Wait — but i=0, n-1=3, next row i+1=1 doesn’t exist (m=1).
So this is actually a special case where Rule 2 should not apply.
because m=1, so (0,3) goes by Rule 3 actually.

The rules say:
grid[i][j]     -> grid[i][j+1] for j < n-1.
grid[i][n-1]   -> grid[i+1][0] for i < m-1.
grid[m-1][n-1] -> grid[0][0].

For m = 1:
Elements (0,0),(0,1),(0,2) follow Rule 1 -> (0,1),(0,2),(0,3).
Element (0,3) is (m-1, n-1), so follows Rule 3 -> (0,0).

Actually, that means after Rule 1:
We put 1,2,3 in positions 1,2,3, leaving position 0 empty.
Then Rule 3 puts 4 in position 0.

So final directly:
[4, 1, 2, 3]

=cut

use Test2::Bundle::More;

is_deeply(shift_grid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1),
     [[9, 1, 2], [3, 4, 5],[6, 7, 8]], 'Example 1');
is_deeply(shift_grid([[10, 20], [30, 40]], 1),
     [[40, 10], [20, 30]], 'Example 2');

is_deeply(shift_grid([[1, 2], [3, 4], [5, 6]], 1),
     [[6, 1], [2, 3], [4, 5]], 'Example 3');
is_deeply(shift_grid([[1, 2, 3], [4, 5, 6]], 5),
     [[2, 3, 4], [5, 6, 1]], 'Example 4');
is_deeply(shift_grid([[1, 2, 3, 4]], 1),
     [[4, 1, 2, 3]], 'Example 5');

     
done_testing();
     
sub shift_grid
{
     my ($aref, $n) = @_;
     for my $x ( 1 .. $n )
     {
          my @temp;
          $temp[0] = $aref->[-1][-1];
          for my $r_idx ( 0 .. $#$aref )
          {
               my @temp_row = @{$aref->[$r_idx]};
               $temp[$r_idx+1] = $aref->[$r_idx][-1];
               @{$aref->[$r_idx]}[1 .. $#temp_row] = 
                    @temp_row[0 .. $#temp_row - 1];
               $aref->[$r_idx][0] = $temp[$r_idx];
          }
     }
     return $aref;
}
