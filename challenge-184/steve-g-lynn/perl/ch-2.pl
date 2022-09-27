#!/usr/bin/env perl

my @list=('a 1 2 b 0', '3 c 4 d');

# output: 

#[ [1 2 0] [3 4] ]
#[ [a b] [c d] ]

#my @list=('1 2', 'p q r', 's 3', '4 5 t');

#[ [1 2] [3] [4 5] ]
#[ [p q r] [s] [t] ]


my (@numbers, @alphas);

for my $string (@list) {
    my $ra_numbers=[]; 
    my $ra_alphas=[];
    for my $char (split /\s+/, $string) {
        ($char =~ /[0-9]/) && (push @$ra_numbers, $char);
        ($char =~ /[a-z]/) && (push @$ra_alphas, $char);
    }
    (@$ra_numbers > 0) && (push @numbers, $ra_numbers);
    (@$ra_alphas > 0) && (push @alphas, $ra_alphas);
}

print "[ ";
for my $ra_numbers (@numbers) {
    print "[@$ra_numbers] ";
}
print "]\n";

print "[ ";
for my $ra_alphas (@alphas) {
    print "[@$ra_alphas] ";
}
print "]\n";

