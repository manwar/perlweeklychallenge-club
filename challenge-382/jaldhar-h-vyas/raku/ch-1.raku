#!/usr/bin/raku

sub isSquare($x) {
    my $r = $x.sqrt.Int;

    return $r * $r == $x;
}

sub buildGraph($n) {
    my %graph;

    for 1 .. $n -> $i {
        for 1 .. $n -> $j {
            if $i == $j {
                next;
            }
            if isSquare($i + $j) {
                %graph{$i}.push($j);
            }
        }
    }
 
    return %graph;
}

sub search($n, %graph) {
    my @path = (1);
    my %used = 1 => 1;

    my $dfs = sub ($pos) {
        if $pos == $n {
            return isSquare(@path[*-1] + @path[0]);
        }

        my $current = @path[*-1];
        for @(%graph{$current}) -> $next {
            if %used{$next} {
                next;
            }
            %used{$next} = 1;
            push @path, $next;

            if $dfs($pos + 1) {
                return True;
            }

            pop @path;
            %used{$next}:delete;
        }

        return False;
    };

    return $dfs(1) ?? @path !! ();
}

sub MAIN(
    $n
) {
    my @circle = search($n,  buildGraph($n));

    say @circle.elems ?? @circle.join(q{, }) !! '()';
}
