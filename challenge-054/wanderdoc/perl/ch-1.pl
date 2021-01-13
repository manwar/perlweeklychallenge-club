#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to accept two integers n (>=1) and k (>=1). It should print the kth permutation of n integers. For more information, please follow the wiki page.
For example, n=3 and k=4, the possible permutation sequences are listed below:

123 132 213 231 312 321
The script should print the 4th permutation sequence 231.
=cut





use Algorithm::Combinatorics qw(permutations);
use Getopt::Std;

my %options=();
getopts("n:k:", \%options);
die "Usage: <script> -n <integer upper limit> -k <which permutation>\n" 
     unless (defined $options{n} and defined $options{k} );
die "Wrong upper limit!\n" 
     unless ($options{n} > 0 and $options{n} = int($options{n}));

die "Wrong number of permutation!\n" 
     unless ($options{k} > 0 and $options{k} = int($options{k}));

my $iter = permutations([1 .. $options{n}]);
my $counter = 0;
while (my $c = $iter->next)
{

     $counter++;
     if ( $counter == $options{k} )
     {
          print join(' ', @$c), $/;
          last;
     }
}
print "Do not have so many permutations.\n" if $counter < $options{k};