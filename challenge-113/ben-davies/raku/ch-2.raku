use v6;

role BTree[::T] {
    has T          $.value is required;
    has ::?CLASS:_ $.left  = $?CLASS;
    has ::?CLASS:_ $.right = $?CLASS;

    method new(::?ROLE:_: T $value, ::?CLASS:_ :L($left) = $?CLASS, ::?CLASS:_ :R($right) = $?CLASS --> ::?ROLE:D) {
        self.bless: :$value, :$left, :$right
    }

    multi method CALL-ME(::?ROLE:U: |args --> ::?ROLE:D) {
        self.new: |args
    }

    multi method sum(::?ROLE:U: --> 0)     { }
    multi method sum(::?ROLE:D: --> Int:D) { $!value + $!left.sum + $!right.sum }

    multi method map(::?ROLE:U: &f --> ::?ROLE:U) { self }
    multi method map(::?ROLE:D: &f --> ::?ROLE:D) { self.new: f($!value), L => $!left.map(&f), R => $!right.map(&f) }

    multi method gist(::?ROLE:D: Int:D :$level = 0 --> Str:D) {
        my Str:D $margin = ' ' x $level * 2;
        join $?NL,
             $!value.gist,
             ($margin ~ "L $!left.gist(level => $level + 1)" with $!left),
             ($margin ~ "R $!right.gist(level => $level + 1)" with $!right)
    }
}

my constant BIT = BTree[Int:D].^pun;

unit sub MAIN() {
    my BIT:D $bit = BIT(1,
        L => BIT(2,
          L => BIT(4,
            R => BIT(7))),
        R => BIT(3,
          L => BIT(5),
          R => BIT(6)));
    my Int:D $sum = $bit.sum;
    say $bit.map: $sum - *;
}
