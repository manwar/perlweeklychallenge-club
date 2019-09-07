use strict;
use warnings;
use 5.010;

die "Usage:\n\tch-2.pl <search word(s)> <files> \n\nExample:\n\tch-2.pl \"i sing eat and love\" file1.txt file2.txt\n\n" if @ARGV < 2;

#Set the minimum length of words to be included
my $minimum_length = 1;

# Get the words to search. Convert it to lowercase. 
# Use as keys in a hash to get only unique words
my %hash_words = map { lc $_ => 1 } shift=~/([^, ]+) *,?/g;
# Retrieve the keys and store in @words
my @words = keys %hash_words;

# Create index from files
my @files = @ARGV;
my %index;
for my $file (@files) {
    open(my $fh, "<", $file);
    while(<$fh>) {
        for my $w (grep { y///c >=$minimum_length } /(\w+) ?/g) {
            $index{lc $w}{lc $file=~s/^\.\\//r}++
        }
	}
    close($fh);
}

use Text::Table::Tiny 'generate_table';
sub print_search_result {
    #Show search result
    my $rows;
    push @{$rows} , ["Words","File(s)"];
    for my $w (sort @words) {
        my $sub;
        for my $f (sort keys %{$index{$w}}) {
            $sub .= "$f ";
        }
        push @{$rows} , [$w,$sub||"(N/A)"];
    }
    print generate_table(rows => $rows, header_row => 1);
}

sub show_index {
    #Show File Index
    my $rows;
    push @{$rows} , ["Words","File(s)"];
    for my $w (sort keys %index) {
        my $sub;
        for my $f (sort keys %{$index{$w}}) {
            $sub .= "$f ";
        }
        push @{$rows} , [$w,$sub];
    }
    print generate_table(rows => $rows, header_row => 1);
}

&print_search_result;

=begin
perl .\ch-2.pl "i sing eat and love" .\file1.txt .\file2.txt .\file3.txt .\file4.txt .\file5.txt
+-------+--------------------------------+
| Words | File(s)                        |
+-------+--------------------------------+
| and   | file1.txt file2.txt            |
| eat   | file4.txt                      |
| i     | file1.txt file2.txt file4.txt  |
| love  | file2.txt file5.txt            |
| sing  | (N/A)                          |
+-------+--------------------------------+
=cut