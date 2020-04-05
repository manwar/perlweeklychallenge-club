#!/usr/env/perl
# Task 2 Challenge 054 Solution by saiftynet
# Collatz Conjecture
# Contributed by Ryan ThompsonIt is thought that the following sequence 
# will always reach 1:
# $n =   $n / 2 when $n is even$n = 3*$n + 1 when $n is oddFor example, 
# if we start at 23, we get the following sequence:
# 23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 
# → 4 → 2 → 1
# Write a function that finds the Collatz sequence for any positive 
# integer. Notice how the sequence itself may go far above the original 
# starting number.
# Extra CreditHave your script calculate the sequence length for 
# all starting numbers up to 1000000 (1e6), and output the starting 
# number and sequence length for the longest 20 sequences.

# Collatx() returns the collatz sequence as an array
# top20Collatz([start],end) prints top 20 Collatz sequences found

my %next; # cache of next numbers in the Collatz sequence;
          # helps if look up quicker than the math

print join ("->",Collatz(837799) ), "\n\n\n";

top20Collatz(1000000);


sub top20Collatz{          # this uses pop instead of the usual "shift"
  my $end=pop;           # if one parameter is supplied it is used as the end
  my $start=pop // 1;    # if two are supplied, then they are start and end
  my @top20=();
  my $stopwatch=time();
  for ($start..$end){
     print "Calculating $_ \r";  # takes some time to work out 1000_000
		                 # gives visual feedback oc activity
     my @seq=Collatz($_);        # get the Collatz sequence
     # perl handily uses size of array if array is used in scalar context
     if ((@top20<20) or ( @seq > @{$top20[-1]})){ # will end in top 20
         unshift @top20,[@seq];                   # store the sequence
         @top20= sort { @$b <=> @$a } @top20;     # resort (reverse
         pop @top20 if  @top20>20;                # remove any surplus
     }
  }
  $stopwatch-=time();
  #  section that displays results
  my $count=1;
  print "Top 20 longest Collatz Sequences between $start and $end\n";
  foreach (@top20){
     printf "Rank: %3d  Number: %8d  Sequence Size: %4d\n",$count++, $$_[0], ,scalar @$_;
  }
  print "takes ".-$stopwatch." seconds" 
};

sub Collatz{
  my $n=shift;
  my @sequence;
  while ($n != 1){
    push @sequence,$n;
    $n = $n % 2 ? 3*$n + 1: $n / 2; # comment this line and uncomment the next two
                                    # to enable caching.  On my system, caching takes 
                                    # 50% longer
    # $next{$n} = $n %2 ? 3*$n + 1: $n / 2  unless defined $next{$n};;
    # $n=$next{$n};
  }
  return @sequence,1;
}
