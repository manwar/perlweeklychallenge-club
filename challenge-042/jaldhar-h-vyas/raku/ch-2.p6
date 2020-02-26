#!/usr/bin/perl6

sub isBalanced(@brackets) {
    my @stack;

    (0 ..^ @brackets.elems).map({
        if @brackets[$_] ~~ '(' {
            @stack.push( '(' );
        } else {
            if !@stack.elems {
                return False;
            }
            @stack.pop;
        }
    });

    return @stack.elems == 0;
}
    
multi sub MAIN() {
    my @brackets;

    for 1 .. (2, 4, 6).pick {
        @brackets.push(Bool.pick ?? '(' !! ')');
    }

    say @brackets.join, ' - ', (isBalanced(@brackets) ?? q{} !! 'NOT '), 'OK';
}
