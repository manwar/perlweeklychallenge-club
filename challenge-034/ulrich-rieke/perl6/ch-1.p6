use v6 ;

#shows the use of hash slices!
my %towers = "tower 1" => 88 , "my favourite tower" => 102 , "elite tower" => 250 ,
  "record tower" => 500 , "ancient tower" => 34 , "medieval tower" => 20 ;
my @smaller = %towers.keys.grep( { %towers{$_} < 100 } ) ;
%towers{ @smaller }:delete ;
say "The bigger towers:" ;
for %towers.kv -> $tower , $height {
  say "$tower has a height of $height meters." ;
}

#...and of array slices :
my @random_DNA_bases  ;
for (1..63 ) {
  @random_DNA_bases.push( <A C T G>.pick( 1 )) ;
}
say "randomly selected DNA bases:" ;
@random_DNA_bases.say ;
my @tripletstarts = @random_DNA_bases[0,3,6...*] ;
say "...and the corresponding triplet starts:" ;
@tripletstarts.say ;
