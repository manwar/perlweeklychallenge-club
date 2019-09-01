#
# Perl  Weekly  Challenge  - 0233
# Task #1
#
# See
#      engineering.purdue.edu/~mark/blog/pwc -023 -1. pdf
# for  more  information.
#

# Run  using  Perl v6.d.
use v6.d;

# Get  command  line  arguments.
my$order = shift @*ARGS;
my @x = @*ARGS;

my$i = 1;
while   @x.elems > 1 &&$i  <=$order   {
    @x = @x [1..*]  <<->> @x [0..^* -1];
    say "order {$i++}: {@x}";
}
