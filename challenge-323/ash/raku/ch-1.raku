# Task 1 of the Weekly Challenge 323
# https://theweeklychallenge.org/blog/perl-weekly-challenge-323

say compute '--x', 'x++', 'x++';        # 1
say compute 'x++', '++x', 'x++';        # 3
say compute 'x++', '++x', '--x', 'x--'; # 0

sub compute(*@expr) {
    my $x = 0;

    for @expr {        
        when /'++'/ {$x++}
        when /'--'/ {$x--}
    }

    return $x;
}
