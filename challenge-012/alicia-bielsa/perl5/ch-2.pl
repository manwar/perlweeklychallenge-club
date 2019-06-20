#Write a script that finds the common directory path, given a collection of paths and directory separator. For example, if the following paths are supplied.
#/a/b/c/d
#/a/b/cd
#/a/b/cc
#/a/b/c/d/e
#and the path separator is /. Your script should return /a/b as common directory path.



use strict;
use warnings;

my $separator = '/'; 
my @aPaths =('/a/b/c/d/1/2','/a/b/c/d/x/x','/a/b/c/d/a/b/c','/a/b/c/d/e/f/g/h');
my @aCommonPath = ();
 

foreach my $path ( @aPaths ){

   my @aDirectories = split ( $separator , $path );    
   unless ( scalar @aCommonPath ){
	  @aCommonPath = @aDirectories;
	  next;
   }

   foreach my $i ( 0..$#aDirectories ){ 
	  if ( defined($aCommonPath[$i]) && $aDirectories[$i]  ne $aCommonPath[$i]){
			 splice (@aCommonPath, $i , $#aCommonPath - ($i - 1));
	  }
   }
}

print "Common Directory path: " . join ( $separator,@aCommonPath ) ."\n";

 