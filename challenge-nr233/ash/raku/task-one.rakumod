unit module ash::raku::task-one:ver<0.0.1>:auth<ash@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/ash/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@words) is export {
    my %classification = @words.classify(*.comb.unique.sort.join).grep(*.value.elems > 1);

    my $pairs = 0;
    for %classification.kv -> $k, $v {
        my @pairs = $v.combinations(2);
        $pairs += @pairs.elems;
    }
	return $pairs;
}