# Challenge # 236 Task 2, Array Loops
>
## Table of Contents
[Submitted By: Mark Anderson](#submitted-by-mark-anderson)  
[The Challenge You are given an array of unique integers.](#the-challenge-you-are-given-an-array-of-unique-integers)  
[Example 1](#example-1)  
[Example 2](#example-2)  
[Example 3](#example-3)  
[The Solution](#the-solution)  
[TITLE](#title)  
[VERSION](#version)  
[SYNOPSIS](#synopsis)  
[REQUIRED ARGUMENTS](#required-arguments)  
[OPTIONS](#options)  
[DESCRIPTION](#description)  
[DIAGNOSTICS](#diagnostics)  
[CONFIGURATION AND ENVIRONMENT](#configuration-and-environment)  
[DEPENDENCIES](#dependencies)  
[INCOMPATIBILITIES](#incompatibilities)  
[BUGS AND LIMITATIONS](#bugs-and-limitations)  
[AUTHOR](#author)  
[LICENCE AND COPYRIGHT](#licence-and-copyright)  

----
# Submitted By: Mark Anderson
# The Challenge You are given an array of unique integers.
Write a script to determine how many loops are in the given array.

> **To determine a loop: Start at an index and take the number at array[index] and then proceed to that index and continue this until you end up at the starting index.**  


## Example 1
```
Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
Output: 3

To determine the 1st loop, start at index 0, the number at that index is 4,
proceed to index 4, the number at that index is 15, proceed to index 15 and so
on until you're back at index 0.

Loops are as below:
[4 15 1 6 13 5 0]
[3 8 7 18 9 16 12 17 2]
[14 11 19 10]


```
## Example 2
```
Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
Output: 6

Loops are as below:
[0]
[1]
[13 9 14 17 18 15 5 8 2]
[7 11 4 6 10 16 3]
[12]
[19]

```
## Example 3
```
Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
Output: 1

Loop is as below:
[9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]

```
# The Solution




```
    3| multi MAIN ( ) {
    4|     ;
    5| } 

```




# TITLE
<application name> - <One line description of application's purpose>

# VERSION
This documentation refers to <application name> version 0.0.1

# SYNOPSIS
```
# Brief working invocation example(s) here showing the most common usage(s)

# This section will be as far as many users ever read
# so make it as educational and exemplary as possible.
```
# REQUIRED ARGUMENTS
A complete list of every argument that must appear on the command line. when the application is invoked, explaining what each of them does, any restrictions on where each one may appear (i.e. flags that must appear before or after filenames), and how the various arguments and options may interact (e.g. mutual exclusions, required combinations, etc.)

If all of the application's arguments are optional this section may be omitted entirely.

# OPTIONS
A complete list of every available option with which the application can be invoked, explaining what each does, and listing any restrictions, or interactions.

If the application has no options this section may be omitted entirely.

# DESCRIPTION
A full description of the application and its features. May include numerous subsections (i.e. =head2, =head3, etc.)

# DIAGNOSTICS
A list of every error and warning message that the application can generate (even the ones that will "never happen"), with a full explanation of each problem, one or more likely causes, and any suggested remedies. If the application generates exit status codes (e.g. under Unix) then list the exit status associated with each error.

# CONFIGURATION AND ENVIRONMENT
A full explanation of any configuration system(s) used by the application, including the names and locations of any configuration files, and the meaning of any environment variables or properties that can be set. These descriptions must also include details of any configuration language used

# DEPENDENCIES
A list of all the other modules that this module relies upon, including any restrictions on versions, and an indication whether these required modules are part of the standard Perl distribution, part of the module's distribution, or must be installed separately.

# INCOMPATIBILITIES
A list of any modules that this module cannot be used in conjunction with. This may be due to name conflicts in the interface, or competition for system or program resources, or due to internal limitations of Perl (for example, many modules that use source code filters are mutually incompatible).

# BUGS AND LIMITATIONS
A list of known problems with the module, together with some indication whether they are likely to be fixed in an upcoming release.

Also a list of restrictions on the features the module does provide: data types that cannot be handled, performance issues and the circumstances in which they may arise, practical limitations on the size of data sets, special cases that are not (yet) handled, etc.

The initial template usually just has:

There are no known bugs in this module.

# AUTHOR
Shimon Bollinger (deoac.shimon@gmail.com)

Source can be located at: https://github.com/deoac/... . Comments and Pull Requests are welcome.

# LICENCE AND COPYRIGHT
© 2023 Shimon Bollinger. All rights reserved.

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See [perlartistic](http://perldoc.perl.org/perlartistic.html).

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.





```
    6| multi MAIN (:$test!) {
    7|     use Test;
    8| 
    9|     my @tests = [
   10|         %{ got => '', op => 'eq', expected => '', desc => 'Example 1' },
   11|     ];
   12| 
   13|     for @tests {
   14|     } 
   15| } 
   16| 
   17| my %*SUB-MAIN-OPTS =
   18|   :named-anywhere,             
   19|   :bundling,                   
   20|   :allow-no,                   
   21|   :numeric-suffix-as-value,    
   22| ;
   23| 
   24| multi MAIN(Bool :$pod!) {
   25|     for $=pod -> $pod-item {
   26|         for $pod-item.contents -> $pod-block {
   27|             $pod-block.raku.say;
   28|         }
   29|     }
   30| } 
   31| 
   32| multi MAIN(Bool :$doc!, Str :$format = 'Text') {
   33|     run $*EXECUTABLE, "--doc=$format", $*PROGRAM;
   34| } 

```






----
Rendered from  at 2023-09-25T20:20:54Z
