# Challenge 237 - Seize The Day and Maximise Greatness

## Seize The Day - Simple Rules The Day

My solution was based on using Time::Local to compute the epoch for noon
on the first day of the month, and then stepping forward by day until
the required day of week has been found, and then stepping forward by
week until the required repetition of that day has been found, or we ran
off the end of the calender month. Using noon instead of midnight is IMO
a prudent guard against issues related leap seconds, but probably isn't
really necessary but doesn't hurt either.

## Maximise Greatness - Permutation Misdirection

Task #2 is more difficult and IMO more interesting. The problem is
stated as the following: "Maximise Greatness: You are given an array of
integers. Write a script to permute the give[n] array such that you get
the maximum possible greatness. To determine greatness, [count pairs
that satisfy] nums[i] < perm[i] where 0 <= i < nums.length", and then
gives the example of

    Input: @nums = (1, 3, 5, 2, 1, 3, 1)
    Output: 4

    One possible permutation: (2, 5, 1, 3, 3, 1, 1)
    which returns 4 greatness as below:
    nums[0] < perm[0]
    nums[1] < perm[1]
    nums[3] < perm[3]
    nums[4] < perm[4]

I think this is a fun little problem and a good example of the kind of
problem that gets posed in the perl-weekly challenge. Simple input,
simple output, simple description, but a deeper problem than it might
seem at first blush.

The reason I say deeper is that way the problem is stated it makes it
seem like we need to compute a permutation, and that the solution to the
problem might be `O(N!)` or `O(N**2)`. But on closer inspection we can
see that we need not compute a permutation at all, and we only need to
do so if we want to visually debug that our answer is correct. It
actually turns out that all we need to do is find the count of the most
frequently occuring number in the array. The maximum greatness will be
the number of elements in the array minus the count of the most
frequently occuring element in the array.

A complete proof of this is a bit beyond this document. But we can get
the general idea by considering a sorted array. Lets say we have an
array with duplicates, such that `A[0] < A[1] < A[2] ... < A[n-1]`. It
is obvious that the maximum element in the array is the only one that
cannot be paired with something larger than it. We can view this as a
rotation of the array:

```
    | 1, 2, 3 |
    | 2, 3, 1 | <- rotate left by 1.
    | X  X    |  <- Which columns satisfy the constraint
```

In this case it is obvious that the maximum greatness is 1 less than
number of elements in the array, and 1 is the count of the most
frequently occuring element. If we then duplicate one of the elements
and we rotate the array by different numbers of elements we can see
maximum is the same regardless of which element is duplicated, and that
the rotating any more than the number of duplicates causes the number of
pairs that satisify the constraint to reduce.

```
    | 1, 1, 2, 3 | 1, 2, 2, 3 | 1, 2, 3, 3 |
    | 1, 2, 3, 1 | 2, 2, 3, 1 | 2, 3, 3, 1 | <- rotate 1
    | X  X       | X     X    | X  X       |

    | 1, 1, 2, 3 | 1, 2, 2, 3 | 1, 2, 3, 3 |
    | 2, 3, 1, 1 | 2, 3, 1, 2 | 3, 3, 1, 2 | <- rotate 2
    | X  X       | X  X       | X  X       |

    | 1, 1, 2, 3 | 1, 2, 2, 3 | 1, 2, 3, 3 |
    | 3, 1, 1, 2 | 3, 1, 2, 2 | 3, 1, 2, 3 | <- rotate 3
    | X          | X          | X          |
```

The same pattern holds if the array contains two sets of duplicated
numbers, the maximum number of pairs is found when the rotation matches
the count of the most frequently repeated element:

```
    | 1, 1, 2, 2, 3 | 1, 2, 2, 3, 3 | 1, 1, 2, 3, 3 |
    | 1, 2, 2, 3, 1 | 2, 2, 3, 3, 1 | 1, 2, 3, 3, 1 | <- rotate left by 1
      X  X          | X     X       |    X  X       |

    | 1, 1, 2, 2, 3 | 1, 2, 2, 3, 3 | 1, 1, 2, 3, 3 |
    | 2, 2, 3, 1, 1 | 2, 3, 3, 1, 2 | 2, 3, 3, 1, 1 | <- rotate left by 2
    | X  X  X       | X  X  X       | X  X  X       |

    | 1, 1, 2, 2, 3 | 1, 2, 2, 3, 3 | 1, 1, 2, 3, 3 |
    | 2, 3, 1, 1, 2 | 3, 3, 1, 2, 2 | 3, 3, 1, 1, 2 | <- rotate left by 3
    | X  X          | X  X          | X  X          |
```

And lastly consider what happens when we have 1 unique element, 1 pair,
and 1 triplicate:

```
    | 1, 2, 2, 3, 3, 3 | 1, 1, 2, 2, 2, 3 | 1, 1, 1, 2, 3, 3 |
    | 2, 2, 3, 3, 3, 1 | 1, 2, 2, 2, 3, 1 | 1, 1, 2, 3, 3, 1 | <- rotate 1
    | X     X          |    X        X    |       X  X       |

    | 1, 2, 2, 3, 3, 3 | 1, 1, 2, 2, 2, 3 | 1, 1, 1, 2, 3, 3 |
    | 2, 3, 3, 3, 1, 2 | 2, 2, 2, 3, 1, 1 | 1, 2, 3, 3, 1, 1 | <- rotate 2
    | X  X  X          | X  X     X       |    X  X  X       |

    | 1, 2, 2, 3, 3, 3 | 1, 1, 2, 2, 2, 3 | 1, 1, 1, 2, 3, 3 |
    | 3, 3, 3, 1, 2, 2 | 2, 2, 3, 1, 1, 2 | 2, 3, 3, 1, 1, 1 | <- rotate 3
    | X  X  X          | X  X  X          | X  X  X          |

    | 1, 2, 2, 3, 3, 3 | 1, 1, 2, 2, 2, 3 | 1, 1, 1, 2, 3, 3 |
    | 3, 3, 1, 2, 2, 3 | 2, 3, 1, 1, 2, 2 | 3, 3, 1, 1, 1, 2 | <- rotate 4
    | X  X             | X  X             | X  X             |
```

In each case we can see that the maximum greatness is determined only
by the number of elements in the array and the count of the most
frequent element. Note, that there may actually be two rotations of a
sorted array that produce the maximum greatness, that of the count of
the most frequent element, and that of the count of the second most
frequent element. If the counts differ then there will be two possible
rotations that give the maximum greatness.

The last point to observe is that if we **must** produce a permutation
that would produce the maximum greatness then we can produce an array
`S` of the indexes of the input array such that `A[S[i]] <= A[S[i+1]]`.
We can then solve for the sorted array by rotating it left by the count
of the most frequent element, and then use `S` to map the solution into
the appropriate order for the actual input array.

Thus if we are to compute the maximum greatness alone we can do so
in `O(N)` steps. If we are to produce a permutation of the input
array would produce that maximum greatness we can do so in
`O(N log2 N)` steps.
