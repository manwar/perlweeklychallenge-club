sub count($n) {
    my @items = (2..$n).grep: * !~~ /1/;
    given @items.elems {
        when 0 {
            say "There are no numbers up to $n that contain no digit 1.";
        }
        when 1 {
            say "There is 1 number between 1 and $n that doesn't contain digit 1.";
        }
        default {
            say "There are {+@items} numbers between 1 and $n that don't contain digit 1.";
        }
    }

    say @items.join(', ') ~ '.' if @items;
}

.&count for 1, 2, 5, 15, 25;
