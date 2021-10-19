#!/usr/bin/env raku

# a translation of http://perplexus.info/show.php?pid=6448&cid=42810

for (1, 1e6, 2e6, 3e6, 3265920)
{
    say pandigital($_);
}

multi pandigital($n where * == 3265920) { 9876543210 }

multi pandigital($n is copy where * < 3265920)
{
    my $m;
    my $t;
    my $a = '';
    my @a = 1..9;
    my $s = set 0..9;

    loop
    {
        my $f = [*] @a;
        $m = ($n / $f).floor;
        last if $m * $f == $n;
        $t = $++ ?? $s.sort.[$m].key !! $s.sort.[$m+1].key;
        $a ~= $t;
        $s (-)= $t;
        $n -= $f * $m;
        @a.pop;
    }

    $t = $s.sort.[$m-1].key;
    $a ~= $t;
    $s (-)= $t;
    $a ~ $s.keys.sort(-*).join;
}
