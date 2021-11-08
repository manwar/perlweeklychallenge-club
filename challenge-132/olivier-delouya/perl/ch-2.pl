#!perl

my @player_ages = (
        [20, "Alex"  ],
        [28, "Joe"   ],
        [38, "Mike"  ],
        [18, "Alex"  ],
        [25, "David" ],
        [18, "Simon" ],
    );

my @player_names = (
        ["Alex", "Stewart"],
        ["Joe",  "Root"   ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"   ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
    );



outerloop: foreach my $pn (@player_ages)
   {
   foreach(@player_names)
      {
      if(${$pn}[1] eq ${$_}[0]) # join!
            {
            print ${$pn}[0], ${$pn}[1], ${$_}[1], "\n";
            next outerloop;
            }
      }
    }
