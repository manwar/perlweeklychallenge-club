#!/usr/bin/env perl6
use v6;

sub MAIN($seperator, +@paths) {
    die "Must provide at least one path" if @paths.elems == 0;

    if IO::Path.new('a').add('b').Str eq "a{$seperator}b" {
        say find-common-io-path(@paths);
    } else {
        say find-common-str(@paths, $seperator);
    }
}

sub find-common-str(@paths, $seperator) {
    my @path-parts = @paths».split($seperator).sort: { $^a.elems <=> $^b.elems };
    
    my @common;
    my $first-dirs = @path-parts.shift;
    for ^($first-dirs.elems) -> $i {
        last unless $first-dirs[$i] eq @path-parts.map(*[$i]).all;
        @common.push: $first-dirs[$i];
    }

    return @common.join($seperator);
}

sub find-common-io-path(@paths) {
    my @io-paths = @paths.map: { IO::Path.new($_).resolve };
   
    my @path-parts = gather {
        for @io-paths -> $path is copy {
            my @path-list;
            while $path.parent.Str ne $path.Str {
                @path-list.unshift: $path.Str;
                $path = $path.parent;
            }
            take @path-list.unshift: $path;
        }
    }

    @path-parts = @path-parts.sort( { $^a.elems <=> $^b.elems } );
    my $first-dirs = @path-parts.shift;

    my $common = '';
    for ^($first-dirs.elems) -> $i {
        last unless $first-dirs[$i] eq @path-parts.map(*[$i]).all;
        $common = $first-dirs[$i];
    }

    return $common;
}


