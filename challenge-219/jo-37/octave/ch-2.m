#!/usr/bin/octave -qf

#{
	This task is very similar to task 2 from week 216.  Again, it may
	be regarded as an integer linear programming task.
	Each travel day needs to be covered by at least one travel card.
	Let N be the number of days, then we have 3 * N possible travel
	cards: starting at each given day with a duration of 1, 7 or 30
	days.  This leads to N inequalities in 3 * N variables: The count
	of cards that are valid at each day must be at least one.  The
	objective function as the sum of the prices of the selected cards
	shall be minimized.

	Usage:
	./ch-2.m P1 P7 P30 D...

	P1 P7 P30
		prices for a 1-, 7- or 30-day travel card
	
	D...
		travel days
#}

###

function [xopt, fmin] = travel_cost (price, days, duration)
	N = numel(days);
	D = numel(duration);

	# Indicator "matrix" for each travel card type on every travel day.
	for i = 1:N
		for k = 1:N
			for t = 1:D
				A(i, k, t) = ...
					days(i) >= days(k) && days(i) < days(k) + duration(t);
			endfor
		endfor
	endfor

	# Vector describing the objective function.
	c = reshape(repelem(price, N), 1, []);

	# Inequalities' RHS.
	b = ones(1, N);

	# Relation ">=" for all inequalities.
	ctype = repelem("L", N);

	# Integer variables.
	vartype = repelem("I", N * D);

	# Join card type and start day dimensions and find a minimal
	# solution.
	[xopt, fmin] = glpk(c, reshape(A, N, []),
		b, [], [], ctype, vartype, 1);
endfunction

###

# Main

# card durations:
duration = [1, 7, 30]
D = numel(duration);

args = argv();
price = transpose(cellfun("str2num", args(1:D)))
days = transpose(cellfun("str2num", args(D+1:nargin)))
N = numel(days);

# find a minimum:
[xopt, fmin] = travel_cost(price, days, duration);

printf("minimum travel cost: %d\n", fmin);

# Arrange solution by start day and card type.
copt = reshape(xopt, N, []);
for i = 1:N
	for t = 1:D
		if copt(i, t)
			printf("On day %d, we buy a %d-day pass for %d.\n",
				days(i), duration(t), price(t));
		endif
	endfor
endfor

###

#{
$ ./ch-2.m 2 7 25 1 2 3 5 7 10 11 12 14 20 30 31
duration =

    1    7   30

price =

    2    7   25

days =

    1    2    3    5    7   10   11   12   14   20   30   31

minimum travel cost: 20
On day 1, we buy a 7-day pass for 7.
On day 10, we buy a 7-day pass for 7.
On day 20, we buy a 1-day pass for 2.
On day 30, we buy a 1-day pass for 2.
On day 31, we buy a 1-day pass for 2.
#}
