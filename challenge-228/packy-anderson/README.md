# Solutions by Packy Anderson

## Perl

* [Task 1](perl/task-1.pl)

Sample output
```
$ perl/task-1.pl 2 1 3 2
Input: @int = (2, 1, 3, 2)
Output: 4

In the given array we have 2 unique elements (1, 3).

$ perl/task-1.pl 1 1 1 1
Input: @int = (1, 1, 1, 1)
Output: 0

In the given array no unique element found.

$ perl/task-1.pl 2 1 3 4
Input: @int = (2, 1, 3, 4)
Output: 10

In the given array every element is unique.
```
* [Task 2](perl/task-2.pl)

Sample output
```
$ perl/task-2.pl 3 4 2
Input: @int = (3, 4, 2)
Output: 5

Operation 1: move 3 to the end: (4,2,3)
Operation 2: move 4 to the end: (2,3,4)
Operation 3: remove element 2: (3,4)
Operation 4: remove element 3: (4)
Operation 5: remove element 4: ()

$ perl/task-2.pl 1 2 3
Input: @int = (1, 2, 3)
Output: 3

Operation 1: remove element 1: (2,3)
Operation 2: remove element 2: (3)
Operation 3: remove element 3: ()
```

## Raku

* [Task 1](raku/task-1.raku)

Sample output
```
$ raku/task-1.raku 2 1 3 2
Input: @int = (2, 1, 3, 2)
Output: 4

In the given array we have 2 unique elements (1, 3).

$ raku/task-1.raku 1 1 1 1
Input: @int = (1, 1, 1, 1)
Output: 0

In the given array no unique element found.

$ raku/task-1.raku 2 1 3 4
Input: @int = (2, 1, 3, 4)
Output: 10

In the given array every element is unique.
```

* [Task 2](raku/task-2.raku)

Sample output
```
$ raku/task-2.raku 3 4 2
Input: @int = (3, 4, 2)
Output: 5

Operation 1: move 3 to the end: (4, 2, 3)
Operation 2: move 4 to the end: (2, 3, 4)
Operation 3: remove element 2: (3, 4)
Operation 4: remove element 3: (4)
Operation 5: remove element 4: ()

$ raku/task-2.raku 1 2 3
Input: @int = (1, 2, 3)
Output: 3

Operation 1: remove element 1: (2, 3)
Operation 2: remove element 2: (3)
Operation 3: remove element 3: ()
```

## Blog Post

[Perl Weekly Challenge 228]()