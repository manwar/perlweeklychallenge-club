#!/usr/bin/env python
# -*- coding: utf-8 -*-


def sparkline(n):
    max_val = max(n)

    spark_chars = [
        "\u2581",
        "\u2582",
        "\u2583",
        "\u2584",
        "\u2585",
        "\u2586",
        "\u2587",
        "\u2588",
    ]

    sparkline = ""
    for i in n:
        height = int(i / max_val * (len(spark_chars) - 1))
        sparkline += spark_chars[height]

    return sparkline


print(sparkline([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
