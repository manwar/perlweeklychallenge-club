//import svg = require("svg-builder");
import * as svg from "svg-builder";
import { SvgBuilder } from "svg-builder";
import * as fs from "fs";

type PlotPoint = [number, number];
type PlotLine = [number, number, number, number];
export type PlotData = [PlotPoint | PlotLine];

export class Plot {
  svg: SvgBuilder = svg;

  input: PlotData;
  constructor(input: any) {
    this.input = input;
    console.log(input);
  }

  toSvg(): boolean {
    this.input.forEach((record) => {
      if (record.length === 2) {
        console.log(record);
        this.addPoint(record);
      } else {
        this.addLine(record);
      }
    });

    this.svg = this.svg.width(200).height(200);

    try {
      fs.writeFileSync("output.svg", this.svg.render());
      return true;
    } catch (e) {
      return false;
    }
  }

  addPoint(point: PlotPoint): void {
    this.svg = this.svg.circle({
      r: 3,
      fill: "orange",
      stroke: "orange",
      cx: point[0],
      cy: point[1],
    });
  }

  addLine(line: PlotLine): void {
    this.svg = this.svg.line({
      stroke: "blue",
      fill: "blue",
      "stroke-width": 3,
      x1: line[0],
      y1: line[1],
      x2: line[2],
      y2: line[3],
    });
  }
}
