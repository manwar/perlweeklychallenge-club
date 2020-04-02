#!perl6
# Task 2 Challenge 054 Solution by kevincolyer
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

my @cache;
my @length;
sub collatz(Int $n) is pure {
#     return $n if $n==1;
    return @cache[$n] if @cache[$n]:exists;
    if $n +& 1 == 0 {
        @cache[$n]=Int($n / 2);
        return @cache[$n];
    };
    @cache[$n] = $n * 3 + 1;
    return @cache[$n];
}

sub collatzSeq(Int $number) {
    my Int $n=$number;
    my Int $len=0;
    my Str $seq = "$n";
    while $n > 1 {
        $n = collatz($n);
        $seq~= " -> $n";
    }
    return $seq;
}

say collatzSeq(23);
say collatzSeq(2000);

my $t =now.Int;
for 1..10000 -> $i { collatzSeq($i)}
say now -$t;
