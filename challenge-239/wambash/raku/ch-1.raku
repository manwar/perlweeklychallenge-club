#!/usr/bin/env raku

sub same-string (\arr1,\arr2) {
    arr1.join eq arr2.join
}

multi MAIN (Bool :test($)!) {
    use Test;
    is same-string(<ab c>, <a bc>), True;
    is same-string(<ab c>, <ac b>), False;
    is same-string(<ab cd e>, 'abcde'), True;
    done-testing;
}

    multi MAIN (:@arr1,:@arr2) {
        say same-string @arr1,@arr2
}
