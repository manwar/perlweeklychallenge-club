sub find-odd-character(Str $s, Str $t --> Str) {
    my %count;
    %count{$_}++ for $s.comb;
    %count{$_}-- for $t.comb;

    for %count.keys -> $char {
        return $char if %count{$char} == -1;
    }
}

# Tests
use Test;
plan 3;
is find-odd-character("Perl", "Preel"), "e", 'Test Example 1';
is find-odd-character("Weekly", "Weeakly"), "a", 'Test Example 2';
is find-odd-character("Box", "Boxy"), "y", 'Test Example 3';
