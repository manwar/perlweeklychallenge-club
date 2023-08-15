#!/usr/bin/env python3


def count_words_with_prefix(prefix, *words):
    return len([word for word in words if word.find(prefix) == 0])


if __name__ == "__main__":
    print(count_words_with_prefix("at", "pay", "attention", "practice", "attend"))
    print(count_words_with_prefix("ja", "janet", "julia", "java", "javascript"))
