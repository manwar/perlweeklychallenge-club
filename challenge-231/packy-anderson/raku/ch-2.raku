#!/usr/bin/env raku
 
use v6;

use Lingua::Conjunction;
use Lingua::EN::Numbers;

sub quoted_list ( *@list ) {
  # given a list, quote the elements and join them with commas
  my @quoted = @list.map: { qq{"$_"} };
  return @quoted.join(q{, });
}

sub passenger_details (Str $data) {
  $data ~~ /^ $<phone>=(\d ** 10) $<sex>=(\w ** 1) 
              $<age>=(\d ** 2) $<seat>=(\d ** 2) $/;
  return (~$<phone>, ~$<sex>, ~$<age>, ~$<seat>);
}

sub ages_only (*@list where {$_.all ~~ Str}) {
  return @list.map: {
    my ($phone, $sex, $age, $seat) = passenger_details($_);    
    $age.Int;
  }
}

sub count_senior_citizens (*@list where {$_.all ~~ Int}) {
  my @seniors = @list.grep: { $_ >= 60};
  return @seniors.elems;
}

sub solution (*@list where {$_.all ~~ Str}) {
  say 'Input: @list = (' ~ quoted_list(@list) ~ ')';
  my @ages  = ages_only(@list);
  my $count = @ages.elems;
  my $senior_count = count_senior_citizens(@ages);

  say "Output: $senior_count";
  say "";

  my $str = "The age[|s] of the passenger[|s] "
          ~ "in the given list [is|are] |list|.";
  say conjunction @ages, :$str;
  my $no       = $senior_count == 0 ?? 'no' !! $senior_count.Str;
  my $citizens = $senior_count == 1 ?? 'citizen' !! 'citizens';
  say "So we have $no senior $citizens.";
}

say "Example 1:";
solution("7868190130M7522","5303914400F9211","9273338290F4010");

say "";

say "Example 2:";
solution("1313579440F2036","2921522980M5644");

say "";

say "Example 3:";
solution("5188675309F6002");