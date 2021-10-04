#!/usr/bin/perl
# The Weekly Challenge 133
# Task 2: Find the first 10 base-10 Smith number
# an example from Wikipedia: 4937775 = 3^1 5^2 658371
use v5.12.0;
use warnings;
use List::Util qw/sum/;

my $max_search = $ARGV[0] || 999;
my $num_of_smiths = $ARGV[1] || 10;

my @smiths = ();

my @primes = (2, 3, 5, 7);
my $num_of_primes = scalar @primes;

my %primedigitsum = ( 2 => 2, 3 => 3, 5=>5 , 7=>7 );

generate_primes();
generate_smiths();

if (scalar @smiths >= $num_of_smiths) {
    say "done";
    say join "\n", @smiths[0..$num_of_smiths-1];
}
else {
    say join "\n", @smiths;
}



sub arr_digitsum {
    my @arr = $_[0]->@*;
    return sum(
        map { $primedigitsum{$_} || digitsum($_) } @arr
    );
}



sub digitsum {
    return sum split //, $_[0]
}



sub generate_primes {
    my $i = 7;
    LOOP: while ($i <= $max_search-2 ) {
        $i += 2;
        my $k = 1;
        while ($k < $num_of_primes) {
            next LOOP if $i % $primes[$k] == 0;
            $k++;
        }
        push @primes, $i;
        $primedigitsum{$i} = digitsum $i;
        $num_of_primes++;
    }
}



sub factorize {
    my $n = $_[0];
    my @pf = ();
    my $k = 0;
    while ($n != 1) {
        if ($n % $primes[$k] == 0) {
            push @pf, $primes[$k];
            $n /= $primes[$k];
        }
        else {
            $k++;
        }
    }
    return [@pf];
}



sub generate_smiths {
    my $i = 4;
    while ($i <= $max_search) {
        if (    !defined($primedigitsum{$i}) 
             && digitsum($i) == arr_digitsum(factorize($i))
           ) {
            push @smiths, $i;
        }
        $i++;
    }
}

