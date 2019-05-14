#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage {
    print <<"-USAGE-";
    Usage:
    $PROGRAM_NAME <list> <startWord> <endWord>

    <list>       a list of words, one per line.
    <startWord>  must be all lower case.
    <endWord>    must be all lower case and the same length as startWord.
-USAGE-

    exit(1);
}

# Reads a list of words, throws out the ones that are not the right length or
# contain non-alphabetical characters, makes them lower case and then returns
# this list.
sub words {
    my ($list, $length) = @_;
    open my $wordList, '<', $list or die "$list: $!\n";
    local $RS;
    my $contents = <$wordList>;
    close $wordList;
    return [ sort 
           map { lc }
           grep { /^[[:alpha:]]+$/ }
           grep { length == $length }
           split /\n/,
           $contents ];
}

# makes and returns an undirected graph where the nodes are words and the edges
# are other words that differ by one letter only.
sub graph {
    my ($words) = @_;
    my %buckets;
    my %graph;

    for my $word (@{$words}) {
        for my $i (0 .. (length $word) - 1) {
            my $bucket = $word;
            substr $bucket, $i, 1, '_';
            push @{$buckets{$bucket}}, $word;
        }
    } 

    while (my ($bucket, $neighbors)  = each %buckets) {
        for my $perm (map{ my $x = $_; map { [$x, $_] } @{$neighbors} }
        @{$neighbors}) {
            if ($perm->[0] ne $perm->[1]) {
                $graph{$perm->[0]}->{$perm->[1]} = undef;
                $graph{$perm->[1]}->{$perm->[0]} = undef;
            }
        }
    }

    return \%graph;
}

# Does a breadth-first search of the word graph returning the path from the
# start word to the end word if there is one.
sub traverse {
    my ($graph, $startWord, $endWord) = @_;
    my %visited;
    my @ladder = ();
    my @queue = ([$startWord]);

    while (scalar @queue) {
        my $path = shift @queue;
        my $vertex = @{$path}[-1];
        if ($vertex eq $endWord) {
            return @{$path};
        }

        for my $v (keys %{$graph->{$vertex}}) {
            if (!exists $visited{$v}) {
                $visited{$v} = undef;
                my @next = @{$path};
                push @next, $v;
                push @queue, \@next;
            }
        }
    }
}

# The function that finds the word ladder with signature required by the spec
sub find_shortest_ladder {
    my ($word1, $word2, $wordlist) = @_;
    return traverse(graph($wordlist), $word1, $word2);
}

if (scalar @ARGV < 3) {
    usage();
}

my $list = $ARGV[0];
my $startWord = $ARGV[1];
my $endWord = $ARGV[2];

if ($startWord !~ /^[[:lower:]]+$/ || $endWord !~ /^[[:lower:]]+$/ ||
length $startWord != length $endWord) {
    usage();
}

say join(
    q{ }, 
    find_shortest_ladder($startWord, $endWord, words($list, length $startWord))
);
