#!/usr/bin/env raku

sub MAIN(*@elems) {

    my %non-dup = @elems.map: {$_=>1};

    my @promises;
    for %non-dup.keys.sort {
	@promises.append: start {sleep($_); say $_}
	
    }

    await Promise.allof(@promises);
}
