#!/usr/env/perl
# Task 2 Challenge 059 Solution by saiftynet
# -1

# Bitsum- sum of bits that are different.  This is effectively and xor
# operation, followed by count of the bits that are 1.  One can convert 
# the yiled of the xor operation into a binar string (e.g. using
# sprintf "%b"), and counting the ones.  Getting the list context yield
# of a match operation, the reading that in scalar context gives us what
# we want.  A for loop that gets all possible pairs gives us a bit sum 
# of a list of numbers

print bitsum(2,3,4);
sub bitsum{
  my @list=@_;
  my $sum=0;                         # accumulator
  foreach my $m (0..@list-2){        # usual 2 fors to get
    foreach my $n ($m+1..$#list){    # all combinations           
     $sum    +=                      # get scalar
            ()=                      # cast intoa array
     (sprintf "%b", $list[$m]^$list[$n])# covert to binary
          =~m/1/g;                   # get matches
    }
  }
  return $sum;
}
