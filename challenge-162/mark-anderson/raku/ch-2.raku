#!/usr/bin/env raku

use Test;

class playfair
{
    has $!key;
    has $!message;
    has $!result;
    has $!term;
    has %!coords;
    has @!table;
    has @!digrams;

    method table
    {
        @!table  = ($!key ~ ('a'..'z')).comb(/\S/).unique;
        my $i    =  @!table.first('i'|'j', :k).succ;
        my @tail =  @!table[$i..@!table.end].grep(/<-[ij]>/);
        @!table  = (@!table[^$i].Array.append(@tail)).rotor(5);
    }

    method coordinates
    {
        for ^5 X ^5 -> ($r, $c)
        {
            %!coords{@!table[$r;$c]} = ($r, $c);
        }
    }

    method digrams
    {
        loop
        {
            @!digrams = $!message.comb(/\S/).rotor(2, :partial);
            my $i = @!digrams.first({.head eq .tail}, :k);
            last unless defined $i;
            last if @!digrams[$i].elems == 1;
            $_ = (.head, 'x', .tail) given @!digrams[$i];
            $!message = @!digrams.join;
        }

        $_ = (.head, 'x') if .elems == 1 given @!digrams[*-1];
    }

    method encrypt
    {
        $!term = 1;
        self.process();
    }

    method decrypt
    {
        $!term = -1;
        self.process();
    }

    multi method process
    {
        for @!digrams -> $d
        {
            $!result ~= self.process($d);
        }
        
        return $!result;
    }

    multi method process($d)
    {
        my $h = %!coords{$d.head};
        my $t = %!coords{$d.tail};

        if $h.head eq $t.head
        {
            return @!table[$h.head;($h.tail + $!term) mod 5]
                 ~ @!table[$t.head;($t.tail + $!term) mod 5] 
        }

        if $h.tail eq $t.tail
        {
            return @!table[($h.head + $!term) mod 5;$h.tail]
                 ~ @!table[($t.head + $!term) mod 5;$t.tail]
        }

        return @!table[$h.head;$t.tail] 
             ~ @!table[$t.head;$h.tail]
    }
    
    method BUILD(:$key!, :$message!)
    {
        $!key     = $key;
        $!message = $message;
        self.table();
        self.coordinates();
        self.digrams();
    }
}

is playfair.new(:key('playfair example'), :message('hide the gold in the tree stump')).encrypt(),
'bmodzbxdnabekudmuixmmouvif';

is playfair.new(:key('playfair example'), :message('bmodzbxdnabekudmuixmmouvif')).decrypt(),
'hidethegoldinthetrexestump';

is playfair.new(:key('perl and raku'), :message('siderwrdulfipaarkcrw')).decrypt(),
'thewexeklychallengex';

is playfair.new(:key('perl and raku'), :message('the weekly challenge')).encrypt(),
'siderwrdulfipaarkcrw';

is playfair.new(:key('scaredy cat'), :message('eeeeeeek a mouse')).encrypt(),
'rzrzrzrzrzrzrlsomwcs';

is playfair.new(:key('scaredy cat'), :message('rzrzrzrzrzrzrlsomwcs')).decrypt(),
'exexexexexexekamouse';
