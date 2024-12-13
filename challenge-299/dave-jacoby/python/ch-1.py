#!/usr/bin/python3

import re
def main():
    examples = [
    {
        "words"    : [ "cat", "bat", "rat" ],
        "sentence" : "the cattle was rattle by the battery",
    },
    {
        "words"    : [ "a", "b", "c" ],
        "sentence" : "aab aac and cac bab",
    },
    {
        "words"    : [ "man", "bike" ],
        "sentence" : "the manager was hit by a biker",
    },
    {
        "words"    : [ "ca", "ma", "p", "zed" ],
        "sentence" : 'a man, a plan, a canal: panama',
    }
    ]
    for e in examples:
        output = replace_words(e)
        words = e["words"]
        sentence = e["sentence"]
        print(f'    Input:  sentence = "{sentence}"')
        print(f'            words = [{words}]')
        print(f"    Output: {output}")
        print("")

def replace_words( input ):
    words = input["words"]
    sentence = input["sentence"]
    for word in words:
        if word in sentence:
            sentence = re.sub( rf"\b{word}\w+", word, sentence )
    return sentence

if __name__ == "__main__":
    main()
