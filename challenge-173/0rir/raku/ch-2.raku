#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 2: Sylvester’s sequence    Submitted by: Mohammad S Anwar
Generate the first 10 members of Sylvester's sequence.
For info, refer to the wikipedia page.
=end comment

my @expect = « 2 3 7 43 1807 3263443 10650056950807
113423713055421844361000443
12864938683278671740537145998360961546653259485195807
165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
»;


my @sylvester = 2,3,{ $_ = 1 + ([×] @_) } … ∞;

die 'logic error' unless @expect eq @sylvester[0..9];

my $got ~= gather for @sylvester[ 0...9] { take $_ ~ "\n" };



