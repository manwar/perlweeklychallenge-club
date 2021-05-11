use v6 ;

sub MAIN( Str $path is copy ) {
      say IO::Spec::Unix.canonpath( $path ) ;
}
