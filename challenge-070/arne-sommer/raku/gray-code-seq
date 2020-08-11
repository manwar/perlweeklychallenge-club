#! /usr/bin/env raku

unit sub MAIN (Int $N where 2 <= $N <=5 = 3,
   	       :$v, :$verbose = $v);

my @sequence = (0,1,3,2);

for 3 .. $N -> $level
{
  @sequence = generate2bgcs(@sequence, $level, $verbose);
}

say "[{ @sequence.join(", ") }]";

sub generate2bgcs (@in, $level, $verbose)
{
  my @S1a = @in.map({ .fmt('%0' ~ ($level-1)  ~ 'b')  });
  my @S2a = @S1a.reverse;
  my @S1  = @S1a.map({ "0$_" });
  my @S2  = @S2a.map({ "1$_" });
  my @S3  = (@S1, @S2).flat;
  my @out = @S3.map( *.parse-base(2) );
  
  if $verbose
  {
    say ": a) S1 = [{ @S1a.join(", ")  }]";
    say ": b) S2 = [{ @S2a.join(", ")  }]";
    say ": c) S1 = [{ @S1.join(", ")   }]";
    say ": b) S2 = [{ @S2.join(", ")   }]";
    say ": e) S3 = [{ @S3.join(", ")   }]";
    say ": \$N=$level  = [{ @out.join(", ")   }]";
  }
  return @out;
}
