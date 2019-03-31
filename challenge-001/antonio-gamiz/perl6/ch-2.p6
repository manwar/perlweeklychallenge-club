use v6;

for 1..20 {
    if (not $_ % 3) and (not $_ % 5) {
        say "FizzBuzz";
        next;
    }
    if not $_ % 3 {
        say "Buzz";
        next;
    }
    if not $_ % 5 {
        say "Buzz";
        next;
    }
    say $_;
}

