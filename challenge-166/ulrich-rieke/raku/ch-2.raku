use v6 ;


say "Which directories in the current directory do you want to diff ?" ;
my $line = $*IN.get ;
my %allFiles ;
my %directoryContents ;
my @directories = $line.split( /\s+/ ) ;
my $dirNumber = @directories.elems ;
for @directories -> $directory {
  for dir( "$directory") -> $file {
      my $fileName ;
      if ( $file ~~ /^.+ '/' (.+) $/ ) {
    $fileName = ~$0 ;
      }
      if ( "$file".IO.d ) {
    push( %directoryContents{$directory} ,  "$fileName/"  ) ;
    %allFiles{ "$fileName/"}++ ;
      }
      else {
    push( %directoryContents{$directory}, "$fileName" ) ;
    %allFiles{ "$fileName" }++ ;
      }
  }
}
my @filesNotInAllDirs = %allFiles.keys.grep( { %allFiles{ $_ } < $dirNumber }) ;
my $maxlen = @filesNotInAllDirs.sort( { $^b.chars <=> $^a.chars } )[0].chars ;
my @sorted = @filesNotInAllDirs.sort ;
my $width = $maxlen + 2 ;
for @directories -> $directory {
  print $directory ;
  print " " x ( $width - $directory.chars ) ;
  if ( $directory ne @directories[*-1] ) {
      print '|' ;
  }
  else {
      say " " ;
  }
}
for ( 1 .. $dirNumber - 1 ) {
  print '-' x $width ;
  print '|' ;
}
say '-' x $width ;
for @sorted -> $aFile {
  for @directories -> $directory {
      if ( $aFile (elem) %directoryContents{ $directory }) {
    print $aFile ;
    print " " x ( $width - $aFile.chars ) ;
      }
      else {
    print " " x $width ;
      }
      if ( $directory ne @directories[*-1] ) {
    print "|" ;
      }
      else {
    say " " ;
      }
  }
}
