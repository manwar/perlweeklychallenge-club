#!/usr/bin/env raku
multi days-together ( +@dr ) {
    [∩] @dr
    andthen .elems
}


multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply days-together((.clone(:12day) .. .clone(:20day)), (.clone(:15day) .. .clone(:18day))), 4 with Date.new: '1999-01-01';
    is-deeply days-together((.clone( :2day) .. .clone(:12day)), (.clone(:13day) .. .clone(:14day))), 0 with Date.new: '1999-03-01';
    is-deeply days-together((.clone( :2day) .. .clone(:12day)), (.clone(:11day) .. .clone(:15day))), 2 with Date.new: '1999-03-01';
    is-deeply days-together(
        (.clone(:30day) .. .clone(:5day:4month)),
        (.clone(:28day) .. .clone(:2day:4month))
    ), 4 with Date.new: '1999-03-01';
    done-testing;
}

multi MAIN (Date() $Foo-sd,Date() $Foo-ed, Date() $Bar-sd, Date() $Bar-ed) {
    say days-together $Foo-sd..$Foo-ed, $Bar-sd..$Bar-ed
}
