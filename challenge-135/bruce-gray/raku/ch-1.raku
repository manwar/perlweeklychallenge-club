use Test;

my @tests =
    1234567 => 345,
       -123 => 123,
          1 => 'too short',
         10 => 'even number of digits',
;
plan +@tests;

sub middle_three_digits ( Int $n --> Int ) {
    my $a = $n.abs;
    fail 'even number of digits' if $a.chars %% 2;
    fail 'too short'             if $a.chars <  3;
    return + $a.substr( ($a.chars - 3) / 2, 3 );
}

for @tests -> ( :key($input), :value($expected) ) {
    my $got = middle_three_digits($input);
    $got //= $got.exception.payload; # Turn a Failure into a Str
    is $got, $expected, "middle_three_digits($input)";
}
