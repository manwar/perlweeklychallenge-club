#!/usr/bin/perl6

multi sub MAIN(
   +@args where { $_.elems && $_.all ~~ /^\// }  #= File paths.
) {
    my @paths = @args
                .sort
                .reverse
                .map({ $_.split('/') });

    my @commonDirectoryPath;
    for 0 .. @paths[0].elems - 1 -> $segment {
        my $dir = @paths.first()[$segment];
        if @paths.map({ $_[$segment] }).all eq $dir {
            push @commonDirectoryPath, $dir;
        } else {
            last;
        }
    }

    say @commonDirectoryPath.elems > 1 ?? @commonDirectoryPath.join('/') !! '/';
}