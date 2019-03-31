perl -E 'say join(", ", map { my @x; push @x, 'fizz' unless $_ % 3; push @x, 'buzz' unless $_ % 5; @x ? join(" ", @x) : $_ } 1 .. 20)'
