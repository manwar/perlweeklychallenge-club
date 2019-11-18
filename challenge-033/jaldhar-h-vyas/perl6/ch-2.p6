#!/usr/bin/perl6

constant $N = 11;

say '  x|', (1 .. $N).fmt('% 4s', q{}), "\n", '---+', ('----' x $N);

my @table = (1 .. $N X 1 .. $N).grep({ $_[1] >= $_[0]}).map({ $_[0] * $_[1] });

for (1 .. $N) {
    printf "% 3s|%s%s\n",
        $_,
        q{ } x 4 * ($_ - 1), 
        @table.splice(0, $N - $_ + 1).fmt('% 4s', q{});
};

