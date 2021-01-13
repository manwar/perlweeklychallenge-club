#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
There are 50 people standing in a circle in position 1 to 50. The person standing at position 1 has a sword. He kills the next person i.e. standing at position 2 and pass on the sword to the immediate next i.e. person standing at position 3. Now the person at position 3 does the same and it goes on until only one survives.
Write a script to find out the survivor.
=cut

=notes
This is a special case of the Josephus problem. I already had an array solution for it (rotate per modulo and shift in a loop). The recent solution preserves the initial structure and modifies the elements only. At the same time I tried to make it general (for the different numbers). The 1-indexed data structure is assumed so there would be off by one differences with the 0-indexed solutions.
=cut

use Getopt::Long; 
use List::Util qw(first);

my %par = (h => 50, w => 2, s => 1);

GetOptions( "howmany|h=i"   => \$par{h}, 
              "which|w=i"   => \$par{w}, 
           "survived|s=i"   => \$par{s}) 
or die("Error in command line!\n");
die "All numbers must be positive!$/" if defined first { $_ <= 0 } values %par;



my $people = '';
vec($people, $_, 1) = 1 for 1 .. $par{h};
my $sword = 1; # 1-indexed by specification.
while ( unpack ('%32b*', $people) > $par{s} )
{
     my $counter = 0;
     while ( $counter < $par{w} - 1 )
     {
          $sword++; 
          rotate(\$sword);
          $counter++ if  1 == vec($people, $sword, 1);
     }


     vec($people, $sword, 1) = 0; 
     print $sword, ' '; # To comment out on big numbers!
     $sword++ and rotate(\$sword) while ( 0 == vec($people, $sword, 1) );
}

my @survived = grep 1 == vec($people, $_, 1), 1 .. $par{h};
print "$/Survived: ", join(" ", @survived), $/;


sub rotate
{
     ${$_[0]} %= $par{h} if ( ${$_[0]} > $par{h} );
}

# With -h 23482 -w 3343 -s 3: 1088 1336 13318 (s. jq on Rosetta).
# Comment out printing the sequence before running!