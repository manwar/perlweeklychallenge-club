#!/usr/bin/env perl6

$_= @*ARGS.join(" ");
my $matches=m:g/\{.*?\}/;
my @entries;
@entries.push:	[.Str.split: /<[\{\}\,]>/, :skip-empty] for $matches.list;

expand($_,[],@entries,$matches.list).map(*.say);

sub expand($line,@stack,@entries, @positions) {
        my @results;
        if (@stack == @entries ) {
                my $l=$line;
                my $offset=0;
                for @stack.keys {
                        $l.substr-rw(@positions[$_].from-$offset, @positions[$_].chars)=@stack[$_];
                        $offset+=@positions[$_].chars-@stack[$_].chars;
                }
                return ($l,);
        }
        else {
                my @s;
                my @e=|@entries[@stack.elems];
                for @e  {
                        @s= (|@stack[], |$_);
                        @results.push( |expand($line, @s,@entries, @positions));
                }
                return @results;
        }
}
