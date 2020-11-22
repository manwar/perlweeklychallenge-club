use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @tests = ( [ 100, 4, 50, 3, 2 ],
              [ 20, 30, 10, 40, 50 ],
              [ 20, 19, 9, 11, 10 ]
            );

for my $t_ref (@tests) {
    my @in = sort { $a <=> $b } @$t_ref;
    my $last = $in[0];
    my @sequences;
    my $index = 0;
    push @{$sequences[$index]}, $last;
    for my $i (1..$#in) {
        my $current = $in[$i];
        $index++ if $current != $last + 1;
        push @{$sequences[$index]}, $current;
        $last = $current;
    }
    my @sorted_seq = sort { scalar @$b <=> scalar @$a } @sequences;
    if (scalar @{$sorted_seq[0]} > 1) {
        say "@{$sorted_seq[0]}";
    } else {
        say 0;
    }
}
