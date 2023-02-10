#! /usr/bin/perl -CSDA

# This is a 120-character-wide UTF-8-encoded Perl source-code text file with hard Unix line breaks ("\x{0A}").
# ¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय.    看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
# =======|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

########################################################################################################################
# "/d/rhe/PWCC/203/ch-2.pl" (and fork to "/d/rhe/clone-directory-structure.pl").
# Clones a directory structure from a source directory to a destination directory.
#
# Edit history:
# Thu Jun 25, 2015: Wrote first draft (of file "for-each-directory-in-tree.pl").
# Fri Jul 17, 2015: Upgraded for utf8.
# Sat Apr 16, 2016: Now using -CSDA.
# Sat Jan 02, 2021: Simplified and updated.
# Sat Jan 16, 2021: Refactored. Now using indented here documents.
# Sat Nov 20, 2021: Refreshed shebang, colophon, titlecard, and boilerplate; using "common::sense" and "Sys::Binmode".
# Thu Nov 25, 2021: Renamed to "for-each-directory-in-tree.pl" to avoid confusion with other programs.
#                   Shortened subroutine names. Added time stamping.
# Wed Feb 08, 2023: Forked to THIS file ("/d/rhe/PWCC/203/ch-2.pl") and to "clone-directory-structure.pl".
#                   Made THIS file NOT dependent on my RH::Dir module by copy-pasting needed subs.
########################################################################################################################

# DESCRIPTION OF PROBLEM:

=pod

Task 2: Copy Directory
Submitted by: Julien Fiegehenn

You are given path to two folders, $source and $target. Write a script that recursively copy the directory from $source
to $target except any files.

Example:

Input: $source = '/a/b/c' and $target = '/x/y'

Source directory structure:

├── a
│   └── b
│       └── c
│           ├── 1
│           │   └── 1.txt
│           ├── 2
│           │   └── 2.txt
│           ├── 3
│           │   └── 3.txt
│           ├── 4
│           └── 5
│               └── 5.txt

Target directory structure:

├── x
│   └── y

Expected Result:

├── x
│   └── y
|       ├── 1
│       ├── 2
│       ├── 3
│       ├── 4
│       └── 5

=cut

# PRELIMINARIES:
use v5.36;
use feature "signatures";
use Sys::Binmode;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use utf8;
use Cwd;
use Encode      qw( :DEFAULT encode decode :fallbacks :fallback_all );
use Time::HiRes qw( time );
use open ':std', IN  => ':encoding(UTF-8)';
use open ':std', OUT => ':encoding(UTF-8)';
use open         IN  => ':encoding(UTF-8)';
use open         OUT => ':encoding(UTF-8)';

# VARIABLES:
my $db1        = 0  ; # Set to 1 to debug, 0 to not debug.
my $db2        = 0  ; # Set to 1 to debug, 0 to not debug.
my $db3        = 0  ; # Set to 1 to debug, 0 to not debug.
my $allow      = 0  ; # Set to 1 to allow non-empty destination directory.
my $srcedire        ; # Source      directory.
my $srceleng        ; # Source      directory length.
my $destdire        ; # Destination directory.
my $direcount  = 0  ; # Count of subdirectories created.

# SUBROUTINE PRE-DECLARATIONS:
#   name                proto
sub get_name_from_path :prototype($)        ; # Get the "name" part of a path.
sub d                                       ; # Decode from UTF-8 to raw Unicode codepoints.
sub e                                       ; # Encode from raw Unicode codepoints to UTF-8.
sub RecurseDirs        :prototype(&)        ; # Recursively traverse a directory tree.
sub argv                                    ; # Process @ARGV.
sub curdire                                 ; # Process current directory.
sub stats                                   ; # Print statistics.
sub croak                                   ; # Print error message and die.
sub help                                    ; # Print help.

# SUBROUTINE DEFINITIONS:

# Return the name part of a file path:
sub get_name_from_path :prototype($)
{
   my $path = shift;

   # If $path does not contain "/", then consider $path to be an unqualified
   # file name, so return $path:
   if (-1 == rindex($path,'/'))
   {
      return $path;
   }

   # Else if the right-most "/" of $path is to the left of the final character,
   # return the substring of $path to the right of the right-most "/":
   elsif (rindex($path,'/') < length($path)-1)
   {
      return substr($path, rindex($path,'/') + 1);
   }

   # Else "/" is the final character of $path, so this $path contains no
   # file name, so return an empty string:
   else
   {
      return '';
   }
} # end sub get_name_from_path

# Prepare constant "EFLAGS" which contains bitwise-OR'd flags for Encode::encode and Encode::decode :
use constant EFLAGS => RETURN_ON_ERR | WARN_ON_ERR | LEAVE_SRC;

