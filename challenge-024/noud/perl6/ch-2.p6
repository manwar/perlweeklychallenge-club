# Create a script to implement full text search functionality using Inverted
# Index. According to wikipedia:
#
# In computer science, an inverted index (also referred to as a postings file
# or inverted file) is a database index storing a mapping from content, such as
# words or numbers, to its locations in a table, or in a document or a set of
# documents (named in contrast to a forward index, which maps from documents to
# content). The purpose of an inverted index is to allow fast full-text
# searches, at a cost of increased processing when a document is added to the
# database.

sub MAIN(+@files) {
    my %inv_index;

    for @files -> $file {
        for $file.IO.words.unique -> $word {
            if %inv_index{$word}:exists {
                %inv_index{$word} = ($file, |(%inv_index{$word}));
            } else {
                %inv_index{$word} = ($file);
            }
        }
    }

    for %inv_index.kv -> $k, $v {
        "$k: $v".say;
    }
}


