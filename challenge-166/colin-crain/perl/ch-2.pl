#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       different-directions.pl
#
#       K-Directory Diff
#         Submitted by: Ryan J Thompson
#         Given a few (three or more) directories (non-recursively),
#         display a side-by-side difference of files that are missing from
#         at least one of the directories. Do not display files that exist
#         in every directory.
# 
#         Since the task is non-recursive, if you encounter a subdirectory,
#         append a /, but otherwise treat it the same as a regular file.
# 
#         Example
#         Given the following directory structure:
# 
#         dir_a:
#             Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  
#             Impact.otf  Verdana.ttf  Old_Fonts/
# 
#         dir_b:
#             Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  
#             Impact.otf  Tahoma.ttf  Verdana.ttf
# 
#         dir_c:
#             Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  
#             Monaco.ttf  Verdana.ttf
# 
#         expected output:
#             The output should look similar to the following:
# 
#             dir_a          | dir_b           | dir_c
#             -------------- | --------------- | ---------------
#             Comic_Sans.ttf | Comic_Sans.ttf  |
#                            | Courier_New.ttf | Courier_New.ttf
#             Georgia.ttf    |                 |
#                            |                 | Monaco.ttf
#             Old_Fonts/     |                 |
#                            | Tahoma.ttf      |
# 
#         method:

#             ok, quick and dirty. Suck the directories in as lists instead
#             of performing a proper `open` an `reddir`, Give each
#             "directory" a name. Then iterate through the directories and
#             populate a common hash of filenames pointing to an array of
#             directory names in fixed indexes
#             
#             Then reading through the indices of the array associated with
#             each filename, we can map them to a specific column for
#             output.
# 
#             We need to fiddle a bit to make sure every assoicated file
#             array has positions for each directory whether it's found in
#             that directory or not, so when we join them up we get
#             vertical bars for the columns. Purely cosemetic but it looks
#             nice
# 
#             Basically works by flipping the data on its side using a
#             clever data structure and just reading it out again. At least
#             that's the way I think of it.
# 
#             Assumes we don't want dotfiles and directories don't come
#             with a trailing slash
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

## INPUT DIRECTORY DATA
## We should take in list of directories at the command line, 
## open them and read their contents into an array of filenames, 
## which are themselves stored in a hash keyed on the directory names

my %dirs;

## we should do this (not tested):

# for my $dir (@ARGV) {
#     opendir(my $DIR, $dir) or die "Can't open directory $dir: $!";
#     my @files = map { -d $_ ? "$_/" : $_ }   ## trailing slash on directories
#                 grep { ! /^\./ }             ## remove dotfiles
#                 readdir($DIR);
#     closedir $DIR;
# 
#     $dirs{$dir} = \@files;  
#     undef @files;
# }

## but for ease of testing we do this:

$dirs{dir_a} = [ qw(
            Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  
            Impact.otf  Verdana.ttf  Old_Fonts/) ];

$dirs{dir_b} = [ qw(
            Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  
            Impact.otf  Tahoma.ttf  Verdana.ttf) ];

$dirs{dir_c} = [ qw(
            Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  
            Monaco.ttf  Verdana.ttf) ];
            
my %file_locations;

## fill the data structure
my $i = 0;
for my $dir (sort keys %dirs) {
    for my $file ($dirs{$dir}->@*) {
        $file_locations{$file}->[$i] = $file;
    }    
    $i++;
}

## read the data structure and write the report
$i       = 0;
my $cols = keys %dirs;
my $w    = 20;              ## arbitrary and fixed column width 
my $fmt  = " %-${w}s ";

my $header =  join '|', map { sprintf $fmt, $_ } sort keys %dirs;
my $break  =  join '|', map { sprintf $fmt, $_ } ('-' x $w) x keys %dirs;

say $header;
say $break;

for my $file ( sort keys %file_locations) {
    my $fcount = scalar grep { $_ } $file_locations{$file}->@*;
    my $dcount = scalar keys %dirs;
    next if $fcount == $dcount;
    
    ## fiddle the arrays to make sure we have one element for each
    ## directory to improve output look
    my @out = map { $file_locations{$file}->[$_] // '' }(0..$dcount-1);
    say join '|', map { sprintf $fmt, (defined $_ ? $_ : '') } @out;
}


