Solution by Abigail

# Task 1: Count Number

You are given a positive number `$N`.

Write a script to count number and display as you read it.

### Example 1:

    Input: $N = 1122234
    Output: 21321314

as we read "two 1 three 2 one 3 one 4"

### Example 2:

    Input: $N = 2333445
    Output: 12332415

as we read "one 2 three 3 two 4 one 5"

### Example 3:

    Input: $N = 12345
    Output: 1112131415

as we read "one 1 one 2 one 3 one 4 one 5"

## Solutions
* [Perl](perl/ch-1.pl).


# Task 2: Jump Game

You are given an array of positive numbers @N, where value at each
index determines how far you are allowed to jump further.

Write a script to decide if you can jump to the last index. Print
1 if you are able to reach the last index otherwise 0.

### Example 1:

    Input: @N = (1, 2, 1, 2)
    Output: 1

as we jump one place from index 0 and then twoe places from index
1 to reach the last index.

### Example 2:

    Input: @N = (2,1,1,0,2)
    Output: 0

it is impossible to reach the last index. as we jump two places
from index 0 to reach index 2, followed by one place jump from index
2 to reach the index 3. once you reached the index 3, you can't go
any further because you can only jump 0 position further.

