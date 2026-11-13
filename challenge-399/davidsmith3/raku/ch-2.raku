#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 399 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Longest Absolute Path

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

=head3 Example 1:

Input: $fs = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"
Output: 0

There are no files in the system (a file must contain a . character separating a name and extension).
Since there are no files, the answer is 0.

=head3 Example 2:

Input: $fs = "file1.txt\nfile2.ext\na.png"
Output: 9

All entries are located at root depth (0 tabs).
Found File Paths:
    "file1.txt" (length = 9)
    "file2.ext" (length = 9)
    "a.png"     (length = 5)
The longest absolute file path length is 9.

=head3 Example 3:

Input: $fs = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
Output: 38

Notice project v1.0 is a directory (it has children beneath it), while notes v1.txt and image.png are files.
Found File Paths:
    "my documents/project v1.0/notes v1.txt" (length = 38)
    "my documents/image.png" (length = 22)
The maximum absolute length is 38.

=head3 Example 4:

Input: $fs = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"
Output: 14

Found File Paths:
    "root/a/b/c.txt" => 4 + 1 + 1 + 1 + 1 + 1 + 5 = 14
    "root/d/e.txt"   => 4 + 1 + 1 + 1 + 5 = 12
The longest file path is "root/a/b/c.txt" with length 14.

=head3 Example 5:

Input: $fs = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"
Output: 32

Found File Paths:
    "a/b/c/d/e.txt" => 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 5 = 13
    "a/very_long_directory_name/f.txt" => 1 + 1 + 24 + 1 + 5 = 32
The long directory name compensates for depth, giving a max length of 32.

=end pod

# transform "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"
# into [[0 dir] [1 subdir1] [2 subsubdir1] [1 subdir2]]
sub build-intermediate(Str:D $fs --> Array) {
    my @fs = $fs.comb;
    my @intermediate;
    my $i = 0;
    while $i < @fs.elems {
        my $level = 0;
        while $i < @fs.elems && @fs[$i] (elem) ("\n", "\t") {
            $level++ if @fs[$i] eq "\t";
            $i++;
        }
        # \n\tsubdir\n\t
        #     ^
        #     i
        my $j = 0;
        while ($i + $j) < @fs.elems && @fs[$i + $j] !(elem) ("\n", "\t") {
            $j++;
        }
        # \n\tsubdir\n\t
        #           ^
        #           i + j
        @intermediate.push([$level, @fs[$i..^($i+$j)].join]);
        $i += $j;
    }
    @intermediate;
}

sub build-absolute-paths(@rep --> Array) {
    my @intermediate = @rep.reverse.List;
    .push(False) for @intermediate;  # marker if is a parent
    my $i = 0;
    my @paths = [""];
    while $i < @intermediate.elems {
        # @intermediate[$i] is the current leaf
        my ($level, $name) = @intermediate[$i];
        my @path;
        @path.unshift(@intermediate[$i]);
        # find all ancestors by finding the closest node one level up
        my $j = $i + 1;
        while $j < @intermediate.elems {
            my ($curr-level, $curr-name) = @intermediate[$j];
            if $curr-level == $level - 1 {
                @path.unshift(@intermediate[$j]);
                @intermediate[$j][2] = True;  # mark as parent
                $level--;
            }
            $j++;
        }
        # @intermediate[$i] is still the current leaf
        unless @intermediate[$i][2] || $name !~~ / '.' <[\w\d]>+ $ / {
            @paths.push(@path.map({ .[1] }).join("/"));
        }
        $i++;
    }
    @paths;
}

# the issue of legal characters in a filename gets complicated
# quickly, for this challenge we'll assume the input is well
# structured and that a file has a dot and then one or more
# word or digit characters to make up the extension
sub longest-absolute-path(Str:D $fs --> Int) {
    build-absolute-paths(build-intermediate($fs)).map({ .chars }).max;
}

#| return longest absolute file path in FS
multi MAIN(Str:D $fs) {
    say longest-absolute-path($fs);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;

    @tests.push(%( input => "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2",
                   output => 0));
    @tests.push(%( input => "file1.txt\nfile2.ext\na.png",
                   output => 9));
    @tests.push(%( input => "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
                   output => 38));
    @tests.push(%( input => "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt",
                   output => 14));
    @tests.push(%( input => "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt",
                   output => 32));
    @tests.push(%( input => "",
                   output => 0));
    @tests.push(%( input => "file1.txt\nfile100.txt\n\tsubdir",
                   output => 9));

    plan @tests + 3;
    for @tests {
        is longest-absolute-path(.<input>), .<output>, "{ .<input>.raku }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'foo.bar', :out, :err);
    is $proc.out.slurp(:close).trim, '7', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
