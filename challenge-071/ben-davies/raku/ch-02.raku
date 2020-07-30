use v6;

role LinkedList { ... }

unit sub MAIN(+@xs where .all ~~ Int:D, Int:D :$n! where * > 0) {
    say do with LinkedList[Int:D].from-list: @xs -> $list {
        $list.delete: * - $n
    } else {
        ''
    };
}

role LinkedList[::T] {
    has T            $.value is built(:bind);
    has ::?ROLE:_[T] $.next;

    proto method from-list(::?ROLE:U: +@ --> ::?ROLE:_) {*}
    multi method from-list(::?ROLE:U: +[] --> ::?ROLE:U) { self }
    multi method from-list(::?ROLE:U: +[T $value is raw, **@rest is raw] is raw --> ::?ROLE:D) {
        my ::?ROLE:_ $next = self.from-list: @rest if @rest;
        self.bless: :$value, :$next
    }

    method new(::?ROLE:_: T $value, ::?ROLE:_ $next? --> ::?ROLE:D) {
        self.bless: :$value, :$next
    }

    multi method elems(::?ROLE:D: --> Int:D) {
        my Int:D $elems = 1;
        $elems += $!next.elems with $!next;
        $elems
    }

    proto method delete(::?ROLE:D: | --> ::?ROLE:_) {*}
    multi method delete(::?ROLE:D: 0 --> ::?ROLE:_) { $!next }
    multi method delete(::?ROLE:D: Int:D $idx --> ::?ROLE:D) {
        my ::?ROLE:_ $next = $!next.delete: $idx - 1;
        self.new: $!value, $next
    }
    multi method delete(::?ROLE:D: Int:D $ where * < 0 --> ::?ROLE:_) {
        samewith 0
    }
    multi method delete(::?ROLE:D: Int:D $ where * >= self.elems --> ::?ROLE:_) {
        samewith self.elems - 1
    }
    multi method delete(::?ROLE:D: WhateverCode:D $mk-idx --> ::?ROLE:_) {
        samewith $mk-idx(self.elems)
    }

    multi method gist(::?ROLE:D: --> Str:D) {
        my Str:D $gist = $!value.gist;
        $gist ~= " -> $!next.gist()" with $!next;
        $gist
    }
}