# Decode from UTF-8 to raw Unicode codepoints:
sub d
{
      if (0 == scalar @_) {return Encode::decode('UTF-8', $_,    EFLAGS);}
   elsif (1 == scalar @_) {return Encode::decode('UTF-8', $_[0], EFLAGS);}
   else              {return map {Encode::decode('UTF-8', $_,    EFLAGS)} @_ };
} # end sub d

# Encode from raw Unicode codepoints to UTF-8:
sub e
{
      if (0 == scalar @_) {return Encode::encode('UTF-8', $_,    EFLAGS);}
   elsif (1 == scalar @_) {return Encode::encode('UTF-8', $_[0], EFLAGS);}
   else              {return map {Encode::encode('UTF-8', $_,    EFLAGS)} @_ };
} # end sub e

# Navigate a directory tree recursively, applying code at each node on the tree:
sub RecurseDirs :prototype(&)
{
   # Store incoming code reference in variable $f:
   my $f = \&{shift @_};

   # Die if f is not a ref to some code (block or sub):
   if ('CODE' ne ref $f)
   {
      die '\nError: RecurseDirs takes 1 argument which must be\n'.
          'a {code block} or a reference to a subroutine.\n\n';
   }

   # Get current directory:
   my $curdir = d getcwd;

   # Keep track of recursion:
   state $recursion = 0;
   ++$recursion;

   if ($db1)
   {
      say "Recursion Level   = $recursion";
      say "Current Directory = $curdir";
   }

   # Disallow more than 50 recursive levels, to prevent stack overflow:
   if ( $recursion > 50 )
   {
      die "Error in RecurseDirs: More than 50 levels of recursion!\n"
        . "CWD = \"$curdir\"\n"
        . "$!\n";
   }

   # Get a list of all entries in the current directory:
   my $dh = undef;
   opendir $dh, e $curdir      or die "Error in RecurseDirs: Couldn't open  directory \"$curdir\".\n$!\n";
   my @subdirs = d readdir $dh or die "Error in RecurseDirs: Couldn't read  directory \"$curdir\".\n$!\n";
   closedir $dh                or die "Error in RecurseDirs: Couldn't close directory \"$curdir\".\n$!\n";

   # Navigate immediate subdirs (if any) of this instance's current directory:
   SUBDIR: foreach my $subdir (@subdirs)
   {
      # Skip this path if it doesn't exist:
      next SUBDIR if ! -e e $subdir;

      # Skip this path if it's not a directory:
      next SUBDIR if ! -d e $subdir;

      # Skip this path if it's a hidden subdirectory:
      next SUBDIR if '.' eq substr $subdir, 0, 1;

      # Skip this path if it's a symbolic link:
      next SUBDIR if -l e $subdir;

      # Try to chdir to $subdir:
      if ( ! chdir e $subdir )
      {
         warn "Warning from RecurseDirs: Couldn't cd to subdir \"$subdir\"!\n";
         chdir e $curdir or die "Error in RecurseDirs: Couldn't cd back to curdir \"$curdir\"!\n";
         next SUBDIR;
      }

      # Try to recurse:
      RecurseDirs(\&{$f}) or die "Error in RecurseDirs: Couldn't recurse!\n";

      # Try to cd back to $curdir:
      chdir e $curdir or die("Error in RecurseDirs: Couldn't cd back!\n");

   } # end foreach my $subdir (@subdirs)

   # Execute f only at the tail end of SubDirs; that way if f renames immediate subdirectories of the
   # current directory (for example, f is RenameFiles running in directories mode), that's no problem,
   # because all navigation of subdirectories of the current directory is complete before f is executed.
   # In other words, each instance of RecurseDirs is only allowed to fulfill its primary task after its
   # children have all died of old age, having fulfilled their tasks.
   $f->() or die "Error in RecurseDirs: Couldn't apply function!\n";
   --$recursion;
   return 1;
} # end sub RecurseDirs (&)

