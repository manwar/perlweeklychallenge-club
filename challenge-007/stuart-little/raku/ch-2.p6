#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    $source-word,
    $target-word,
    Str :f(:$file),
) {
    
    my @words=($file) ?? ($file.IO.lines) !! ($=finish.lines);

    my %conn=mkhash(@words);    my %cur=($source-word=>True);    my %vis=@words.map({ $_ => () }); %vis{$source-word}=($source-word,);

    say fndpth($source-word,$target-word,%conn,%cur,%vis);
    
}

sub dist($w1,$w2) { ($w1.comb Zne $w2.comb).sum }; sub mkhash(@w) { @w.map({ $_ => @w.grep( -> $w {dist($_,$w)==1} ).Array }).Hash }

sub fndpth($s,$t,%conn,%cur,%vis) {    
    while (
	(%conn.{%cur.keys}.map(|*) (-) %vis.grep({ $_.value }).Hash.keys) && (! %vis{$t})
    ) {
	my %next=(%conn.{%cur.keys}.map(|*) (-) %vis.grep({ $_.value }).Hash.keys);
	for %cur.keys {
	    %conn{$_}.map(-> $node {%vis{$node}||=(|%vis{$_},$node)})
	}
	%cur=%next;
    }
    (%vis{$t}) && %vis{$t} || ()
}

=finish
cold
cord
core
care
card
ward
warm


