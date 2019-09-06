#!/usr/bin/env perl6
#
my %index;

#build the index tree
$*ARGFILES.handles.map({
	.encoding('utf8');
	my $path=.path;
	my $line=1;
	sink .lines.map({
		sink .comb(/\w+/).  map({
			%index{$_}{$path}<count>++;
			%index{$_}{$path}<lines>.push($line);
		});
		$line++;
	});
});

#print out the index tree sorted by words
%index.keys.sort.map({
        print "Word: $_\n";
	my $e=%index{$_};#$_;
	sink $e.keys.sort.map({
		printf "\tFile: %s\t Count: %s\t Line: %s\n", $_, $e{$_}.<count>, $e{$_}.<lines>;	
	});
});


