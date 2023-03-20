use strict;
use warnings;

my @paths     = ( "/a/b/c/d", "/a/b/cd", "/a/b/cc", "/a/b/c/d/e" );
my $separator = "/";

my @common_path;
for my $path (@paths) {
    my @parts = split( $separator, $path );
    if ( !@common_path ) {
        @common_path = @parts;
    }
    else {
        for ( my $i = 0 ; $i < @common_path ; $i++ ) {
            if ( $common_path[$i] ne $parts[$i] ) {
                splice( @common_path, $i );
                last;
            }
        }
    }
}

print "The common directory path is: ", join( $separator, @common_path ), "\n";
