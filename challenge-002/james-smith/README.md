Solution by James Smith

## Perl6 solution - currying

Just learning Perl 6 - so thought I'd look at some of the functionality.
This challenge just asked for the use of **currying** as base conversion (at least <= 36 is similar for all bases....)

> **Currying** is a technique to reduce the number of argument of a function by creating a wrapper function that substitutes some predefined values of the original function.

In this case we construct a function which convert functions which convert from decimal to an arbitrary base (<=36) and visa versa. In the code these are `to_base` and `from_base`. Which take two numbers the base (or radix) and the number/string to convert. To *golf* this challenge the code is written recursively.

To create the specific base35 functions (`to_35` and `fr_35`) we use `assuming` to curry these functions to the ones we want....

I've also included an arbitrary base conversion function which again can use currying (twice) to generate a specific converter - here I've created a `hx2b35` function.

### Notes

To be honest this is not the most efficient way of completing this challenge the performance of the curried functions is not that good in comparison to a hard coded version of to_base/from_base...


