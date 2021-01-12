#!raku


class SimpleStack {
    has Int @!elements;

    submethod BUILD {
        @!elements = Array.new;
    }

    method push( Int $n ) { @!elements.push: $n; }
    method pop()          {  @!elements[ @!elements.elems - 1 ]:delete; }
    method top()          { @!elements.reverse[ 0 ]; }
    method min()          { @!elements.min; }
    method print() { say $_ for @!elements.reverse;  }
}


sub MAIN() {
    my SimpleStack $stack = SimpleStack.new;
    $stack.push(2);
    $stack.push(-1);
    $stack.push(0);
    # the stack is now 0 -1 2
    # say "==================";
    # $stack.print;
    # say "Min { $stack.min } e top {$stack.top}";
#    say "==================";
    $stack.pop;       # removes 0
    # the stack is now -1 2
    say $stack.top; # prints -1
    # say "==================";
    # $stack.print;
    # say "Min { $stack.min } e top {$stack.top}";
    # say "==================";
    $stack.push(0);
    # the stack is now 0 -1 2
    say $stack.min; # prints -1
    # say "==================";
    # say $stack.print;
    # say "Min { $stack.min } e top {$stack.top}";
    # say "==================";
}
