.say for (100..*).grep({ $_ %% $_.comb[0,*-1].join })[^20]
