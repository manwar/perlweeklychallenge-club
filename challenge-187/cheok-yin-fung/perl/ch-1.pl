# The Weekly Challenge 187
# Task 1 Days Together
use v5.30.0;
use warnings;

if ($ARGV[0] ne "") {
    say days_tgt({"SD"=>"".$ARGV[0], "ED"=>"".$ARGV[1]},
                 {"SD"=>"".$ARGV[2], "ED"=>"".$ARGV[3]});
}

sub days_tgt {
    my %foo = $_[0]->%*;
    my %bar = $_[1]->%*;
    my %Foo;
    my %Bar;
    if (compare_date($foo{"SD"}, $bar{"SD"}) <= 0) {
        %Foo = %foo;
        %Bar = %bar;
    }
    else {
        %Foo = %bar;
        %Bar = %foo;
    }
    return 0 if compare_date($Foo{"ED"}, $Bar{"SD"}) < 0;
    return 1 if compare_date($Foo{"ED"}, $Bar{"SD"}) == 0;
    if (compare_date($Bar{"ED"}, $Foo{"ED"}) <= 0) {
        return days_diff_incl($Bar{"ED"}, $Bar{"SD"});
    }
    else {
        return days_diff_incl($Foo{"ED"}, $Bar{"SD"});
    }
}

sub get_month {
    return (split "-",$_[0])[1];
}

sub get_day {
    return (split "-",$_[0])[0];
}

sub days_diff_incl {
    my @month_days = (31, 28, 31, 30, 31, 30,
                      31, 31, 30, 31, 30, 31); # non-leap year
    return 0 if compare_date($_[0], $_[1]) < 0;
    my $dn = $_[0];
    my $do = $_[1];
    my $days_diff = 0;
    if (get_month($dn) > get_month($do)+1) {
        $days_diff += $month_days[$_-1] for get_month($do)+1..get_month($dn)-1;
    }
    if (get_month($dn) > get_month($do)) {
        $days_diff += $month_days[get_month($do)-1] - get_day($do) + 1;
    }
    if (get_month($dn) == get_month($do)) {
        $days_diff = get_day($dn)-get_day($do) + 1;
    }
    else {
        $days_diff += get_day($dn);
    }
    return $days_diff;
}

sub compare_date {
    my $dn = $_[0];
    my $do = $_[1];
    if (get_month($dn) > get_month($do)) {
        return 1;
    }
    else {
        if (get_month($dn) < get_month($do)) {
            return -1;
        }
        else {
            if (get_day($dn) > get_day($do)) {
                return 1;
            }
            else {
                if (get_day($dn) < get_day($do)) {
                    return -1;
                }
                else {
                    return 0;
                }
            }
        }
    }
}


use Test::More tests=>4;
ok days_tgt( {"SD"=>'12-01', "ED"=>'20-01'}, 
             {"SD"=>'15-01', "ED"=>'18-01'}) 
    == 4;

ok days_tgt( {"SD"=>'02-03', "ED"=>'12-03'}, 
             {"SD"=>'13-03', "ED"=>'14-03'}) 
    == 0;

ok days_tgt( {"SD"=>'02-03', "ED"=>'12-03'}, 
             {"SD"=>'11-03', "ED"=>'15-03'}) 
    == 2;

ok days_tgt( {"SD"=>'30-03', "ED"=>'05-04'}, 
             {"SD"=>'28-03', "ED"=>'02-04'}) 
    == 4;

