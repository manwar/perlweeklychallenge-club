#!/usr/env/perl
# Task 1 Challenge 054 Solution by saiftynet
# kth Permutation Sequence
# Write a script to accept two integers n (&gt;=1) and k (&gt;=1). 
# It should print the kth permutation of n integers. For more information, 
# please follow the wiki page.
# For example, n=3 and k=4, the possible permutation sequences are 
# listed below:
# 123,132,213,231,312,321 The script should print the 4th permutation 
# sequence 231.

# This is polymorphic solution
# KPermutation() can be called with the number of digits (N) from
# the task and an optional parameter.  If this parameter is omitted
# then all permutations are returned.  If the parameter is a
# single number then only that k'th permutation is returned.  If
# the parameter is a listref (e.g [1,5,7]) the permutations in
# those positions are returned.  The return value is in all cases a 
# list of arrayrefs 

print "\nGetting all permutations\n";
print join (" ",@$_), "\n" foreach kPermutation(3);
print "\nGetting kth permutation\n";
print join (" ",@$_), "\n" foreach kPermutation(3,4);
print "\nGetting selected permutations\n";
print join (" ",@$_), "\n" foreach kPermutation(3,[5,2,3]);

sub kPermutation{
   my $n=shift;
   our  $k=shift // "all";
   our  @list=(); 
   permute([1..$n], 0, $n-1);
   
   if (ref $k eq "ARRAY"){
	   @list=@list[@$k]
   }
    return @list;
    
# A recursive permutation function.
# takes an array ref, start for swap and end of swap
  sub permute {
    my ($str,$l,$r)=@_;
    my @perm=@$str;          # deref the passed array
    if (($l==$r) and ((ref $k) or ($k eq "all") or (--$k==0))) {
       push @list, [@perm];
      }  # base case, populates the entire list with permutations or just kth one
    else{  
       for my $idx ($l..$r){ 
          ($perm[$l], $perm[$idx])=($perm[$idx], $perm[$l]); # swap
           permute([@perm], $l+1, $r);                        # recurse
          ($perm[$l], $perm[$idx])=($perm[$idx], $perm[$l]); # backtrack
       }  
    }  
  }  
}



  


