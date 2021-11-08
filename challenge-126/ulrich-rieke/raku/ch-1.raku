use v6 ;

sub MAIN( Int $N is copy ) {
  (1 .. $N).grep( { $_ !~~ /1/ } ).elems.say ;
}
