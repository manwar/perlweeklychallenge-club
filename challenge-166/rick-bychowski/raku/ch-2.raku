#!/usr/bin/env raku

sub MAIN( *@dirs ) {
    my %contents; # %contents{ basename } = dir
    for @dirs -> $dir {
        for dir $dir.IO -> $path {
            my $fn = $path.d ?? $path.basename ~ '/' !! $path.basename;
            push %contents{ $dir }, $fn;
        }
    }

    my $spacer = '------------------------------';
    for @dirs -> $dir {
        printf "| %-30s ", $dir;
    }
    print "|\n";
    for @dirs -> $dir {
        printf "| %-30s ", $spacer;
    }
    print "|\n";

    my @filenames = %contents{@dirs}>>.List.flat.unique;
    for @filenames -> $fn {
        loop (my $i = 0; $i < @dirs.elems; $i++) {
            if $fn (elem) %contents{ @dirs[$i] } {
                printf "| %-30s ", $fn;
            } else {
                printf "| %-30s ", "---";
            }
        }
        print "|\n";
    }
}
