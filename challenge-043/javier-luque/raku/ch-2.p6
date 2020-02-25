# Test: perl6 ./ch2.p6
use v6.d;

# Don't know how to do this in Raku :(
our @NUMS =
<0 1 2 3 4 5 6 7 8 9 A B C D E F G H
 I J K L M N O P Q R S T U V W X Y Z>;

sub MAIN () {
    say @NUMS;
    for (1..36) -> $i {
        say $i ~ ': ' ~
            self-descriptive-x($i) ~ ' - ' ~
            self-descriptive($i);
    }
}

sub self-descriptive-x(Int $b) {
    return 'no solution' if
        ( $b == 1 || $b == 2 ||
          $b == 3 || $b == 6);

    return 1210 if ($b == 4);
    return 21200 if ($b == 5);

    return
        @NUMS[($b - 4)] ~ '2' ~ 1 ~ 0 x ($b - 7) ~ '1000';
}

sub self-descriptive(Int $b) {
    return 'no solution' if
        ( $b == 1 || $b == 2 ||
          $b == 3 || $b == 6);

    return 100 if ($b == 4);
    return 1425 if ($b == 5);

    return
        ($b - 4) * $b ** ($b - 1) +
        2 * $b ** ($b - 2) +
        $b ** ($b - 3) +
        $b ** 3;
}
