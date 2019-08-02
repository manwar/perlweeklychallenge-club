# Perl Weekly Challenge - 012
# Challenge #2
#
# See
#     engineering.purdue.edu/~mark/pwc-012.pdf
# for more information.

# Run using Perl 6.
use v6;

# Define @path and $sep.
my Str @path = <</a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e>>;
my $sep = '/';

# Split @path into its separate parts and put
# the results in the two-dimensional @part array.
#          0    1    2    3     4    5
#     0         a    b    c     d
#     1         a    b    cd
#     2         a    b    cc
#     3         a    b    c     d    e
my @part;
for @path
{
    push @part, split(/$sep/, $_);
}

# Compute index of last directory part of @part with fewest number of parts.
my $lastindex = @part.map({.elems}).min - 2;

# Set $index to one past the last directory part that matched.
# Searh for unequal directory parts or ``fall out the bottom''
# of the loop if all directory parts match for this $index.
my $index = 0;
while ($index <= $lastindex  &&  [eq] @part[*;$index])
{
    $index++;
}

# Print the output.
say join '/', @part[0;^$index];
