#!/usr/bin/env python
# -*- coding: utf-8 -*-


def order_sentence(paragraph: str) -> str:
    sentences = paragraph.split(".")
    ordered = []

    for sentence in sentences:
        if sentence.strip() == "":
            continue
        words = sorted(sentence.split())
        ordered.append(" ".join(words) + ".")

    return " ".join(ordered)


# Tests
assert (
    order_sentence("All he could think about was how it would all end.")
    == "All about all could end he how it think was would."
)
assert (
    order_sentence(
        "There was still a bit of uncertainty in the equation, but the basics were there for anyone to see."
    )
    == "There a anyone basics bit but equation, for in of see still the the there to uncertainty was were."
)
assert (
    order_sentence("The end was coming and it wasn't going to be pretty.")
    == "The and be coming end going it pretty to was wasn't."
)
