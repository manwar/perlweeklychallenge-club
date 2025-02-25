#!/usr/bin/python3

import re

examples = []
examples.append(dict(string="weeklychallenge", words=["challenge", "weekly"]))
examples.append(dict(string="perlrakuperl", words=["raku", "perl"]))
examples.append(dict(string="sonsanddaughters", words=["sons", "sand", "daughters"]))


def word_break(example):
    string = example["string"]
    for word in example["words"]:
        if re.search(word, string):
            string = re.sub(word, "", string)
        else:
            return False
    return True


for example in examples:
    string = example["string"]
    words = ",".join(f'"{word}"' for word in example["words"])
    output = word_break(example)
    print(f'Input:   string = "{string}"')
    print(f"         words  = ({words})")
    print(f"Output:  {output}")
    print("")
