#!/usr/bin/env raku

my $tree={
	v=>5,
	l=>{
		v=>4, 
		l=>{
			v=>11,
			l=>{
				v=>7
			},
			r=>{
				v=>2
			}
		},
	},
	r=>{
		v=>8,
		l=>{
			v=>13,
		},
		r=>{
			v=>9,
			r=>{
				v=>1
			}
		}
	}
};

my $target=@*ARGS[0]//22;
#look for  left nodes
my @stack=($tree);


while (@stack) {

	given @stack.shift {
		for qw<l r> -> $k {
			if .{$k}:exists {
				.{$k}<p>=$_;
				@stack.push: .{$k};
			}
		}
                if none(.{qw<l r>}:exists) {
                        my $p=$_;
			#my $sum=$p<v>;
			my @path;
                        while $p.defined {
				@path.push: $p<v>;
				$p=$p<p>;
                        }
			if @path.sum == $target {
				put @path.reverse.join: "->";
			}
                }
	}
}
