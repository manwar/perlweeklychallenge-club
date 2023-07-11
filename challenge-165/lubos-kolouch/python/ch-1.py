#!/usr/bin/env python
# -*- coding: utf-8 -*-

import xml.etree.ElementTree as ET


def generate_svg(points, lines):
    svg = ET.Element("svg", xmlns="http://www.w3.org/2000/svg", version="1.1")

    for point in points:
        circle = ET.SubElement(
            svg,
            "circle",
            cx=str(point[0]),
            cy=str(point[1]),
            r="1",
            stroke="black",
            fill="black",
        )

    for line in lines:
        line = ET.SubElement(
            svg,
            "line",
            x1=str(line[0]),
            y1=str(line[1]),
            x2=str(line[2]),
            y2=str(line[3]),
            stroke="black",
        )

    tree = ET.ElementTree(svg)
    tree.write("output.svg")


# testing
points = [(53, 10), (23, 30)]
lines = [(53, 10, 23, 30)]
generate_svg(points, lines)
