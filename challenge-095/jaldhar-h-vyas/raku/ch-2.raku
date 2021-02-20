#!/usr/bin/raku

class Data::Stack {

    has Int @!stack = ();

    method push(Any $n) {
        @!stack.push($n);
    }

    method pop() {
        return @!stack.pop;
    }

    method top() {
        return @!stack.tail;
    }

    method min() {
        return @!stack.min;
    }
}

# some random operations
sub MAIN() {

    my $stack = Data::Stack.new;
    $stack.push(2);
    $stack.push(-1);
    $stack.push(0);
    $stack.pop;         # removes 0
    say $stack.top();   # prints -1
    $stack.push(0);
    say $stack.min;     # prints -1
}
