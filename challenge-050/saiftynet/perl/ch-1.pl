#!/usr/env/perl
# Task 1 Challenge 050 Solution by saiftynet
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
# [2,7], [3,9], [10,12], [15,19], [18,22]
# The script should merge [2, 7] and [3, 9] together to return [2, 
# 9].
# Similarly it should also merge [15, 19] and [18, 22] together 
# to return [15, 22].
# The final result should be something like below:
# [2, 9], [10, 12], [15, 22]

# 1st part generates random intervals. Intervals are pairs of numbers.
# $start is smaller than the $end. Because these are random, they are
# also unsorted unlike the example shown above
my @list=();
foreach (0..10){
    my $start=int(80*rand());
    my $end=$start+int(10*rand()+2);
    push @list,[$start,$end];
}

print "Before Merging:-\n",printall(@list), "\n"; # Prints the the initial list
@list=mergeIntervals(@list);                      # Merge the list
print "After Merging:-\n",printall(@list),"\n\n"; # Print the list post merger

# The mergeIntervals takes a list of intervals and merges where possible
sub mergeIntervals{
  my @toMerge=@_;
  @toMerge=sort {$$a[0]<=>$$b[0]} @toMerge;     # sort intervals on the intervals' start
    
  my $merges=1;                                 # ensure loop executes at least once
    while ($merges){                            # until no more merges
      my $pointer=$merges=0;                    # reset pointer and merges
      while ($pointer<@toMerge-1){              # check two adjacent intervals for merging
         splice @toMerge,$pointer,2,merge($toMerge[$pointer],$toMerge[$pointer+1]);
         $pointer++;                            # check next pair
      }
    }
  return @toMerge;
    
  sub merge{          # for sorted pair, pair will merge if start of second is
    my ($a,$b)=@_;    # less or equal to end of first. When a merge happens,
		              # start is the start of first, and end is the largest
		              # of either end
    return ([$$a[0], $$a[1]>$$b[1]?$$a[1]:$$b[1]])
         if  $$a[1]>=$$b[0] and $merges=1;   # a merge happens and is flagged
    return ($a,$b);                          # if not merged, returns the pair
  }
}

# printall prints the lists of intervals
sub printall{
  my $printOut="";
  $printOut.="[".$$_[0].",".$$_[1]."]," foreach(@_);
  return $printOut;
}

