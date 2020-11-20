// Input
const N = [
  [0, 0, 0, 1, 1, 1],
  [1, 1, 1, 1, 1, 1],
  [0, 0, 1, 0, 0, 1],
  [0, 0, 1, 1, 1, 1],
  [0, 0, 1, 1, 1, 1],
];

// Largest Rectangle
const R = [];
let points = [];
let totalArea = 0;

for (let x = 0; x < N.length; x++) {
  if(R[x] === undefined) R[x] = [];

  for (let y = 0; y < N[0].length; y++) {
    if(N[x][y] === 1) {
      let left = 1, up = 1;
      let leftArea = 1, upArea = 1, maxArea = 1;
      let leftPoint = [], upPoint = [], maxPoint = [];

      // Count left and up values
      if(y > 0) left = R[x][y-1][0] + 1;
      if(x > 0) up = R[x-1][y][1] + 1;

      // Get maximum area on the left side
      if(y > 0) {
        let limitUp = up;
        let leftArea = up;
        leftPoint = [x - limitUp + 1, y];

        for(let d = 1; d < left; d++) {
          limitUp = Math.min(limitUp, R[x][y-d][1]);
          const area = (d + 1) * limitUp;

          if(area > leftArea) {
            leftArea = area;
            leftPoint = [x - limitUp + 1, y - d];
          }
        }
      }

      // Get maximum area on the upper side
      if(x > 0) {
        let limitLeft = left;
        upArea = left;
        upPoint = [x, y - limitLeft + 1];

        for(let d = 1; d < up; d++) {
          limitLeft = Math.min(limitLeft, R[x-d][y][0]);
          const area = (d + 1) * limitLeft;

          if(area > upArea) {
            upArea = area;
            upPoint = [x - d, y - limitLeft + 1];
          }
        }
      }

      // Get maximum area until now
      if(leftArea > upArea) {
        maxPoint = leftPoint;
        maxArea = leftArea;
      } else {
        maxPoint = upPoint;
        maxArea = upArea;
      }

      if(maxArea > totalArea) {
        points = [maxPoint[0], maxPoint[1], x, y];
        totalArea = maxArea;
      }

      R[x][y] = [left, up];
    } else {
      R[x][y] = [0, 0];
    }
  }
}

// Output
if(totalArea <= 1) {
  console.log('No rectangule was found on the matrix.');
} else {
  console.log(`Result rectangule is located between (${points[0]}, ${points[1]}) and (${points[2]}, ${points[3]}) with total area of ${totalArea}.`);
}