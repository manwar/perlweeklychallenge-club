#!/usr/bin/perl
use 5.030;
use warnings;
use List::Util qw/ shuffle /;

my @names1 = ('Mr. Wall',
             'Mrs. Wall',
             'Mr. Anwar',
             'Mrs. Anwar',
             'Mr. Conway',
             'Mr. Cross',
        );

my @names2 = ('Mr. Wall',
             'Mrs. Wall',
             'Mr. Anwar',
        );


sub secretSanta {
    my @names = @_;
    my %pairs;

    @names = shuffle(@names);
    if (scalar @names % 2) { # odd number of participants
        for my $i (0 .. scalar @names - 2) {
            $pairs{$names[$i]} = $names[$i + 1];
        }
        $pairs{$names[-1]} = $names[0];

    } else { # even number of participants
        while (scalar @names) {
            my ($title1, $surname1) = split q{ }, $names[0];
            my ($title2, $surname2) = split q{ }, $names[1];

            if ($surname1 eq $surname2) {
                @names = shuffle(@names);
            } else {
                $pairs{$names[0]} = $names[1];
                $pairs{$names[1]} = $names[0];
                splice @names, 0, 2;
            }
        }
    }

    return %pairs;
}

my %list1 = secretSanta(@names1);
while (my ($giver, $receiver) = each %list1) {
    say "$giver -> $receiver";
}

print "\n";

my %list2 = secretSanta(@names2);
while (my ($giver, $receiver) = each %list2) {
    say "$giver -> $receiver";
}
