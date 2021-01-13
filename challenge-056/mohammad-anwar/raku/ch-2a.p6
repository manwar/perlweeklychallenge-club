#!/usr/bin/env perl6

use Test;

my $unit-tests = :{
    22 => { in => { 5 => { 4 => { 11 => [7, 2] },
                           8 => { 13 => [], 9 => [1] },
                         },
                  },
           out => [ "5 -> 4 -> 11 -> 2" ],
          },
};

for $unit-tests.keys -> $SUM {
    my $TREE = $unit-tests{$SUM}<in>;
    my $OUT  = $unit-tests{$SUM}<out>;

    is-deeply(find-matched-paths($TREE, $SUM), $OUT, "Tree with sum $SUM");
}

done-testing;

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
