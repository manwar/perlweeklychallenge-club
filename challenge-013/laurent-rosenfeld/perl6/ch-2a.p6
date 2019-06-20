use v6;

multi sub female (0) { 1; }   # base case
multi sub female (UInt:D $n) {
    return $n - male (female ($n - 1));
}
multi sub male (0) { 0; }    # base case
multi sub male (UInt:D $n) {
    return $n - female (male ($n - 1));
}
say "Female sequence:";
printf "%d ", female $_ for 0..30;
say "";
say "Male sequence:";
printf "%d ", male $_ for 0..30;
