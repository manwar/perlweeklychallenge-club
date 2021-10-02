#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Data::Dumper;

sub hash_join ($one, $kone, $two, $ktwo) {
   # make sure ($one, $kone) deal with the shorter of the two relations
   ($one, $kone, $two, $ktwo) = ($two, $ktwo, $one, $kone)
      if $one->@* > $two->@*;

   # hash phase, build a hash from ($one, $kone)
   my %hash_one;
   push $hash_one{$_->[$kone]}->@*, $_ for $one->@*;

   # scan phase
   return map {
      my @record = $_->@*;
      my $key = splice @record, $ktwo, 1;
      next unless exists $hash_one{$key};
      map { [$_->@*, @record] } $hash_one{$key}->@*;
   } $two->@*;
}

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

say join ', ', $_->@* for hash_join(\@player_ages, 1, \@player_names, 0);
