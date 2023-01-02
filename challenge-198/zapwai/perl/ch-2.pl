my $n = $ARGV[0] || 10;
my @cnt = grep { $_ == 1 } map { 1 if &is_prime } (2 .. $n);
print "Input: \$n = $n\nOutput: ".($#cnt + 1)."\n";
sub is_prime { for my $i (2 .. sqrt($_)) { return 0 if ($_ % $i == 0) } 1}
