sub MAIN {
    my %g = group-anagrams( ['x'] );
    say %g.gist;

    %g = group-anagrams(  ["opt", "bat", "saw", "tab", "pot", "top", "was"] );
    say %g.gist;
}

sub group-anagrams (@S) {
    my %groups;
    for @S -> $s {
        my $group = %groups.keys.first(-> $it { is-anagram($s, $it) });
        unless $group.defined {
            $group = $s;
            %groups{$group} = [];
        }
        %groups{$group}.push($s);
    }
    return %groups;
}

sub is-anagram (Str $a, Str $b) {
    return False unless $a.chars == $b.chars;

    return $a.comb.sort eqv $b.comb.sort
}
