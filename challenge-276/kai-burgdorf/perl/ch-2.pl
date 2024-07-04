#!/usr/bin/perl

@ints = (1, 2, 2, 4, 1, 5);
#@ints = (1, 2, 3, 4, 5);

my %frequencies;
my $highest = 0;
my $total = 0;


foreach (@ints) {
  if (exists $frequencies{$_}) {
    $frequencies{$_}++;
  }
  else {
    $frequencies{$_} = 1;
  }
  if($frequencies{$_} > $highest) {
    $highest=$frequencies{$_};
  }
}

for(keys %frequencies){
  print("frequ for value $_ is $frequencies{$_}\n");
  if($frequencies{$_} == $highest) {
    $total += $frequencies{$_};
  }
}

print "\nhighest Frequency: $highest";
print "\nOutput: $total";
