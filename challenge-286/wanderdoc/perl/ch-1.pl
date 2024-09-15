#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a program which outputs one word of its own script / source code at random. A word is anything between whitespace, including symbols.
Example 1

If the source code contains a line such as: 'open my $fh, "<", "ch-1.pl" or die;'
then the program would output each of the words { open, my, $fh,, "<",, "ch-1.pl", or, die; }
(along with other words in the source) with some positive probability.

Example 2

Technically 'print(" hello ");' is *not* an example program, because it does not
assign positive probability to the other two words in the script.
It will never display print(" or ");

Example 3

An empty script is one trivial solution, and here is another:
echo "42" > ch-1.pl && perl -p -e '' ch-1.pl

=cut


self_print();


sub self_print
{
     my $file = $0;
     open my $in, "<", $0 or die "$!";

     my @txt;
     my $flag = 0;

     for my $line ( <$in> )
     {

          chomp $line;
          next if $line =~ /^\s*$/;
          next if $line =~ /^\s*#(?!\!perl)/; 
          if ( $line =~ /^=/ )
          {
               if ($flag == 0) {$flag = 1; next;}
               else            {$flag = 0; next;}
          }

          $line =~ s/#.*// if ($line !~ /#!perl/ and $line !~ /=~/); 
          push @txt, $line if ($flag == 0);;
     }

     my $full_txt = join(" ", @txt);
     my @filtered = split(/\s+/, $full_txt); 
     print $filtered[ int(rand(@filtered)) ], $/; # @filtered to make $#filtered possible.
}