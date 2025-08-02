# Perl 4.019 on DOSBOX

sub maximum_pairs {
 local(%seen,$count,$i);
 $count=0;
 for $i (@_){
  if ( $seen{ reverse($i) } ) {
   $count++;
   $seen{ reverse($i) } = undef;
  }
  else {
   $seen{$i}=1;
  }
 }
 $count;
}

print &maximum_pairs("ab", "de", "ed", "bc"),"\n"; #1
print &maximum_pairs("aa", "ba", "cd", "ed"),"\n"; #0
print &maximum_pairs("uv", "qp", "st", "vu", "mn", "pq"),"\n"; #2
