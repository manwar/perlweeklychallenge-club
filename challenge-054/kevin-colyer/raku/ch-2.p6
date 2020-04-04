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

my Int @cache;
my Int @length;
sub collatzSeqChain(Int $n is copy) {
    my Str $seq = "$n";
    while $n > 1 {
        if $n +& 1 == 0 {
            $n=Int($n / 2);
        } else {
            $n = $n * 3 + 1;
        }
        $seq ~= " -> $n";
    }
    return $seq;
}

sub collatzSeqLen(Int $number) {
    my Int $n=$number;
    my Int $len=1;
    my Str $seq = "$n";
    while $n > 1 {
        if @length[$n]:exists { $len += @length[$n]; last }
        if $n +& 1 == 0 {
            $n=Int($n / 2);
        } else {
            $n = $n * 3 + 1;
        }
        $len++;
    }
    @length[$number]=$len;
    return $len;
}

say collatzSeqChain(23);
say collatzSeqLen(2000);

my Int @chain=0;
my $want=20;
my $topMin=1;
my @top;
my @topN;
my %ltoi;
my $t =now.Int;
for 1..1_000_00 -> $i { 
    my $l=collatzSeqLen($i);
    
    next if $l < $topMin;
    next if  $l == any @top;
    
    %ltoi{$l}=$i;
    
    @top.push: $l;
    @top.=sort;
    @top.shift if @top.elems > $want;
    $topMin=@top[0];
}
say now -$t;
say @top.map: %ltoi{*};
# 
# for  @chain.reverse[1..20] -> $i {
#     my $n=@chain
# };
