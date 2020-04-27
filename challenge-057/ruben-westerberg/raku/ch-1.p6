#!/usr/bin/env raku

my $tree={
	v=>1,
	l=>{
		v=>2,
		l=>{
			v=>4
		},
		r=>{
			v=>5
		}
	},
	r=>{
		v=>3,
		l=>{
			v=>6
		},
		r=>{
			v=>7
		}
	}
};


my @stack=($tree);

while @stack {
	given (@stack.shift) {
		if all .{<l r>}:exists {
			my $t=.<l>;
			.<l>=.<r>;
			.<r>=$t;
			@stack.push: .<l>;
			@stack.push: .<r>;
			say  $_;
		}
	}
}

