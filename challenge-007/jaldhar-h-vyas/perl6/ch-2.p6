#!/usr/bin/perl6

# Reads a list of words, throws out the ones that are not the right length or
# contain non-alphabetical characters, makes them lower case and then returns
# this list.
sub words(Str $list, Int $length) {
    return $list.IO.lines
        .grep({  /^<:alpha>+$/ })
        .grep({ .chars == $length })
        .map({ .lc })
        .sort;
}

# makes and returns an undirected graph where the nodes are words and the edges
# are other words that differ by one letter only.
sub graph (*@words) {
    my Array %buckets;
    my SetHash %graph;


    for @words -> $word {
        for 0 .. $word.chars - 1 -> $i {
            (my $bucket = $word).substr-rw($i, 1) = '_';
            %buckets{$bucket}.push($word);
        }
    } 

    for %buckets.kv -> $bucket, @neighbors {
        for @neighbors X @neighbors -> $perm {
            if $perm[0] !~~ $perm[1] {
                %graph{$perm[0]}{$perm[1]} = True;
                %graph{$perm[1]}{$perm[0]} = True;
            }
        }
    }

    return %graph;
}

# Does a breadth-first search of the word graph returning the path from the
# start word to the end word if there is one.
sub traverse(SetHash %graph, Str $startWord) {
    my %visited;
    my Str @ladder;
    my @queue = «$startWord»;
    %visited{$startWord} = True;

    while @queue.elems {
        my @path = @queue.shift.flat;
        my $vertex = @path[*-1];
        take $vertex, @path;

        for %graph{$vertex}.keys -> $v {
            if !%visited{$v} {
                %visited{$v} = True;
                @queue.push((my @next = @path).push($v));
            }
        }
    }
}

# The function that finds the word ladder with signature required by the spec
sub find_shortest_ladder(Str $word1, Str $word2, *@wordlist) {
    for gather traverse(graph(@wordlist), $word1) -> ($vertex, @path) {
        if ($vertex ~~ $word2) {
            return @path;
        }
    }
}

sub MAIN(
    Str $list,      #= a list of words, one per line.
    Str $startWord, #= must be all lower case.
    Str $endWord    #= must be all lower case and the same length as startWord.
    where {
        $startWord ~~ /^<:lower>+$/ &&
        $endWord ~~ /^<:lower>+$/ &&
        $startWord.chars == $endWord.chars
    }
) {
    find_shortest_ladder($startWord, $endWord, words($list, $startWord.chars))
        .join(' ')
        .say;
}

