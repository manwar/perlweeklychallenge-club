# Challenge # 236 Task 1, Exact Change
>
## Table of Contents
[Submitted by: Mohammad S Anwar](#submitted-by-mohammad-s-anwar)  
[The Challenge](#the-challenge)  
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
# Submitted by: Mohammad S Anwar
# The Challenge
You are asked to sell juice each costs $5. You are given an array of bills. You can only sell ONE juice to each customer but make sure you return exact change back. You only have $5, $10 and $20 notes. You do not have any change in hand at first.

Write a script to find out if it is possible to sell to each customers with correct change.

## Example 1
```
Input: @bills = (5, 5, 5, 10, 20)
Output: true

From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.

```
## Example 2
```
Input: @bills = (5, 5, 10, 10, 20)
Output: false

From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bill.
For the last customer, we can not give the change of $15 back because we only have two $10 bills.
Since not every customer received the correct change, the answer is false.


```
## Example 3
```
Input: @bills = (5, 5, 5, 20)
Output: true


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
Rendered from  at 2023-09-25T20:12:20Z
