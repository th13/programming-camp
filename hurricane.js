'use strict';

// Radius in miles
const projections = [
  {
    lat: 27.000,
    long: -86.000,
    rad: 0.5
  },
  {
    lat: 28.5,
    long: -85.5,
    rad: 1
  },
  {
    lat: 30.5,
    long: -84.5,
    rad: 3
  },
  {
    lat: 31.3,
    long: -81.9,
    rad: 6
  }
];

let loc = {
  lat: 33,
  long: -90
};

// Calculate distance between geolocation and hurricane point estimate.
let distance = (geoloc, point) => {
  return Math.sqrt(Math.pow(geoloc.lat - point.lat, 2) + Math.pow(geoloc.long - point.long, 2));
};

// -1 means use lowest circle, -2 means use highest
let betweenWhichPoints = (geoloc, points) => {
  for (let i = 0; i < points.length - 1; i++) {
    if (geoloc.lat <= points[i].lat) {
      return -1;
    }
    else if (geoloc.lat > points[i].lat && geoloc.lat < points[i + 1].lat) {
      return i;
    }
  }

  return -2;
};

let heightOfTri = (loc, p1, p2) => {
  let d1 = distance(loc, p1);
  let d2 = distance(loc, p2);
  let base = distance(p1, p2);

  let p = (d1 + d2 + base) / 2;
  let A = Math.sqrt(p * (p - d1) * (p - d2) * (p - base));

  return (2 * A) / base;
};

let avgRad = (rad1, rad2) => {
  return (rad1 + rad2) / 2;
};

let start =  betweenWhichPoints(loc, projections);

if (start === -1) {
  if (distance(loc, projections[0]) > projections[0].rad) {
    console.log(false);
  }
  else console.log(true);
}
else if (start === -2) {
  if (distance(loc, projections[projections.length - 1]) > projections[projections.length - 1].rad) {
    console.log(false);
  }
  else console.log(true);
}
else {
  let inHurricane = (dist, rad) => {
    if (dist <= rad) {
      return true;
    }
    return false;
  };

  let height = heightOfTri(loc, projections[start], projections[start + 1]);
  //console.log(height);

  console.log(inHurricane(height, avgRad(projections[start], projections[start + 1])));

}
