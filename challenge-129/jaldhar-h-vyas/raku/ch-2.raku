#!/usr/bin/raku

sub parseDigits(Str $input) {
    my @digits = $input
        .subst(/'->'/, ' ', :g)
        .split(/<[ ,\s]>+/)
        .grep({ $_ ne q{} })
        .map({ $_.Int });

    return @digits;
}

class ListNode {
    has Int $.value is required;
    has ListNode $.next is rw;
}

class LinkedList {
    has ListNode $!head;
    has ListNode $!tail;

    submethod BUILD(:@digits = []) {
        for @digits -> $digit {
            self.append($digit);
        }
    }

    method append(Int $value) {
        my $node = ListNode.new(value => $value);

        if $!head.defined {
            $!tail.next = $node;
        }
        else {
            $!head = $node;
        }
        $!tail = $node;
    }

    method values() {
        my @values;
        my $node = $!head;

        while $node.defined {
            @values.push($node.value);
            $node = $node.next;
        }

        return @values;
    }

    method add(LinkedList $other) {
        my @left = self.values;
        my @right = $other.values;
        my @result;
        my $carry = 0;

        while @left || @right || $carry {
            my $sum = (@left.pop // 0) + (@right.pop // 0) + $carry;
            $carry = $sum div 10;
            @result.unshift($sum % 10);
        }

        return LinkedList.new(digits => @result);
    }

    method print() {
        say self.values.join(' -> ');
    }
}

sub MAIN(
    Str $leftInput,
    Str $rightInput
) {
    my $left = LinkedList.new(digits => parseDigits($leftInput));
    my $right = LinkedList.new(digits => parseDigits($rightInput));
    $left.add($right).print;
}