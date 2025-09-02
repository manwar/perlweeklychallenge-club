# Perl Weekly Challenge 336

## Task 1: Equal Group

You are given an array of integers. Write a script to return true if the given array can be divided into one or more groups. Each group must be of the same size as the others, with at least two members, and all members within a group must have the same value.

### Perl Solution (`ch-1.pl`)

The Perl solution for Task 1, `ch-1.pl`, determines if an array of integers can be divided into equal groups. It first counts the frequency of each number in the input array. It then checks if all frequencies are at least 2. Finally, it calculates the greatest common divisor (GCD) of all frequencies. If the GCD is 2 or greater, it returns true, indicating that the array can be divided into groups of that size.

### Python Solution (`ch-1.py`)

The Python solution for Task 1, `ch-1.py`, mirrors the logic of its Perl counterpart. It uses `collections.Counter` to efficiently count element frequencies. Similar to the Perl solution, it ensures all frequencies are at least 2 and then computes the GCD of these frequencies using `math.gcd`. The function returns true if the calculated GCD is 2 or greater.

## Task 2: Final Score

You are given an array of scores by a team. Write a script to find the total score of the given team. The score can be any integer, '+', 'C', or 'D'. The '+' adds the sum of the previous two scores. The 'C' invalidates the previous score. The 'D' will double the previous score.

### Perl Solution (`ch-2.pl`)

The Perl solution for Task 2, `ch-2.pl`, calculates the final score based on a series of operations. It processes the input scores using a stack-like approach. Integers are pushed onto the stack. 'C' pops the last score, 'D' doubles the last score and pushes it, and '+' adds the last two scores and pushes the sum. The final total is the sum of all elements remaining in the stack.

### Python Solution (`ch-2.py`)

The Python solution for Task 2, `ch-2.py`, implements the same stack-based logic as the Perl version to calculate the final score. It iterates through the list of scores, performing operations based on the score type: appending integers, popping for 'C', doubling and appending for 'D', and summing the last two elements for '+'. The sum of the elements in the stack at the end represents the total score.