sub argv ()
{
   for ( my $i = 0 ; $i < @ARGV ; ++$i )
   {
      $_ = $ARGV[$i];
      if (/^-[\pL]{1,}$/ || /^--[\pL\pM\pN\pP\pS]{2,}$/)
      {
         if (/^-h$/ || /^--help$/)  {help; exit;}
         if (/^-a$/ || /^--allow$/) {$allow = 1;}
         splice @ARGV, $i, 1;
         --$i;
      }
   }

   # Get number of non-option arguments:
   my $NA = scalar(@ARGV);            

   # Croak if number of arguments is not 2:
   if ( 2 != $NA         ) {croak "Error: number of arguments is not two.          ";}

   # Store arguments in $srcedire and $destdire:
   $srcedire = $ARGV[0];
   $destdire = $ARGV[1];

   # Die if either does not exist, 
   # or of either directory is not a directory,
   # or if either directory cannot be opened,
   # or if destination directory is not empty:
   if ( ! -e e $srcedire ) {croak "Error: source directory doesn't exist.          ";}
   if ( ! -d e $srcedire ) {croak "Error: source directory isn't a directory.      ";}
   if ( ! -e e $destdire ) {croak "Error: destination directory doesn't exist.     ";}
   if ( ! -d e $destdire ) {croak "Error: destination directory isn't a directory. ";}

   # OK, we have directories. But can we actually open them?
   my $dhs = undef;
   my $dhd = undef;
   opendir($dhs, e $srcedire)
                         or croak "Error: couldn't open source directory.          ";
   opendir($dhd, e $destdire)
                         or croak "Error: couldn't open destination directory.     ";

   # If non-empty destination directory is not being allowed, enforce that here:
   if (!$allow)
   {
      my @dest = d readdir $dhd;
      for (@dest)
      {
         if ('.' ne $_ && '..' ne $_)
                           {croak "Error: destination directory isn't empty.       "}
      }
   }

   # Close all directories for now:
   closedir $dhs;
   closedir $dhd;

   # IMPORTANT: Canonicalize $srcedire and $destdire so that they become absolute instead of relative:
   my $strtdire = d getcwd;
   chdir e $srcedire     or croak "Error: couldn't chdir to source directory.      ";
   $srcedire = d getcwd;
   $srceleng = length $srcedire;
   if ($db2) {say "source directory = $srcedire";}
   chdir e $strtdire     or croak "Error: couldn't chdir to starting directory.    ";
   chdir e $destdire     or croak "Error: couldn't chdir to destination directory. ";
   $destdire = d getcwd;
   if ($db2) {say "destination directory = $destdire";}

   # IMPORTANT: chdir back to srcedir, or we'll start at the wrong place!!!
   chdir e $srcedire     or croak "Error: couldn't chdir to source directory.      ";

   return 1;
} # end sub argv ()

sub curdire
{
   # Get and state current working directory:
   my $curdir = d getcwd;
   if ($db2) {say "\nDirectory # $direcount: \"$curdir\"\n";}

   # If current directory is the starting directory, just return:
   if ( $curdir eq $srcedire ) {return 1;}

   # Otherwise, clone this directory to the other tree:
   my $destsubd = $destdire . substr($curdir, $srceleng);
   if (0 != system(e "mkdir -p '$destsubd'"))
   {
      warn "command failed: mkdir -p '$destsubd'";
   }
   else
   {
      say "made new subdir '$destsubd'";
      ++$direcount;
   }

   return 1;
} # end sub curdire

sub stats
{
   say '';
   say "Cloned $direcount subdirs from source to destination.";
   return 1;
} # end sub stats

# Print error message and die:
sub croak ($msg)
{
   warn "$msg\n\n"
      . "This program must have 2 arguments, which must be directory paths,\n"
      . "which may be either absolute or relative to current directory.\n"
      . "The first path will be the source and the second will be the destination.\n"
      . "The destination directory must be empty. This program will then clone\n"
      . "the directory structure of the source to the destination, without copying\n"
      . "any files. Run this program with a -h or --help option to get more help.\n\n";
   die "$!\n";
}

sub help
{
   print ((<<"   END_OF_HELP") =~ s/^   //gmr);
   Welcome to "clone-directory-structure.pl", Robbie Hatley's nifty program for
   cloning the directory structure of a directory tree to an empty directory.
   This may be useful, for example, for setting-up a "mirror" drive to act as
   a backup for a main drive, to be used with "FreeFileSync", "TreeComp", or
   other such backup or synchronizing software

   Command lines:
   for-each-dir.pl [-h|--help]  (to print this help and exit)
   for-each-dir.pl srce dest    (to clone dir structure from srce to dest)

   Description of options:
   Option:                      Meaning:
   "-h" or "--help"             Print help and exit.
   "-a" or "--allow"            Allow non-empty destination directory.
   All other options (arguments starting with "-" or "--") are ignored.

   Description of arguments:
   This program takes exactly 2 arguments, which must be a source directory path
   followed by a destination directory path. Both paths may be either absolute
   (starting with "/") or relative to current directory (not starting with "/").
   Both directories must exist, and the destination directory must be empty.
   This program will then copy the directory structure from source to destination.
   No non-directory files will be copied.

   Also note that nothing on the "root" side of source or destination will be
   touched. For example, if source is "/a/b/c/d" and destination is "/x/y/z",
   then ONLY directories from inside "/a/b/c/d" (eg, "/a/b/c/d/e") will be
   copied, and contents will ONLY be added inside "/x/y/z" (eg,"/x/y/z/e").

   Cheers,
   Robbie Hatley,
   programmer.
   END_OF_HELP
   return 1;
} # end sub help

# MAIN BODY OF PROGRAM:

{ # begin main
   say "\nNow entering program \"" . get_name_from_path($0) . "\".";
   my $t0 = time;
   argv;
   RecurseDirs {curdire};
   stats;
   my $t1 = time; my $te = $t1 - $t0;
   say "\nNow exiting program \"" . get_name_from_path($0) . "\". Execution time was $te seconds.";
   exit 0;
} # end main