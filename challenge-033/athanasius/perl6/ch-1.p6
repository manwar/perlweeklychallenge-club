use v6;

################################################################################
=begin comment

Perl Weekly Challenge 033
=========================

Task #1
-------
*Count Letters (A..Z)*

Create a script that accepts one or more files specified on the command-line and
count the number of times letters appeared in the files.

So with the following input file sample.txt

  The quick brown fox jumps over the lazy dog.

the script would display something like:

a: 1
b: 1
c: 1
d: 1
e: 3
f: 1
g: 1
h: 2
i: 1
j: 1
k: 1
l: 1
m: 1
n: 1
o: 4
p: 1
q: 1
r: 2
s: 1
t: 2
u: 2
v: 1
w: 1
x: 1
y: 1
z: 1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

BEGIN say '';

#===============================================================================
sub MAIN
(
    Bool:D :$count = False,         #= Order by letter counts (highest first)
    Bool:D :$help  = False,         #= Print usage details and exit
           *@filenames,             #= Name(s) of file(s) containing text data
)
#===============================================================================
{
    if $help || @filenames.elems == 0
    {
        $*USAGE.say;
    }
    else
    {
        my UInt %counts;

        for @filenames -> Str $filename
        {
            for $filename.IO.lines -> Str $line
            {
                ++%counts{ .lc } for $line.split('').grep({ rx:i/ <[a..z]> / });
            }
        }

        my &sort-by = $count ?? sub { %counts{ $^b } <=> %counts{ $^a } ||
                                       $^a cmp $^b }
                             !! sub {  $^a cmp $^b };

        "%s: %d\n".printf: $_, %counts{ $_ } for %counts.keys.sort: &sort-by;
    }
}

################################################################################
