use v6.d;

sub MAIN () {
    my %dispatch_table = (
        '+' => &add,
        '-' => &subtract,
        'x' => sub ($a , $b) { $a * $b },
        '/' => -> $a , $b { $a / $b },
    );

    my @equations = ('2 + 2', '10 - 4', '3 x 3', '25 / 5');
    for (@equations) -> $equation {
        ($equation ~~ /^(\d+)\s*(\+|\-|x|\/)\s*(\d+)$/);
        say $equation ~ ' = ' ~
            %dispatch_table{$1}($0, $2);
    }
}

sub add(Num() $a, Num() $b)      { return ($a + $b); }
sub subtract(Num() $a, Num() $b) { return ($a - $b); }
