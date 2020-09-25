my $N = prompt 'Enter $N : ';

my $total_count_set_bit=0;
for 1..$N {$total_count_set_bit += [+] $_.base(2).comb};

print "The total number of set bits is : ";
say $total_count_set_bit % 1000000007;
