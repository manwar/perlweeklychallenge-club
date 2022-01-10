#! /usr/bin/perl6

pentpair();

sub pentpair {
    my @fpent=[0];
    my %rpent;
    my $mx=0;
    my $a=1;
    while (1) {
        while ($mx < $a) {
            $mx++;
            push @fpent,pentagon($mx);
            %rpent{@fpent[$mx]}=$mx;
        }
        for 1..$a-1 -> $b {
            my $d=@fpent[$a]-@fpent[$b];
            if (%rpent{$d}:exists) {
                my $s=@fpent[$a]+@fpent[$b];
                while ($s > @fpent[$mx]) {
                    $mx++;
                    push @fpent,pentagon($mx);
                    %rpent{@fpent[$mx]}=$mx;
                }
                if (%rpent{$s}:exists) {
                    print "P($a) + P($b) = @fpent[$a] + @fpent[$b] = $s = P(%rpent{$s})\n";
                    print "P($a) - P($b) = @fpent[$a] - @fpent[$b] = $d = P(%rpent{$d})\n";
                    exit 0;
                }
            }
        }
        $a++;
    }
}

sub pentagon($n) {
    return $n*(3*$n-1)/2;
}
