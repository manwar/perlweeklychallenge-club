#!/usr/bin/perl
use Modern::Perl;
use Text::Glob::Expand;

usage() unless @ARGV==1;

my $glob = Text::Glob::Expand->parse($ARGV[0]);
my $permutations = $glob->explode_format("");
say foreach (keys %{$permutations} );

sub usage {
        print <<EOU;
Usage: $0 'brace-expansion'

Note: 'brace-expansion' must be quoted to surpress bash brace expansion, ironic.
Examples:
        $0 'Perl {Daily,Weekly,Monthly,Yearly} Challenge'       # PWC 29
        $0 'It{{em,alic}iz,erat}e{d,}'                          # test from RosettaCode
        $0 '{,{,gotta have{ ,\, again\, }}more }cowbell!'       # ''
        $0 'mkdir -p ~/project/{src,docs,test,foo}'             # practical usage
        $0 'apt-get install lib{file-find-rule,test-more}-perl' # ''
EOU
        exit;
}
 

__END__

./ch-1.pl 'Perl {Daily,Weekly,Monthly,Yearly} Challenge'
Perl Daily Challenge
Perl Weekly Challenge
Perl Monthly Challenge
Perl Yearly Challenge

./ch-1.pl 'It{{em,alic}iz,erat}e{d,}'
Italicize
Iterate
Itemized
Italicized
Iterated
Itemize

./ch-1.pl '{,{,gotta have{ ,\, again\, }}more }cowbell!'
gotta have more cowbell!
more cowbell!
gotta have, again, more cowbell!
cowbell!
