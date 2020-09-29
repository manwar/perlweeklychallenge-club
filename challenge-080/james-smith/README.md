Solutions by James Smith.

# Challenge 1 - Smallest Positive Number

After testing three solutions:

  * using sort
  * using hash keys
  * scanning with the numbers 1, 2, 3 etc

it became obvious the best way of handling this is to sort the +ve numbers and them loop through them to find the first missing one (the first number which has the value in the array not equal to the 1-based index) was the quicksest...

# Challenge 2 - Count candies

This is a simple sweep approach applying the b) rule multiple times until the counting stops!

Note you have to do this repeatedly till you find the right answer - a single pass will not return the right value {especially in more complex environments}

