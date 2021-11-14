#! /usr/bin/env raku

use lib "lib";
use HashJoin;

unit sub MAIN (:v(:$verbose));

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

my @joined = HashJoin::merge(@player_ages, 1, @player_names, 0, :$verbose);

HashJoin::print-it(@joined);
