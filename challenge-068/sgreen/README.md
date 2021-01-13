Solution by Simon Green

I've decided to jump the of Perl Weekly Challenge bandwagon. Seems like too much fun to miss out on :)

# TASK #1 › Zero Matrix

It wasn't clear on how the values of the matrix were to be supplied, so I assumed it was to be supplied in the program. It's been a long time since I needed to read from STDIN in Perl, nothing that a quick Internet search didn't solve. When processing the input, I strip all characters that aren't 0 or 1 so the user could specify `[1, 0, 1]` or `101` or even `1some0thing1`.

Once we had the values, there were a few ways this could be solved. It seemed the easiest way was to note all the columns and rows that had a zero value. When displaying the matrix, it would only show '1' if the value is one, and neither the column or row was marked as a negative value.

An alternate approach would be to do the calculations without using the negative columns and rows logic. This would however require more computation and require a bit more logic.

## Examples
    » ./ch-1.pl 3 3
    Enter values for row 1: [1, 0, 1]
    Enter values for row 2: [1, 1, 1]
    Enter values for row 3: [1, 1, 1]
    [ 0, 0, 0 ]
    [ 1, 0, 1 ]
    [ 1, 0, 1 ]

    » ./ch-1.pl 3 3
    Enter values for row 1: [1, 0, 1]
    Enter values for row 2: [1, 1, 1]
    Enter values for row 3: [1, 0, 1]
    [ 0, 0, 0 ]
    [ 1, 0, 1 ]
    [ 0, 0, 0 ]


# TASK #2 › Reorder List

This was definitely the easier of the two tasks. Essentially I caclulated the half value of the length of the array, and then used a loop to add the Xth element and Xth from the end element. If the list is an odd value, I added the middle value as that wouldn't have been added in the loop.

## Examples

    » ./ch-2.pl 1 2 3 4
    1 4 2 3

    » ./ch-2.pl 1 2 3 4 5
    1 5 2 4 3