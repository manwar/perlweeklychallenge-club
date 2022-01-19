#! /usr/bin/perl6

use Test;
plan 6;

is-deeply(eertree('redivider'),[<r redivider e edivide d divid i ivi v>],'example 1');
is-deeply(eertree('deific'),[<d e i ifi f c>],'example 2');
is-deeply(eertree('rotors'),[<r rotor o oto t s>],'example 3');
is-deeply(eertree('challenge'),[<c h a l ll e n g>],'example 4');
is-deeply(eertree('champion'),[<c h a m p i o n>],'example 5');
is-deeply(eertree('christmas'),[<c h r i s t m a>],'example 6');


class Eernode {
    has %.edges is rw;
    has $.link is rw;
    has $.len is rw;
    has $.id is rw;

    method init {
        self.len=0;
        self.edges={};
        self.id=rand;
        return self;
    }
}

class Eertree {
    has @.nodes is rw;
    has $.rto is rw;
    has $.rte is rw;
    has @.S is rw;
    has $.maxSufT is rw;

    method init {
        self.nodes=[];
        self.rto=Eernode.new.init;
        self.rte=Eernode.new.init;
        self.rte.link=self.rto;
        self.rte.id="rte";
        self.rto.link=self.rto;
        self.rto.len=-1;
        self.rto.id="rto";
        self.S=["0"];
        self.maxSufT=self.rte;
        return self;
    }

    method get_max_suffix_pal($startnode,$a) {
        my $u=$startnode;
        my $i=self.S.elems;
        my $k=$u.len;
        while ($u.id ne 'rto' && self.S[$i-$k-1] ne $a) {
            if ($u.id eq $u.link.id) {
                last;
            }
            $u=$u.link;
            $k=$u.len;
        }
        return $u;
    }

    method add($a) {
        my $q=self.get_max_suffix_pal(self.maxSufT,$a);
        my $newnode=!($q.edges{$a}:exists);
        if ($newnode) {
            my $p=Eernode.new.init;
            self.nodes.push($p);
            $p.len=$q.len+2;
            if ($p.len==1) {
                $p.link=self.rte;
            } else {
                $p.link=self.get_max_suffix_pal($q.link,$a).edges{$a} or die "bad link";
            }
            $q.edges{$a}=$p;
            self.maxSufT=$q.edges{$a};
            self.S.push($a);
        }
        return $newnode;
    }

    method add_str($st) {
        for $st.comb() -> $a {
            self.add($a);
        }
    }

    method get_sub_palindromes($nd,@nodestohere,@charstohere,$result) {
        for $nd.edges.keys -> $lnkName {
            my $nd2=$nd.edges{$lnkName};
            my @nh=@nodestohere;
            @nh.push($nd2);
            my @ch=@charstohere;
            @ch.push($lnkName);
            self.get_sub_palindromes($nd2,@nh,@ch,$result);
        }
        if ($nd.id ne 'rto' && $nd.id ne 'rte') {
            my $temp=@charstohere.join('');
            my $revtemp=$temp.flip;
            my $assembled='';
            if (@nodestohere[0].id eq 'rte') {
                $assembled = $revtemp ~ $temp;
            } else {
                $assembled = $revtemp ~ substr($temp,1);
            }
            $result.push($assembled);
        }
    }

}

sub eertree($st) {
  my $eertree=Eertree.new.init;
  $eertree.add_str($st);
  my $result=[];
  $eertree.get_sub_palindromes($eertree.rto,
                                [$eertree.rto],
                                [],
                                $result);
  $eertree.get_sub_palindromes($eertree.rte,
                                [$eertree.rte],
                                [],
                                $result);
  my $q=$result.SetHash;
  my @res;
  for 0..chars($st)-1 -> $i {
    for $i..chars($st)-1 -> $j {
      my $k=substr($st,$i,$j-$i+1);
      if ($q{$k}:exists) {
        $q{$k}:delete;
        push @res,$k;
      }
    }
  }
  return @res;
}
