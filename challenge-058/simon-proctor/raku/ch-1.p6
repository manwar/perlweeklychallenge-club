#!/usr/bin/env raku

use v6;

my $matcher = / ^ $<ver> = (\d+)+ % "." ( "_" $<patch> = (\d+) ) ? $ /;

subset ValidVer of Str where * ~~ $matcher;

class PWCVersion {
    
    has @.points;
    has Int $.patch; 
    multi method new ( ::?CLASS:U: ValidVer $str ) {
        my $match = $str ~~ $matcher;
        
        if defined $match[0]<patch> {
            self.bless(
                :points( $match<ver>.values.map(*.Int)  ),
                :patch( $match[0]<patch>.Int )
            );
        } else {
            self.bless(
                :points( $match<ver>.values.map(*.Int)  ),
            );
        }
    }

    method Str () {
        "{@!points.join('.')}{(defined $!patch)?? '_' ~ $!patch !! '' }"
    }

    method gist() { self.Str }
}

multi sub infix:<cmp> ( PWCVersion $v1, PWCVersion $v2 ) {
    return $v1.points cmp $v2.points unless ($v1.points cmp $v2.points) ~~ Same;

    return Same if ! $v1.patch && ! $v2.patch;
    return More if $v1.patch && ! $v2.patch;
    return Less if ! $v1.patch && $v2.patch;

    return $v1.patch <=> $v2.patch;
}

sub MAIN( ValidVer $str1, ValidVer $str2 ) {
    my $v1 = PWCVersion.new($str1);
    my $v2 = PWCVersion.new($str2);
    say "$v1 <=> $v2 : {+($v1 cmp $v2)}";
}
