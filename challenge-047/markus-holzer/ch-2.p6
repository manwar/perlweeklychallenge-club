.say for (100..Inf).grep({ $_ %% $_.comb[0,*-1].join.Int })[0..20]
