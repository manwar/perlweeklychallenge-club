use v6 ;

my @player_ages = (
        [20, "Alex"  ],
        [28, "Joe"  ],
        [38, "Mike"  ],
        [18, "Alex"  ],
        [25, "David" ],
        [18, "Simon" ],
);
my @player_names = (
        ["Alex", "Stewart"],
        ["Joe",  "Root"  ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"  ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
);
my %R ;
my %joined ;
for @player_ages -> $pair {
  push %R{$pair[1]} , $pair[0] ;
  %R{$pair[1]}.sort( { $^b <=> $^a } ) ;
}
my @sorted = %R.keys.sort ;
for @sorted -> $name {
  my $addedData ; #contains 2 anonymous arrays, the first one the second names
                  #the second one the ages
  $addedData[1] = %R{ $name } ;
  for @player_names -> $pair {
      if ( $name eq $pair[0] ) {
    push $addedData[0] , $pair[1] ;
    %joined{$name} = $addedData ;
    %R{ $name }:delete ;#if the size of %R is limited delete this data set
      }
  }
}
@sorted = %joined.keys.sort ;
for @sorted -> $firstName {
      say ( %joined{$firstName}[1].Array X~ (", $firstName, " X~
      %joined{ $firstName }[0].Array)).join( "\n" ) ;
}
