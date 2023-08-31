#!/usr/bin/env raku

use JSON::Tiny;

sub MAIN ($base-folder ) {
    
    # stolen from https://docs.raku.org/routine/dir#routineroutine
    my @stack = $base-folder.IO;
    my $files = gather while @stack {
        with @stack.pop {
            when :d { @stack.append: .dir }
            .take when .extension.lc eq ('raku' | 'rakumod' | 'rakutest' | 'rakudoc')
        }
    }

    # check files syntax
    for ^$files.elems {
        my $cmd = "raku --optimize=3 -c " ~ $files[$_];
        try {
            say "Running shell $cmd";
            shell $cmd;            
        }
    }
}