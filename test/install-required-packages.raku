#!/usr/bin/env raku

use JSON::Tiny;

sub MAIN ($base-folder ) {
    
    # stolen from https://docs.raku.org/routine/dir#routineroutine
    my @stack = $base-folder.IO;
    my $files = gather while @stack {
        with @stack.pop {
            when :d { @stack.append: .dir }
            .take when .extension.lc eq 'json'
        }
    }

    # given that list off all .json files look-alike META6.json,
    # try to install all modules found under key depends
    # something like this:
    # {
    #  "depends": [
    #    "Text::CSV",
    #    "Test",
    #    "Test::META"
    #   ]
    # }
    my $modules = [].SetHash;
    for ^$files.elems {
        my %json = from-json($files[$_].slurp);
        if %json.EXISTS-KEY('depends') {
            $modules.set(%json.<depends>);
        }
    }
    my $cmd = "zef --verbose install " ~ $modules;
    say "Running shell $cmd";
    shell $cmd;
}