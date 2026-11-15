#!/usr/bin/raku

sub MAIN(
    $fs
) {
    my @entries = $fs.subst('\n', "\n", :g).subst('\t', "\t", :g).lines;
    my @names;
    my @depths;

    for @entries -> $entry {
        $entry ~~ /^(\t*)(.*)$/;
        @depths.push($0.chars);
        @names.push($1);
    }

    my @pathLengths;
    my $longestPath = 0;

    for @names.kv -> $index, $name {
        my $depth = @depths[$index];
        my $pathLength = $name.chars;
        if $depth > 0 {
            $pathLength += @pathLengths[$depth - 1] + 1;
        }
        @pathLengths[$depth] = $pathLength;

        my $hasChildren = $index + 1 < @entries.elems
            && @depths[$index + 1] > $depth;
        if $name.contains('.') && !$hasChildren {
            $longestPath = max($longestPath, $pathLength);
        }
    }

    say $longestPath;
}
