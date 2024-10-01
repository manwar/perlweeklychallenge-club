#!/usr/bin/env raku

my $text = chomp q:to/END/; 
           This supposed Cambridge research is unfortunately an urban
           legend. However, the effect has been studied. For example—
           and with a title that probably made the journal’s editor a 
           little nervous—Raeding wrods with jubmled lettres: there is 
           a cost by Rayner, White, et. al. looked at reading speed and 
           comprehension of jumbled text.
           END

say jumbled-letters($text);

sub jumbled-letters($text)
{
    my @split = $text.split(/ \s+ || \— || \- /, :v);

    for @split[0,2...*]
    {
        my @chars = .comb;
        my @alphas = @chars.grep(* (elem) ['a'...'z','A'...'Z'], :k);
        @chars[@alphas[1..*-2]] .= pick(*);
        $_ = [~] @chars
    }

    [~] @split
}
