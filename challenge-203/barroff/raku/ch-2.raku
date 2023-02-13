#!/usr/bin/env raku

use v6.d;

# check in the signature that we have two directories
sub copy_recursively(IO::Path $source where $source.d, IO::Path $dest where $dest.d) {
    # iterate directory content
    for $source.dir {
        # check if elment is a directory
        if $_.d {
            my $new_dir = "$dest/{$_.basename}";
            # create directory at destination
            mkdir $new_dir or die "$!";
            # call recursively on the direcoty
            copy_recursively($_, $new_dir.IO);
        }
    }
}

#| Rebuild example test case
multi sub MAIN('test') {
    use Test;
    use File::Temp;
    plan 5;

    my Str $source_dir = tempdir();
    my Str $target_dir = tempdir();
    mkdir "$source_dir/a/b/c/$_" for 1 .. 5;
    mkdir "$target_dir/x/y";
    copy_recursively("$source_dir/a/b/c".IO, "$target_dir/x/y".IO);
    ok "$target_dir/x/y/$_".IO.d, "Exists directory $target_dir/x/y/$_" for 1 .. 5;
}

#| Call on user provided options
multi sub MAIN(Str $source_dir where $source_dir.IO.d, Str $target_dir where $target_dir.IO.d) {
    copy_recursively($source_dir.IO, $target_dir.IO);
}
