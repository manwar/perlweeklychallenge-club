use Test;
my @tests =
    '2936921' => 1,
    '1234567' => 0,
    'B0YBKL9' => 1,
;
plan +@tests;

# Based on my original code from RosettaCode.
sub sedol ( Str $s --> Str ) {
    die 'No vowels allowed' if $s  ~~ /<[AEIOU]>/;
    die 'Invalid format'    if $s !~~ / ^ <[0..9A..Z] - [AEIOU]>**6 $ /; 
 
    constant %base36  = ( |(0..9), |('A'..'Z') ) Z=> ^36;
    constant @weights = 1, 3, 1, 7, 3, 9;

    my @vs = $s.comb.map: {
        %base36{$_}
            orelse fail "Bad digit '$_'"
    };

    my $checksum = [+] @vs Z* @weights;
    return $s ~ (10 - $checksum % 10) % 10;
}

sub valid_sedol ( Str $s --> Int ) {
    return + ( $s eq $s.substr(0, *-1).&sedol );
}

for @tests -> ( :key($input), :value($expected) ) {
    my $got = valid_sedol($input);
    is $got, $expected, "valid_sedol('$input') == $expected";
}
