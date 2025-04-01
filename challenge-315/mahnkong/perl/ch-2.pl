use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($sentence, $first, $second) {
    my $thirds = [];
    while ($sentence =~ /(\w+)\s+(\w+)\s+(\w+)/) {
        push @$thirds, $3 if ($first eq $1 && $second eq $2);
        $sentence =~ s/^\w+\s+//;
    }
    return $thirds;
}

is_deeply(run("Perl is a my favourite language but Python is my favourite too.", "my", "favourite"), ["language", "too"], "Example 1");
is_deeply(run("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful"), ["doll", "princess"], "Example 2");
is_deeply(run("we will we will rock you rock you.", "we", "will"), ["we", "rock"], "Example 3");
