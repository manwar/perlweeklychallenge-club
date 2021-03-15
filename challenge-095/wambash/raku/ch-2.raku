#!/usr/bin/env raku

class Stack {
    has @!stack handles (|<push pop min>, top => <tail>);
}

multi MAIN (Bool :$test! ) {
    use Test;
    with Stack.new {
        .push:  2;
        .push: -1;
        .push:  0;
        .pop;
        is .top, -1;
        .push:  0;
        is .min, -1;
    }
    done-testing;
}
