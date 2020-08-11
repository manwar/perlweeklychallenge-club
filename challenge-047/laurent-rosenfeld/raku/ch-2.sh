perl6 -e 'say (grep { $_ %% .comb[0,*-1].join}, 100..*)[0..19];'
