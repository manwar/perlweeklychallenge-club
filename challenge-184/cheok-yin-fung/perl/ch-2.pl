# The Weekly Challenge 184
# Task 2 Split Array
use v5.30.0;
use warnings;

sub split_arr {
    my @arr = $_[0]->@*;
    my @numeric;
    my @alphabets;
    for (@arr) {
        my @_numeric;
        my @_alphabets;
        my @chars = split " ", $_;
        for (@chars) {
            push @_numeric, $_ if $_ =~ /\d/;
            push @_alphabets, $_ if $_ =~ /[a-z]/;
        }
        push @numeric, [@_numeric] if scalar @_numeric != 0;
        push @alphabets, [@_alphabets] if scalar @_alphabets != 0;
    }
    return [ [@numeric], [@alphabets] ];
}



use Test::More;
use Test::Deep;

cmp_deeply(split_arr(['a 1 2 b 0', '3 c 4 d']), 
           [ [[1,2,0], [3,4]] , [['a','b'], ['c','d']] ]);
cmp_deeply(split_arr(['1 2', 'p q r', 's 3', '4 5 t']), 
           [ [[1,2], [3], [4,5]] , [['p','q','r'], ['s'], ['t']] ]);
done_testing();

