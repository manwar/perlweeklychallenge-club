class IntStack {
    has Int @!store;

    method push(Int $n) {
        @!store.push($n);
    }
    method pop(--> Int) {
        @!store.pop;
    }
    method top(--> Int) {
        @!store.tail;
    }
    method min(--> Int) {
        @!store.min;
    }
}

sub MAIN {
    my $stack = IntStack.new;
    $stack.push(2);
    $stack.push(-1);
    $stack.push(0);
    $stack.pop;
    say $stack.top;
    $stack.push(0);
    say $stack.min;
}
