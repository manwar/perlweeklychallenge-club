#!/usr/bin/perl
# The Weekly Challenge 167
# Task 1 Circular Prime

# Array @c_prime Indexing following OEIS:A068652; 
#    thus set $c_prime[0] as -1
use v5.24.0;
use warnings;
use List::Util qw/min reduce pairmap any all/;



my @c_prime = ("-1", 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97);
my @circular_prime = (2, 3, 5, 7, 11, 13, 17, 37, 79);

my $num = 10 + scalar @circular_prime;



while ( scalar @circular_prime < $num ) {
    my $candidate = reduce {$a . $b} my_permute();

    if (prime_test($candidate)) {
        my $younger_self = min_self($candidate);
        if ($younger_self != $candidate) {
            push @c_prime, $candidate
                if any {$_ == $younger_self} @circular_prime; 
        }
        elsif (all { prime_test($_) } cyclic($candidate)->@*) {
            push @c_prime, $candidate;
            push @circular_prime, $candidate;
        }
    }
}



sub my_permute {

    state $permuted = 1;
    state $len = 3;
    state $ordered = 0;

    my @digits = (1, 3, 7, 9);
    my @a_base4num;

    my $bin = sprintf("%b", $ordered);
    # generate bit string here
    $bin = ( "0" x ($len*2 - length $bin) ) . $bin;
    # convert bit string to base-4 integer representation
    @a_base4num = pairmap { $a*2 + $b } split("", $bin);

    $permuted = join "", map { $digits[$_] }  @a_base4num;

    if ($permuted =~ /^9+$/) {
        $len++;
        $ordered = 0;
    }
    else {
        $ordered++;
    }

    return $permuted;
}



sub prime_test {
    my $n = $_[0];
    return 0 if $n % 3 == 0;
    my $k = 1;
    while ( 6*$k <= sqrt($n) ) {
        return 0 if $n % (6*$k-1) == 0;
        return 0 if $n % (6*$k+1) == 0;
        $k++;
    }
    return 1;
}



sub cyclic {
    my $w = $_[0];
    my $ans = [$w];
    my @arr = split "", $w;
    for (1..(length $w) - 1) {
        push $ans->@*, substr($w, $_). substr($w, 0, $_)
    }
    return $ans;
}



sub min_self {
    return min(cyclic($_[0])->@*);
}




use Test::More tests => 2;
my $task_requirement = join ", ", @circular_prime[9..9+9];
ok 
    $task_requirement eq
      "113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933";
ok $c_prime[30] == 7793;
