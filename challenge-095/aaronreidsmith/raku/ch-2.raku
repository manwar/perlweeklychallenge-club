#!/usr/bin/env raku

class Stack {
    has @!internal-state of Int;

    method push(Int $elem --> True) {
        @!internal-state.push($elem);
    }

    method pop() returns Int {
        if @!internal-state.elems == 0 {
            warn "Cannot pop an empty stack!";
        } else {
            @!internal-state.pop;
        }
    }

    method top returns Int {
        if @!internal-state.elems == 0 {
            warn "Cannot find top of empty stack!";
        } else {
            @!internal-state.tail;
        }
    }

    method min returns Int {
        if @!internal-state.elems == 0 {
            warn "Cannot find minimum of empty stack!";
        } else {
            @!internal-state.min;
        }
    }

    method Str returns Str {
        "({@!internal-state.join(', ')}) <-- Top";
    }
}

sub MAIN(*@push where all(@push) ~~ Int, Int :$pop = 2) {
     # Can't put a default on "slurpy" args, so this is our work around
    @push = @push.elems > 0 ?? @push !! (1, 2, 3, 4);

    my $stack = Stack.new;
    for @push -> $elem {
        $stack.push($elem);
    }
    say "     Stack after pushing: $stack";
    for ^$pop {
        $stack.pop();
    }
    say "     Stack after popping: $stack";
    say "    Top element of stack: {$stack.top}";
    say "Minimum element of stack: {$stack.min}";
}
