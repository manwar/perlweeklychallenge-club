# Write a script that can wrap the given paragraph at a specified column using
# the greedy algorithm.

sub greedy_wrap($string, $width=79) {
    my $line = "";
    for $string.split(/\s+/) -> $word {
        if ($line.chars == 0) {
            $line = $word;
        } elsif ($width >= $line.chars + $word.chars) {
            $line = "$line $word";
        } else {
            $line.say;
            $line = $word;
        }
    }
    if ($line.chars > 0) {
        $line.say;
    }
}

greedy_wrap("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
