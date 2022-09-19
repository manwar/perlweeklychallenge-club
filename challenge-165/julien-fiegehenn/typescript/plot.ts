//import svg = require("svg-builder");
import * as svg from "svg-builder";
import { SvgBuilder } from "svg-builder";
import * as fs from "fs";

export type PlotPoint = [number, number];
export type PlotLine = [number, number, number, number];
// export type PlotPoint = number[];
// export type PlotLine = number[];
export type PlotData = Array<PlotPoint | PlotLine>;

export class Plot {
  private svg: SvgBuilder = svg;

  private size: number = 200;

  input: PlotData;

  constructor(input: PlotData) {
    this.input = input;
  }

  toSvg(): boolean {
    this.input.forEach((record) => {
      if (record.length === 2) {
        this.addPoint(record);
      } else {
        this.addLine(record);
      }
    });

    this.svg = this.svg.width(this.size).height(this.size);

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

    this.size = Math.max(this.size, ...point);
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

    this.size = Math.max(this.size, ...line);
  }
}
