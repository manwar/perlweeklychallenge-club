#!/usr/bin/env node

// Task 1: Scalable Vector Graphics (SVG)
//
// Scalable Vector Graphics (SVG) are not made of pixels, but lines, ellipses,
// and curves, that can be scaled to any size without any loss of quality. If
// you have ever tried to resize a small JPG or PNG, you know what I mean by
// “loss of quality”! What many people do not know about SVG files is, they
// are simply XML files, so they can easily be generated programmatically.
//
// For this task, you may use external library, such as Perl’s SVG library,
// maintained in recent years by our very own Mohammad S Anwar. You can instead
// generate the XML yourself; it’s actually quite simple. The source for the example
// image for Task //2 might be instructive.
//
// Your task is to accept a series of points and lines in the following
// format, one per line, in arbitrary order:
//
// Point: x,y
// Line: x1,y1,x2,y2
//
// Example:
// 53,10
// 53,10,23,30
// 23,30
//
// Then, generate an SVG file plotting all points, and all lines.
// If done correctly, you can view the output .svg file in your browser.

import { Plot, PlotPoint, PlotLine } from "./plot";

const input: string = `53,10
53,10,23,30
23,30`;

const plot: Plot = new Plot(
  input
    .split("\n")
    .map((line) => line.split(",").map(parseInt) as PlotPoint | PlotLine)
);
plot.toSvg();
