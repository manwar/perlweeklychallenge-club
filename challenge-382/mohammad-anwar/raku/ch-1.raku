#!/usr/bin/env raku

use Test;

my @examples = (
    { in => 32, out => 1 },
    { in => 15, out => 0 },
    { in => 34, out => 1 },
);

plan @examples.elems;

for @examples -> $ex {
    is validate_circle($ex<in>), $ex<out>;
}

my $N;
my %squares;
my @path;
my @used;

sub validate_circle($n) {
    $N = $n;
    %squares = (1 .. Int(sqrt(2 * $n))).map({ $_ * $_ => True });
    @path = (1);
    @used = ();
    @used[1] = True;

    return dfs() ?? 1 !! 0;
}

sub dfs() {
    if @path.elems == $N {
        return %squares{@path[*-1] + @path[0]} ?? True !! False;
    }

    my $last = @path[*-1];
    for 2 .. $N -> $next {
        next if @used[$next];
        next unless %squares{$last + $next};

        @used[$next] = True;
        @path.push($next);

        return True if dfs();

        @path.pop;
        @used[$next] = False;
    }

    return False;
}
