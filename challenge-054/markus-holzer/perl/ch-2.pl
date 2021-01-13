use Modern::Perl;

my $N = shift @ARGV;
my $S = time;

die USAGE() unless $N;

my %result = (1 => 1);

for my $n ( 1..$N )
{
    my $current = 0;
    my $next    = $n;

    while (1)
    {
        # Dynamic programming:
        # see what you have computed so far, so you
        # don't have to compute it again
        $result{ $n } = $result{ $next } and last
            if $result{ $next };

        $next = $next % 2 == 0 ? $next / 2 : $next * 3 + 1;
        $current++;
    }

    $result{ $n } += $current;
}

print "n: $_, length: ", $result{ $_ }, "\n" for
    (sort { $result{ $b } <=> $result{ $a } } keys %result)[0..19]
;
print "runtime: ", time - $S, " seconds";

sub USAGE {
    "USAGE: ch-2.pl <N>\n";
}