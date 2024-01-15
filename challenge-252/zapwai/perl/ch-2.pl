use v5.30;
my $n = 5;
say "Input: \$n = $n";
print "Output: ";
if ($n == 1) {
    say "0";
} else {
    my @a;
    my $k = int $n/2;
    push @a, -1*$_, $_ for (1 .. $k);
    push @a, 0 if ($n % 2 == 1);
    @a = sort {$a <=> $b} @a;
    say "@a";
}