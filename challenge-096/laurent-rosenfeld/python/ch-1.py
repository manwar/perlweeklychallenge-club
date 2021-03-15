def reverse_words(in_str):
    words = in_str.split()
    words.reverse()
    return " ".join(words)

input = "    Perl and   Raku are  part of the same family  "
print(reverse_words(input))
