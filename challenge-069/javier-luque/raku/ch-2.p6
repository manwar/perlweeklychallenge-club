# Test: perl6 ch-2.p6
use Test;

sub MAIN() {
    is s-thousand(''),            '0',      'Test: Empty string';
    is s-thousand('0'),         '001',      'Test: 0';
    is s-thousand('001'),   '0010011',      'Test: 001';
    done-testing();
}

# s1000
sub s-thousand(Str $s) {
    return $s ~ "0" ~ s-switch($s.flip);
}

# Switch
sub s-switch(Str $s is copy) {
    $s ~~ tr/01/10/;
    return $s;
}
