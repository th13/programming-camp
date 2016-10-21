'use strict';

let surface = {
  height: 1000,
  width: 1000
};

let circles = [{
  x: 50,
  y: 50,
  radius: 1
},
{
  x: 50,
  y: 50,
  radius: 1
}
];


let distance = (p1, p2) => {
  return Math.sqrt(Math.pow(p1.x - p2.x) + Math.pow(p1.y, p2.y));
};

let dots = [];
for (let i = 0; i < surface.width; i++) {
  dots[i] = new Array();
  for (let j = 0; j < surface.height; j++) {
    dots[i][j] = 0;
  }
}
let area = 0;
  for (let i = 0; i < surface.width; i++) {
    for (let j = 0; j < surface.height; j++) {
      circles.forEach((c) => {
        if (distance(c, dots[i][j]) <= c.radius) {
          dots[i][j] = 1;
        }
      });
    }
  }


for (let i = 0; i < surface.width; i++) {
  for (let j = 0; j < surface.height; j++) {
    area += dots[i][j];
  }
}

console.log(area);
