#!/usr/bin/env perl
 
use v5.38;

use Lingua::EN::Inflexion qw( inflect wordlist );

sub quoted_array {
  return '("' . join('", "', @_) . '")';
}

sub passenger_details {
  my $data = shift;
  my($phone, $sex, $age, $seat) = unpack "A10A1A2A2", $data;
  return ($phone, $sex, $age, $seat);
}

sub ages_only {
  return map {
    my($phone, $sex, $age, $seat) = passenger_details($_);
    $age
  } @_;
}

sub count_senior_citizens {
  my @seniors = grep { $_ >= 60} @_;
  return scalar(@seniors);
}

sub solution {
  my @list = @_;
  say 'Input: @list = ' . quoted_array(@list);
  my @ages  = ages_only(@list);
  my $count = scalar(@ages);
  my $senior_count = count_senior_citizens(@ages);

  say "Output: $senior_count";
  say "";
  my $wordlist = wordlist(@ages);
  say inflect "<#d:$count>The <N:age> of the <N:passenger> "
            . "in the given list <V:is> $wordlist.";
  say inflect "So we have <#n:$senior_count> "
            . "senior <N:citizen>.";
}

say "Example 1:";
solution("7868190130M7522","5303914400F9211","9273338290F4010");

say "";

say "Example 2:";
solution("1313579440F2036","2921522980M5644");

say "";

say "Example 3:";
solution("5188675309F6002");