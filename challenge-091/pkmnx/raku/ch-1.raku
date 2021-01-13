#!/usr/bin/env raku

sub MAIN( Int $N where $N > -1 ) {

   my $nums = {};

   constant textmap = {
      0 => [ "zero",  "zeroes" ],
      1 => [ "one",   "ones"   ],
      2 => [ "two",   "twos"   ],
      3 => [ "three", "threes" ],
      4 => [ "four",  "fours"  ],
      5 => [ "five",  "fives"  ],
      6 => [ "six",   "sixes"  ],
      7 => [ "seven", "sevens" ],
      8 => [ "eight", "eights" ],
      9 => [ "nine",  "nines"  ]
   };

   $N.comb(/\d/).map({$nums{$_}++});

   my @text = ();
   my $out = "";
   for $nums.keys.sort({$^a <=> $^b}).map({ ($_, $nums{$_}) }) -> ($k, $v)  {
       my $cnt = textmap{$v}[0];
       my $subj = textmap{$k}[$v == 1 ?? 0 !! 1];
       $out ~= "$v$k";
       @text.prepend( "$cnt $subj" );
   }

   "Input: \$N = $N".say;
   "Output: $out".say;

   my $outfmt = "";

   if ( @text.elems > 1 ) { 
      my $last = @text.shift;
      @text = @text.reverse;
      $outfmt = (@text.join(", ") ~ " and $last");
   } else {
      $outfmt = @text.head;
   }

   printf "\nas we read: \"%s\"\n", $outfmt;
}
