use v6;

sub female (UInt:D $n) {
    return 1 if $n == 0;   # base case
    return $n - male (female ($n - 1));
}
sub male (UInt:D $n) {
    return 0 if $n == 0;   #base case
    return $n - female (male ($n - 1));
}
say "Female sequence:";
printf "%d ", female $_ for 0..30;
say "";
say "Male sequence:";
printf "%d ", male $_ for 0..30;
