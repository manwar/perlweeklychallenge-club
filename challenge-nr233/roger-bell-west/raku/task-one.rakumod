unit module challenge-nr233::roger-bell-west::raku::task-one:ver<0.0.1>:auth<roger-bell-west@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/roger-bell-west/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@a) is export {
	my %ct;
    my $ac = ord('a');
    for @a -> $w {
        my $hs = Set.new($w.comb);
        my $mask = 0;
        for $hs.keys -> $c {
            $mask +|= 1 +< (ord($c) - $ac);
        }
        %ct{$mask}++;
    }
    my $pairs = 0;
    for %ct.values -> $cv {
        if ($cv > 1) {
            $pairs += $cv * ($cv - 1) / 2;
        }
    }
    return $pairs.Int;
}