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

sub secret-santa(@names)
{
    my %surname = @names.classify({ .words[1] });

    my @r = gather given %surname.values.sort.Array
    {
        while .elems
        {
            take .head.pop;
            .head ?? $_ .= rotate !! .shift
        }
    }

    @r.push(@r.head).rotor(2 => -1).map({ .pairup.head }).Hash
}
