use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($name, $typed) {
    my @name = split//, $name;
    my @typed = split//, $typed;

    for (my $i = $#name; $i >= 0; $i--) {
        return 0 if ($name[$i] ne $typed[-1]);
        pop @typed;
        next if ($name[$i - 1] eq $name[$i]);
        for (my $j = $#typed; $j >= 0; $j--) {
            last if $name[$i] ne $typed[$j];
            pop @typed;
        }
    }
    return ($#typed == -1 ? 1 : 0);
}

is(run("perl", "perrrl"), 1, "Example 1");
is(run("raku", "rrakuuuu"), 1, "Example 2");
is(run("python", "perl"), 0, "Example 3");
is(run("coffeescript", "cofffeescccript"), 1, "Example 4");
is(run("raku", "arrakuuuu"), 0, "Example 5");
