#!/usr/bin/env raku
use Test;

is-deeply secret-santa(["Mr. Wall", "Mrs. Wall", "Mr. Anwar",
                        "Mrs. Anwar", "Mr. Conway", "Mr. Cross"]),
          {
              "Mrs. Anwar" => "Mr. Conway", 
              "Mr. Conway" => "Mr. Cross", 
              "Mr. Cross"  => "Mrs. Wall", 
              "Mrs. Wall"  => "Mr. Anwar", 
              "Mr. Anwar"  => "Mr. Wall", 
              "Mr. Wall"   => "Mrs. Anwar"
          }

is-deeply secret-santa(["Mr. Wall", "Mrs. Wall", "Mr. Anwar"]),
          {
              "Mr. Anwar" => "Mrs. Wall", 
              "Mr. Wall"  => "Mr. Anwar", 
              "Mrs. Wall" => "Mr. Wall"
          }

# Example from Peter Campbell Smith
is-deeply secret-santa(["Rudolph Reindeer", "Dasher Reindeer", 
                        "Dancer Reindeer",  "Prancer Reindeer", 
                        "Vixen Reindeer",   "Comet Reindeer",
                        "Cupid Reindeer",   "Donner Reindeer", 
                        "Blitzen Reindeer", "Santa Claus", 
                        "Mrs. Claus",       "Subordinate Claus"]),
          {
              "Donner Reindeer"   => "Mrs. Claus",
              "Blitzen Reindeer"  => "Subordinate Claus",
              "Cupid Reindeer"    => "Santa Claus",
              "Dancer Reindeer"   => "Dasher Reindeer",
              "Comet Reindeer"    => "Vixen Reindeer",
              "Dasher Reindeer"   => "Rudolph Reindeer",
              "Vixen Reindeer"    => "Prancer Reindeer",
              "Rudolph Reindeer"  => "Blitzen Reindeer",
              "Prancer Reindeer"  => "Dancer Reindeer",
              "Santa Claus"       => "Comet Reindeer",
              "Subordinate Claus" => "Donner Reindeer",
              "Mrs. Claus"        => "Cupid Reindeer",
          }

sub secret-santa(@names)
{
    my %surname = @names.classify({ .words[1..*].join(" ") });

    my @r = gather given %surname.values.sort.Array
    {
        while .elems
        {
            take .head.pop;
            .head ?? $_ .= rotate !! .shift
        }
    }

    @r.push(@r.head).rotor(2 => -1).flat.pairup.Hash
}
