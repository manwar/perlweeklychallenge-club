#!/usr/bin/env perl

use strict;
use warnings;


=head1 Context

This week for Task #2 we are using a minimalist, idiosyncratic Perl-ish approach
(which may, or may not be considered idiom).

For a Perl Pro this is probably a recognizable treatment of the problem.  If this is the
first time you've seen a Perl script, you'll probably get a headache.

First, we declare an array data structure named @sentences, where each
element in the array is a separate sentence from the examples in the task definition.

Instead of iterating over the array elements inside a { block } (a typical way),
we are placing the foreach iterator in the so-called post-fix location, after
our code statements.

Instead of explicitly declaring an iterator variable, we are using the default
Perl variable, "$_" (which I call dollar underscore) (also named "$ARGV").  "$_" can be thought of
as "It" (the thing that we are working on with our code statements).  NOTE: by default split(),
like many, many, Perl functions, uses the content of "$_", as its input,
even if we do not explicitly include "$_" inside the parentheses.
So the only place where we explicitly included "$_" in the single line of code is as one of the
targets of our print, so that the starting sentence gets displayed in the output.


Instead of using three separate statements, e.g.,

1. split this array element on one (or more) whitespace characters (and store it in a new array, right?),

2. sort the elements in the new array (using the custom sort ),

followed by

3. a print statement that uses a join(),

We are sorting the output of the split() manipulation in place, and immediately joining those sorted
elements back together for printing to STDOUT.

The rest is just pretty-printing (formatting), with a lot of backslashes to escape the double quotes I want,
and instead of using two sequential "print"s I combined them into a single one (there is an embedded newline
character so that the output for each example appears over two printed lines).


In summary, we have a list of different sentences.  We want to process the sentences in order,
one-by-one, and:

split the sentence on the whitespace between each word,
sort the words alphabetically,
join the sorted words back together,
print out the sorted version of the sentence


=cut


my @sentences = ( "The quick brown fox", "Hello    World!   How   are you?", "Hello", "Hello, World! How are you?", "I have 2 apples and 3 bananas!");

print "Input: \$str = \"", $_, "\"\n", "Output: \"", join(" ", sort { lc($a) cmp lc($b) } split(/\s+/)), "\"\n\n" foreach ( @sentences );

exit;

