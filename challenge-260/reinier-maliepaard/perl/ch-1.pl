sub unique_freq {

 $value_counts{$_}++ foreach (@_);
# exchange values and keys of the hash %value_counts, i.e. duplicate values will be reduced into one key
 %value_counts_rev = reverse(%value_counts);
# only success if the number of the old keys is equal to the number of the new keys
 ( keys(%value_counts) == keys(%value_counts_rev) ) ? 1 : 0;

};

@ints = qw(1 2 2 3 3 3 4 4 4 4);
print(unique_freq(@ints) . "\n"); # 1

@ints = qw(1 2 3);
print(unique_freq(@ints) . "\n"); # 0
