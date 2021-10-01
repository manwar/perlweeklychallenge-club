#!/usr/bin/env raku
use v6;
sub hash-join (@one, $kone is copy, @two, $ktwo is copy) {
   # make sure ($one, $kone) deal with the shorter of the two relations
   (@one, $kone, @two, $ktwo) = (@two, $ktwo, @one, $kone)
      if @one > @two;

   # hash phase, build a hash from (@one, $kone)
   my %hash_one;
   (%hash_one{$_[$kone]} //= []).push($_) for @one;

   # scan phase
   gather for @two -> $record {
      my @record = |$record;
      my $key = @record.splice($ktwo, 1);
      next unless %hash_one{$key}:exists;
      take [($_, @record).flat] for %hash_one{$key}.List;
   }
}

my @player_ages =
        [20, "Alex"  ],
        [28, "Joe"   ],
        [38, "Mike"  ],
        [18, "Alex"  ],
        [25, "David" ],
        [18, "Simon" ],
    ;

my @player_names =
        ["Alex", "Stewart"],
        ["Joe",  "Root"   ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"   ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
    ;

.join(', ').say for hash-join(@player_ages, 1, @player_names, 0);
