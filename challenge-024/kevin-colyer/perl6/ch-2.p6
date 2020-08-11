#!/usr/bin/perl6
use v6;

use Test;

# 24.2 Create a script to implement full text search functionality using Inverted Index. According to wikipedia:

# In computer science, an inverted index (also referred to as a postings file or inverted file) is a database index storing a mapping from content, such as words or numbers, to its locations in a table, or in a document or a set of documents (named in contrast to a forward index, which maps from documents to content). The purpose of an inverted index is to allow fast full-text searches, at a cost of increased processing when a document is added to the database.

class DocumentStore {

    enum DocStoreStat <Nothing ENotInDatabase AddOK RemoveOK EAlreadyInDatabase ENoColonsInDocumentName>;

    has @!documents;
    has %!documentNames;
    has %!index;

    method addDocument ($name,$document) returns DocStoreStat {
        return EAlreadyInDatabase if  %!documentNames{$name}:exists;
        return ENoColonsInDocumentName if $name ~~ / \: /;
        @!documents.push: $document;
        %!documentNames{$name}=@!documents.elems-1;
        self!indexDocument($name);
        return AddOK;
    };

    method removeDocument ($name) returns DocStoreStat {
        return ENotInDatabase if  %!documentNames{$name}:!exists;

        for %!index.keys -> $k {
            %!index{$k} = %!index{$k}.grep({ if  !/ ^ $name ":" / { $_ } });
            %!index{$k}:delete unless %!index{$k}.elems;
        }

        @!documents[%!documentNames{$name}]=Nil; # remove by zeroing - don't splice or indexes will change!
        %!documentNames{$name}:delete;
        return RemoveOK;
    };

    method getDocument($name) {
        return ENotInDatabase if  %!documentNames{$name}:!exists;
        return @!documents[%!documentNames{$name}];
    };

    method search($needle){
        return Nothing if %!index{$needle}:!exists;
        return %!index{$needle};
    };

    method indexElems() returns Int {
        %!index.elems;
    }

    method elems() returns Int {
        @!documents.elems;
    }

    # private method
    method !indexDocument($name){
        my Str $doc=@!documents[%!documentNames{$name}];
        my Int $i=0;
        my Str $word;
        while $i < $doc.chars  {
            #say "$i: "~$doc.substr($i);
            $doc.substr($i) ~~ m/ (\W*) (\w+) /;
            #say $/;
            $i+=$/[0].chars if $/[0] ;
            last unless $/[1];
            $word=$/[1].lc;
            %!index{$word}.push: "$name:$i";
            $i+=$word.chars;
        }
        return;
    };
}


multi MAIN("test") {
    my $doc1="This is a TEST!";
    my $doc1Name="test1";
    my $doc2="this: is also is a test";
    my $doc2Name="test2";
    my $ds = DocumentStore.new();
    is $ds.search("test"),DocumentStore::Nothing,"Not in database, returns <Nothing>";
    is $ds.removeDocument($doc1Name),DocumentStore::ENotInDatabase,"Can't remove a document that is not in store";
    is $ds.addDocument($doc1Name,$doc1),DocumentStore::AddOK,"Document added";
    is $ds.addDocument("bad:name",$doc1),DocumentStore::ENoColonsInDocumentName,"Bad file name - no colons allowed (for now!)";
    is $ds.indexElems,4,"4 words indexed";
    is $ds.elems,1,"1 document indexed";
    is $ds.addDocument($doc1Name,$doc1),DocumentStore::EAlreadyInDatabase,"Document previously added";
    is $ds.addDocument($doc2Name,$doc2),DocumentStore::AddOK,"Document added";
    is $ds.indexElems,5,"5 words indexed - checks normalisation too";
    is $ds.elems,2,"2 documents indexed";
    is $ds.getDocument("foo"),DocumentStore::ENotInDatabase,"getDocument not in index";
    is $ds.getDocument($doc2Name),$doc2,"getDocument return document stored";
    is $ds.removeDocument("test"),DocumentStore::ENotInDatabase,"Can't remove a document that is not in database";
    is $ds.search("test"),["$doc1Name:10","$doc2Name:19"],"Two items found";
    is $ds.search("is"),["$doc1Name:5","$doc2Name:6","$doc2Name:14"],"Three items found";
    is $ds.removeDocument($doc1Name),DocumentStore::RemoveOK,"Remove OK";
    is $ds.search("is"),["$doc2Name:6","$doc2Name:14"],"Two items found - index pruned after document removal";
    my @result=|$ds.search("is");
    for @result -> $item {
        my ($n,$i)=|$item.split(":");
        is $ds.getDocument($n).substr($i,2),"is","[$n,$i] Correctly found search item at character pos";
    }
    done-testing;
}
