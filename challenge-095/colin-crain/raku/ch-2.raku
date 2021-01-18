#!/usr/bin/env perl6
#
#
#       jenga.raku
#
#
#
#       © 2021 colin crain
#
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


unit sub MAIN () ;

class Node {
    has Any  $.value is rw;
    has Node $.down  is rw;
}

class Stack {
    has Node $.last is rw;

    method push ( $value ) {
        my $node = Node.new( value => $value,
                              down => $.last  );
        $.last = $node;
        $.show_stack("method 'push $value'");
    }

    method pop () {
        return Nil if not defined $.last;
        my $value = $.last.value;
        $.last = $.last.down;
        $.show_stack("method 'pop'");
        return $value;
    }

    method top () {
        $.show_stack("method 'top'");
        return $.last.value;
    }

    method min () {
        return Nil if not defined $.last;
        my $node = $.last;
        my $min  = $node.value;
        while defined $node.down {
            $min  = min( $min, $node.down.value );
            $node = $node.down;
        }
        $.show_stack("method 'min'");
        return $min;
    }

    method max () {
        return Nil if not defined $.last;
        my $node = $.last;
        my $max  = $node.value;
        while defined $node.down {
            $max  = max( $max, $node.down.value );
            $node = $node.down;
        }
        $.show_stack("method 'max'");
        return $max;
    }


    method show_stack ($note?) {
        return Nil if not defined $.last;
        my $node = $.last;
        my @s = $node.value if defined $node;
        while defined  $node.down {
            @s.append: $node.down.value;
            $node = $node.down;
        }
        say '';
        say $note;
        say "stack now:          ", @s.fmt("%3d", '  → ');
    }
}

my $stack = Stack.new;

$stack.push(  2 );
$stack.push( -1 );
$stack.push(  0 );

say "returns: ", $stack.pop;            # removes  0
say "returns: ", $stack.top;            # returns -1

$stack.push(  0 );

say "returns: ", $stack.min;            # returns -1
say "returns: ", $stack.pop;            # removes  0
say "returns: ", $stack.pop;            # removes -1
say "returns: ", $stack.min;            # returns  2

$stack.push(  5 );

say "returns: ", $stack.max;            # returns  5

