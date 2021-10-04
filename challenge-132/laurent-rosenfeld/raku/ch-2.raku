use v6;

my @player_ages =
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ];

my @player_names =
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ];

my %names;
for @player_names -> $name {
    push %names{$name[0]}, $name[1];
}
for @player_ages -> $pl_age {
    my ($age, $first_name) = $pl_age;
    next unless %names{$first_name}:exists;
    # say "$age  $first_name";
    for %names{$first_name}[] -> $name {
        say "$age $first_name $name";
    }
}
