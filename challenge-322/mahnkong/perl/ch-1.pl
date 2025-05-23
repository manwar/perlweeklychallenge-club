use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str, $group_length) {
    my $stripped = reverse($str) =~ s/-//gr;
    my @parts;
    for (my $i = 0; $i < length($stripped); $i += $group_length) {
        push @parts, substr($stripped, $i, $group_length);
    }
    return reverse(join('-', @parts));
}

is(run("ABC-D-E-F", 3), "ABC-DEF", "Example 1");
is(run("A-BC-D-E", 2), "A-BC-DE", "Example 2");
is(run("-A-B-CD-E", 4), "A-BCDE", "Example 3");
