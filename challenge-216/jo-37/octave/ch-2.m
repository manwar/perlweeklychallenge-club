#!/usr/bin/octave -qf

#{
Building the target from some stickers may be formulated as an
integer linear programming problem.

For each letter in the target word, its quantity needs to be covered by
the selected stickers.  This results in one linear inequality for each
unique letter in the target.  The objective is to minimize the total
number of stickers.

The integer restriction is crucial as "feo" might be build from 1/2 of
"fee" and "foo" otherwise.

Usage:
./ch-2.m target sticker...
#}

function [xopt, fmin] = min_stickers (target, stickers)
	# Find unique required letters.
	required = unique(target);

	# RHS of the linear inequations: number of each required letter.
	for i = 1:numel(required)
		b(i) = sum(target == required(i));
	endfor

	# Matrix holding the number of the required letters provided by each
	# sticker.
	for i = 1:numel(required)
		for j = 1:numel(stickers)
			A(i,j) = sum(stickers{j} == required(i));
		endfor
	endfor

	# Objective function: the total number of selected stickers.
	c = ones(1, numel(stickers));

	# Select ">=" for all inequalities.
	ctype = repelem("L", numel(b));

	# Select integer type for all variables.
	vartype = repelem("I", numel(c));

	# Call the LP solver for integer solutions of c'x -> min, A x >= b.
	[xopt, fmin] = glpk(c, A, b, [], [], ctype, vartype, 1);
endfunction

# Process program arguments.
args = argv();
target = args{1};
stickers = args(2:nargin);
printf("target:\t%s\n", target);
printf("stickers:\n");
printf("\t%s\n", stickers{:});

# Find the minimum solution.
[xopt, fmin] = min_stickers(target, stickers);

# Print the solution.
printf("%d stickers needed to build \"%s\":\n", fmin, target);
for i = 1:numel(xopt)
	if xopt(i) > 0
		printf("%d x %s\n", xopt(i), stickers{i});
	endif
endfor

#{
target:	peon
stickers:
	perl
	raku
	python
2 stickers needed to build "peon":
1 x perl
1 x python
#
target:	goat
stickers:
	love
	hate
	angry
3 stickers needed to build "goat":
1 x love
1 x hate
1 x angry
#
target:	accommodation
stickers:
	come
	nation
	delta
4 stickers needed to build "accommodation":
2 x come
1 x nation
1 x delta
#
target:	accommodation
stickers:
	come
	country
	delta
NA stickers needed to build "accommodation":
#
target:	feo
stickers:
	fee
	foo
2 stickers needed to build "feo":
1 x fee
1 x foo
#}
