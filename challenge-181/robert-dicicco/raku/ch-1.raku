use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-05
# Challenge # 181 Sentence Order ( Raku )

my $text = "All he could think about was how it would all end.
There was still a bit of uncertainty in the equation, but the basics were there for anyone to see.
No matter how much he tried to see the positive, it wasn't anywhere to be seen.
The end was coming and it wasn't going to be pretty.";

my @result = split(/\./,$text);

print(" ");

for 0..@result.elems-1 -> $i {
  my @next = split(/\s+/,@result[$i]);
  print @next.sort({lc($^a) cmp lc($^b)});
  print ".\n";
}
