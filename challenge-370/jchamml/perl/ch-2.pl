use strict;
use warnings;

my $str1 = "abc";
my $str2 = "acb";
$str1 = "abcd";
$str2 = "cdba";
$str1 = "hello";
$str2 = "hiiii";
$str1 = "ateer";
$str2 = "eater";
$str1 = "abcd";
$str2 = "bdac";

my @list = scramble ($str1);
print "@list\n";
foreach my $str (@list) {
    if ($str eq $str2) {
        print "$str2 is a scramble of $str1\n";
        print "true\n";
        return 1 ;
    }
}
print "false\n";
return 0;


sub scramble {
    my $s1 = $_[0];
    return $s1 if (length($s1) == 1) ;
    my @scrambles;
    push @scrambles,$s1;
    my $l=length($s1);
    for (my $sp = 1; $sp < (length($s1)); $sp++) {
        my $ss1 = substr($s1,0,$sp);
        my $ss2 = substr($s1,$sp);
        my @ss1 = scramble($ss1);
        my @ss2 = scramble($ss2);
        for my $tss1 (@ss1) {
            for my $tss2 (@ss2) {
                push @scrambles, $tss2.$tss1 ;
                push @scrambles, $tss1.$tss2 ;
            }
        }
    }
    return uniq(@scrambles);
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
    
 

