#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/options

type
  Point = tuple[x, y: float]
  Line = (Point, Point)

func getIntersection(l1, l2: Line): Option[Point] =
  ## can't handle co-linear lines
  let
    ix: Line =
      ((l1[1].x - l1[0].x, l1[1].y - l1[0].y), (l2[1].x - l2[0].x, l2[1].y - l2[0].y))
    s: float =
      (-ix[0].y * (l1[0].x - l2[0].x) + ix[0].x * (l1[0].y - l2[0].y)) /
      (-ix[1].x * ix[0].y + ix[0].x * ix[1].y)
    t: float =
      (ix[1].x * (l1[0].y - l2[0].y) - ix[1].y * (l1[0].x - l2[0].x)) /
      (-ix[1].x * ix[0].y + ix[0].x * ix[1].y)

  if s >= 0 and s <= 1 and t >= 0 and t <= 1:
    # Collision detected
    return some((l1[0].x + (t * ix[0].x), l1[0].y + (t * ix[0].y)))

  none(Point)

when isMainModule:
  import std/unittest

  const
    TestLines = [
      ((0.0, 0.0), (10.0, 10.0)), ((10.0, 0.0), (0.0, 10.0)),
      ((0.0, 0.0), (10.0, 10.0)), ((10.0, 0.0), (6.0, 4.0)),
    ]
    Expected = [some(Point (5.0, 5.0)), none(Point)]

  suite "Intersection of two lines":
    test "intersection detected":
      check getIntersection(TestLines[0], TestLines[1]) == Expected[0]
    test "no intersection":
      check getIntersection(TestLines[2], TestLines[3]) == Expected[1]
