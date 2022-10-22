# The Weekly Challenge 187
# Task 1 Days Together
# extended Perl script
use v5.30.0;
use warnings;
use Date::Simple;

if ($ARGV[0]) {
    say days_tgt({"SD"=>$ARGV[0], "ED"=>$ARGV[1]}, 
                 {"SD"=>$ARGV[2], "ED"=>$ARGV[3]});
}

sub days_tgt {
    my %foo = $_[0]->%*;
    my %bar = $_[1]->%*;
    my %Foo;
    my %Bar;
    if (Date::Simple->new($foo{"SD"}) < Date::Simple->new($bar{"SD"})) {
        %Foo = ("SD"=>Date::Simple->new($foo{"SD"}), 
                "ED"=>Date::Simple->new($foo{"ED"})); 
        %Bar = ("SD"=>Date::Simple->new($bar{"SD"}), 
                "ED"=>Date::Simple->new($bar{"ED"}));
    }
    else {
        %Foo = ("SD"=>Date::Simple->new($bar{"SD"}), 
                "ED"=>Date::Simple->new($bar{"ED"})); 
        %Bar = ("SD"=>Date::Simple->new($foo{"SD"}), 
                "ED"=>Date::Simple->new($foo{"ED"}));
    }
    return 0 if $Foo{"ED"} < $Bar{"SD"};
    return 1 if $Foo{"ED"} == $Bar{"SD"};
    if ($Bar{"ED"} <= $Foo{"ED"}) {
        return days_diff_incl($Bar{"ED"}, $Bar{"SD"});
    }
    else {
        return days_diff_incl($Foo{"ED"}, $Bar{"SD"});
    }
}

sub days_diff_incl {
    return 0 if $_[0] < $_[1];
    my $dn = $_[0];
    my $do = $_[1];
    my $days_diff_incl = $dn - $do + 1;
    return $days_diff_incl;
}


use Test::More tests=>4;
ok days_tgt( {"SD"=>'2022-01-12', "ED"=>'2022-01-20'}, 
             {"SD"=>'2022-01-15', "ED"=>'2022-01-18'}) 
    == 4;

ok days_tgt( {"SD"=>'2022-03-02', "ED"=>'2022-03-12'}, 
             {"SD"=>'2022-03-13', "ED"=>'2022-03-14'}) 
    == 0;

ok days_tgt( {"SD"=>'2022-03-02', "ED"=>'2022-03-12'}, 
             {"SD"=>'2022-03-11', "ED"=>'2022-03-15'}) 
    == 2;

ok days_tgt( {"SD"=>'2022-03-30', "ED"=>'2022-04-05'}, 
             {"SD"=>'2022-03-28', "ED"=>'2022-04-02'}) 
    == 4;

