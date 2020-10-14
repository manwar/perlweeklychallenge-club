#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given file named input. Write a script to find the frequency of all the words.
It should print the result as first column of each line should be the frequency of the the word followed by all the words of that frequency arranged in lexicographical order. Also sort the words in the ascending order of frequency.
For the sake of this task, please ignore the following in the input file: . " ( ) , 's --
=cut







use Test::More;

use FindBin qw($Bin);
my $text = do { local $/; open my $in, "<", "$Bin/input.txt" or die "$!"; <$in> };
$text =~ tr/."(),//ds;
$text =~ s/\s+/ /g;
$text =~ s/'s//g;

$text =~ s/--/ /g;

my $expected = <<EXPECTED;
1 But City It Jet Juliet Latino New Romeo Side Story Their Then West York adaptation any anything at award-winning away become before begin best classic climactic coexist control dance do doesn't end ending escalates families feuding form former friend gains gangs goes happened hatred heartbreaking highway hoping in know love lovers meet meeting neither no one plan planning point romantic rumble run secret sends sister streets strikes terribly their two under understanding until violence warring what when where white whoever wins with wrong younger
2 Bernardo Jets Riff Sharks The by it led tragedy
3 Maria Tony a can of stop
4 to
9 and the
EXPECTED



my %count;
$count{$_}++ for split(/\s/,$text);


my %frequencies;
for my $word ( keys %count )
{

     push @{$frequencies{$count{$word}}}, $word;
}

my $output;

for my $num ( sort {$a <=> $b} keys %frequencies )
{
     $output .= join(' ', $num, sort { $a cmp $b } @{$frequencies{$num}}) . $/;
}

is($output, $expected, 'Matched');
done_testing();