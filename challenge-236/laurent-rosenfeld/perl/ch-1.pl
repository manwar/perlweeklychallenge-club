use strict;
use warnings;
use feature 'say';

sub sell_juice {
    # %change stores the stock of bank notes. No need to
    # count $20 notes but it makes the code more generic
    my %change = ('5' => 0, '10' => 0, '20' => 0);
    for my $i (@_){
        $change{$i}++;
        next if $i == 5;
        if ($i == 10) {
            return "false" if $change{5} < 1;
            $change{5}--;
            next;
        } elsif ($i == 20) {
            if ($change{10} > 0 and $change{5} > 0) {
                $change{10}--; $change{5}--;
                next;
            } elsif ($change{5} >= 3) {
                $change{5} -= 3; next;
            } else {
                return "false";
            }
        }
    }
    return "true";
}

my @tests = ([<5 5 5 10 20>], [<5 5 10 10 20>], [<5 5 5 20>]);
for my $test (@tests) {
    printf "%-15s => ", "@$test";
    say sell_juice @$test;
}
