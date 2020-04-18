#!/usr/bin/env perl6

use v6.d;

sub MAIN() {

    my Int $SUM = 22;
    my Hash[] $TREE = :{
        5 => { 4 => { 11 => [7, 2] },
               8 => { 13 => [],
                       9 => [1],
                    },
             },
    };

    say find-matched-paths($TREE, $SUM).join("\n");
}

sub find-matched-paths(Hash[] $TREE, Int $SUM) {

    my $paths = [];
    for $TREE.keys -> $k {
        my $path = [ $k.Int ];
        for $TREE{$k}.keys -> $i {
            my $_path = [ $k.Int, $i.Int ];
            for $TREE{$k}{$i}.keys -> $j {
                $_path.push: $j.Int;
                if $TREE{$k}{$i}{$j}.elems > 0 {
                    for $TREE{$k}{$i}{$j} -> $e {
                        $_path.push: $e.Int;
                    }
                    $paths.push: $_path;
                }
                else {
                    $paths.push: [ @$_path ];
                }
            }
        }
    }

    my $matched-paths = [];
    for @$paths -> $path {
        $matched-paths.push: $path.join(" -> ") if $SUM == [+] $path;
    }

    return $matched-paths;
}
