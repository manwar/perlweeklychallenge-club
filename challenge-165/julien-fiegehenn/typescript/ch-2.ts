#!/usr/bin/env node

// Task 2: Line of Best Fit
// When you have a scatter plot of points, a line of best fit is the line that
// best describes the relationship between the points, and is very useful in
// statistics. Otherwise known as linear regression, here is an example of what
// such a line might look like:
//
// The method most often used is known as the least squares method, as it is
// straightforward and efficient, but you may use any method that generates
// the correct result.
//
// Calculate the line of best fit for the following 48 points
//
// 333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
// 341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
// 284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
// 128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
// 215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
// 275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
//
// Using your rudimentary graphing engine from Task #1, graph all points,
// as well as the line of best fit.

import { Plot, PlotData, PlotPoint } from "./plot";

const input: string = `333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
`;

// read the input and get all the points
const points: PlotData = input
  .split("\n")
  .flatMap((line: string) => line.split(/\s+/))
  .filter((e: string) => !!e)
  .map((point: string) => point.split(",").map(Number) as PlotPoint);

// get all the bits for the calculation
const xSquared: number[] = [],
  xY: number[] = [],
  allX: number[] = [],
  allY: number[] = [];
points.forEach((p: PlotPoint) => {
  xSquared.push(p[0] ** 2);
  xY.push(p[0] * p[1]);
  allX.push(p[0]);
  allY.push(p[1]);
});
const numberOfPoints: number = points.length;

// helper function to sum up the arrays
const sum = (arr: number[]): number =>
  arr.reduce((partialSum, a) => partialSum + a, 0);
// m is the Slope of the line
const m: number =
  (numberOfPoints * sum(xY) - sum(allX) * sum(allY)) /
  (numberOfPoints * sum(xSquared) - sum(allX) ** 2);

// b is the Y interept
const b: number = (sum(allY) - m * sum(allX)) / numberOfPoints;

const plot: Plot = new Plot([...points, [1, m + b, 400, m * 400 + b]]);
plot.toSvg();
