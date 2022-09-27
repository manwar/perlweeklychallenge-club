#!/usr/bin/env perl6

#my @list=('a 1 2 b 0', '3 c 4 d');

# output: 

#[[1 2 0] [3 4]]
#[[a b] [c d]]

my @list=('1 2', 'p q r', 's 3', '4 5 t');

#[[1 2] [3] [4 5]]
#[[p q r] [s] [t]]


my (@numbers, @alphas);

for (@list) -> $string {
    my @inner_numbers=[]; 
    my @inner_alphas=[];
    for ($string.split(/\s+/)) -> $char {
        ($char ~~ /<[0..9]>/) && (push @inner_numbers, $char);
        ($char ~~ /<[a..z]>/) && (push @inner_alphas, $char);
    }
    (@inner_numbers.elems > 0) && (push @numbers, @inner_numbers);
    (@inner_alphas.elems > 0) && (push @alphas, @inner_alphas);
}

say @numbers;
say @alphas;

