#!/usr/bin/env raku

use JSON::Tiny;

sub MAIN (Str $base-folder, Bool $dry-run=True ) {
    
    # stolen from https://docs.raku.org/routine/dir#routineroutine
    my @stack = $base-folder.IO;
    my $files = gather while @stack {
        with @stack.pop {
            when :d { @stack.append: .dir }
            .take when .extension.lc eq 'json'
        }
    }

    # given that list off all .json files look-alike META6.json,
    # try to install all modules found under key depends, build-depends, test-depends
    # something like this:
    # {
    #  "depends": [
    #    "Text::CSV",
    #    "Test",
    #    "Test::META"
    #   ]
    # }
    my $modules = [].SetHash;
    for ^$files.elems -> $i {
        try {
            my %json = from-json($files[$i].slurp);
            if %json.EXISTS-KEY('depends') {
                $modules.set(%json.<depends>);
            }elsif %json.EXISTS-KEY('build-depends') {
                $modules.set(%json.<build-depends>);
            }elsif %json.EXISTS-KEY('test-depends') {
                $modules.set(%json.<test-depends>);            
            }
        }
        note "Processing failed for " ~ $files[$i] ~ " " ~ $! if $!;
    }
    
    my $exec = '/usr/local/bin/zef'.IO.e ?? '/usr/local/bin/zef' !! '/usr/lib/perl6/site/bin/zef'.IO.e ?? '/usr/lib/perl6/site/bin/zef' !! 'zef';
    my $cmd = "$exec --verbose install " ~ $modules;
    say "Running shell $cmd";
    shell($cmd).so if not $dry-run and $modules.elems;
}