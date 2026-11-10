#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a filesystem as string.

Write a script to return the length of the longest absolute path to a file in the abstracted file system. If there is no file in the system, return 0.

dir
- subdir1
  - file1.ext
  - subsubdir1
- subdir2
  - subsubdir2
    - file2.ext

The above filesystem can be represented as below:

"dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"

Example 1

Input: $fs = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"
Output: 0

There are no files in the system (a file must contain a . character separating a name and extension).
Since there are no files, the answer is 0.

Example 2

Input: $fs = "file1.txt\nfile2.ext\na.png"
Output: 9

All entries are located at root depth (0 tabs).
Found File Paths:
    "file1.txt" (length = 9)
    "file2.ext" (length = 9)
    "a.png"     (length = 5)
The longest absolute file path length is 9.

Example 3

Input: $fs = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
Output: 38

Notice project v1.0 is a directory (it has children beneath it), while notes v1.txt and image.png are files.
Found File Paths:
    "my documents/project v1.0/notes v1.txt" (length = 38)
    "my documents/image.png" (length = 22)
The maximum absolute length is 38.

Example 4

Input: $fs = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"
Output: 14

Found File Paths:
    "root/a/b/c.txt" => 4 + 1 + 1 + 1 + 1 + 1 + 5 = 14
    "root/d/e.txt"   => 4 + 1 + 1 + 1 + 5 = 12
The longest file path is "root/a/b/c.txt" with length 14.

Example 5

Input: $fs = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"
Output: 32

Found File Paths:
    "a/b/c/d/e.txt" => 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 5 = 13
    "a/very_long_directory_name/f.txt" => 1 + 1 + 24 + 1 + 5 = 32
The long directory name compensates for depth, giving a max length of 32.

=cut





use Test2::V0 -no_srand => 1;
is(longest_path_length("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"), 
0, 'Example 1');
is(longest_path_length("file1.txt\nfile2.ext\na.png"), 
9, 'Example 2');
is(longest_path_length("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"), 
38, 'Example 3');
is(longest_path_length("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"), 
14, 'Example 4');
is(longest_path_length("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"), 
32, 'Example 5');
done_testing();

sub longest_path_length
{
     my $file_system = $_[0];
     my @lines = split(/\n/, $file_system);
     my (@depth, @name);
     for my $line ( @lines )
     {
          my ($tabs, $n) = $line =~ /^(\t*)(.*)$/s;
          push @depth, length($tabs);
          push @name, $n;
     }
     my $max = 0;
     my @stack;
     for my $i (0 .. $#lines) 
     {
          my $d = $depth[$i];
          splice(@stack, $d) if @stack > $d; # prune tree.
          my $full = (@stack ? $stack[-1] + 1 : 0) + length($name[$i]);
          if ($i < $#lines and $depth[$i + 1] > $d) # has children
          {
               push @stack, $full;
          }
          elsif (index($name[$i], '.') >= 0) # no children. if '.', then it is a file.
          {
               $max = $full if $full > $max;
          }
     }
     return $max;
}
