#!/usr/bin/env perl6

use lib '.';
use BhagavadGita;

# Usage:
#
# Print out your access token
# ./ch-3.p6 --client-id=FOO --client-secret=BAR
#
# Print list of chapters:
# ./ch-3.p6 --access-token=TOKEN --chapters
#
# Print specific verse:
# ./ch-3.p6 --access-token=TOKEN --chapter=1 --verse=1
# 
# etc


# Print out access token
multi MAIN( :$client-id!, :$client-secret! ) {
    say BhagavadGita.get-access-token( :$client-id, :$client-secret );
}

# Print list of chapters
multi MAIN( :$access-token!, Bool :$chapters! ) {
    my $api = BhagavadGita.new( :$access-token );
    my $json = $api.chapters();

    say $json.map(
        { "Chapter: {.<chapter_number>}, {.<name_meaning>}, Verses Count: {.<verses_count>}" }
    ).join("\n");
}

# Print chapter summary
multi MAIN( :$access-token!, Int :$chapter! ) {
    my $api = BhagavadGita.new( :$access-token );
    my $json = $api.chapter( :$chapter );

    say qq:to/END/;
    Chapter: {$json.<chapter_number>}, {$json.<name_meaning>}
    Verses Count: {$json.<verses_count>}
    Summary:
    {$json.<chapter_summary>}
    END
}

# Print all verses of all chapters (takes a while)
multi MAIN( :$access-token!, Bool :$verses! ) {
    my $api = BhagavadGita.new( :$access-token );
    my $json = $api.verses();

    say $json.map(
        { "Chapter {.<chapter_number>}, Verse {.<verse_number>}: {.<meaning>}" }
    ).join("\n");
}

# Print all verses in a chapter
multi MAIN( :$access-token!, Int :$chapter!, Bool :$verses! ) {
    my $api = BhagavadGita.new( :$access-token );
    my $json = $api.verses( :$chapter );

    say "Chapter: $json[0].<chapter_number>";
    say $json.map(
        { "Verse {.<verse_number>}: {.<meaning>}" }
    ).join("\n");
}

# Print a specific verse of a specific chapter
multi MAIN( :$access-token!, Int :$chapter!, Int :$verse! ) {
    my $api = BhagavadGita.new( :$access-token );
    my $json = $api.verse( :$chapter, :$verse );

    say qq:to/END/;
    Chapter: {$json.<chapter_number>}, Verse: {$json.<verse_number>}
    {$json.<meaning>}
    END
}


