#! /usr/bin/env raku

unit sub MAIN ($composer, $notes, $order, :v(:$verbose));

my @notes = $notes.words;
my @order = $order.words.map: * - 1;

say ": Order @order[]" if $verbose;

my @result;
@result[@order] = @notes;

say "{ $composer.uc } => @result[]";
