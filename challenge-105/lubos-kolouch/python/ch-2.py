#!/usr/bin/env python
# -*- coding: utf-8 -*-


def name_game(name: str) -> None:
    rest_of_name = name[1:]
    print(f"{name}, {name}, bo-b{rest_of_name},")
    print(f"Bonana-fanna fo-f{rest_of_name}")
    print(f"Fee fi mo-m{rest_of_name}")
    print(f"{name}!")


name_game(
    "Katie"
)  # Output: Katie, Katie, bo-batie, Bonana-fanna fo-fatie, Fee fi mo-matie, Katie!
