#!/usr/bin/raku

sub MAIN (
    $s #= a string of alphabetic characters only
) {
    my @chars = $s.comb;
    my $result = 0;

    for 0 .. @chars.end -> $i {
        my @others = @chars;
        @others.splice($i, 1);
        my %freq = @others.classify({ $_ }).map({ $_.key => $_.value.elems ;});
        if [eq] %freq.values {
            $result = 1;
            last;
        } 
    }

    say $result;
}
