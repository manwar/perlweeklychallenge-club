unit module rcmlz::raku::task-one:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr236/rcmlz/raku/ -- test/challenge-nr236/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr236 -- test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr236; cat /tmp/nr236_task-one.csv

#|[
You are asked to sell juice each costs $5. 
You are given an array of bills. 
You can only sell ONE juice to each customer but make sure you return exact change back. 
You only have $5, $10 and $20 notes. 
You do not have any change in hand at first.

- Write a script to find out if it is possible to sell to each customers with correct change.
]
our sub solution(@input --> Bool) is export {
	my $n = @input;

	my %change =
		5 => 0,
		10 => 0,
		20 => 0
	;

	my $i = 0;
	while (%change.values).all >= 0 and $i < $n {
		given @input[$i++] {
			when 5  { 
					 	%change<5>++
				    } 
			when 10 { 
					 	%change<5>--; 
					 	%change<10>++
					} 
			when 20 { 
						if %change<10> {
					  		%change<10>--
					  	}else {
					  		%change<5>--;
					  		%change<5>--
					  	}
					  	%change<5>--
					} 
			default { die  "$_ : only 5, 10 and 20 as input is accepted!"}
		}
	}

	(%change.values).all >= 0 ?? True !! False
}