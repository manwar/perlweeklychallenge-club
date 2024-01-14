#!/usr/bin/raku

my @names1 = (
    'Mr. Wall',
    'Mrs. Wall',
    'Mr. Anwar',
    'Mrs. Anwar',
    'Mr. Conway',
    'Mr. Cross',
);

my @names2 = (
    'Mr. Wall',
    'Mrs. Wall',
    'Mr. Anwar',
);


sub secretSanta(@list) {
    my %pairs;

    my @names = @list.pick(*);
    if @names.elems % 2 { # odd number of participants
        for 0 .. @names.elems - 2 -> $i {
            %pairs{@names[$i]} = @names[$i + 1];
        }
        %pairs{@names[*-1]} = @names[0];

    } else { # even number of participants
        while @names.elems {
            my ($, $surname1) = @names[0].words;
            my ($, $surname2) = @names[1].words;

            if $surname1 eq $surname2 {
                @names = @names.pick(*);
            } else {
                %pairs{@names[0]} = @names[1];
                %pairs{@names[1]} = @names[0];
                splice @names, 0, 2;
            }
        }
    }

    return %pairs;
}


sub MAIN(

) {
    my %list1 = secretSanta(@names1.List);
    for %list1.pairs -> $p {
        say $p.key, ' -> ', $p.value;
    }

    print "\n";

    my %list2 = secretSanta(@names2.List);
    for %list2.pairs -> $p {
        say $p.key, ' -> ', $p.value;
    }

}