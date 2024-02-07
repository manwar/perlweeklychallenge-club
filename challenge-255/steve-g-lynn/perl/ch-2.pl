#perl 4.019 on DOSBOX

sub most_frequent_word {
 local( $p, $w )=@_;
 local( @p ) = split(/[\s,.!?]+/,$p);
 local( %p, $i );
 foreach $i (@p) {
  $p{$i}++ unless ($i eq $w);
 }
 (sort {$p{$b}<=>$p{$a};}  keys %p)[0];
}

print &most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit", "hit"),"\n"; #ball
print &most_frequent_word("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"),"\n"; #Perl
