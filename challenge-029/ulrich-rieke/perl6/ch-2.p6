use v6;
use NativeCall ;

constant LIBC = '/lib/x86_64-linux-gnu/libc.so.6' ;
sub strcmp( CArray[uint8], CArray[uint8]) returns int32 is native(LIBC) { * } ;
my $firstSt = "Perl 6" ;
my $secondSt = "Perl 5" ;
my $ar1 = CArray[uint8].new($firstSt.encode.list) ;
my $ar2 = CArray[uint8].new($secondSt.encode.list) ;
if strcmp($ar1, $ar2 ) > 0 {
  say "Perl 6 is alphabetically greater than Perl 5!" ;
}
else {
  say "Perl 5 is alphabetically greater!" ;
}
