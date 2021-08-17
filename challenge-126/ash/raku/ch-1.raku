sub count($n) {
    my @items = (2..$n).grep: * !~~ /1/;
    if @items {
        if @items.elems == 1 {
            say "There is 1 number between 1 and $n that doesn't contain digit 1.";
        }
        else {
            say "There are {+@items} numbers between 1 and $n that don't contain digit 1.";
        }

        say @items.join(', ') ~ '.';
    }
    else {
        say "There are no numbers between 1 and $n that contain no digit 1.";
    }
}

.&count for 5, 15, 25;
