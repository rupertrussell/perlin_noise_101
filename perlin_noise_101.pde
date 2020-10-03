// By Roni Kaufman
// inspired by https://www.instagram.com/p/B7F8Uwln0l3/?igshid=oijtmrzffmq2
// https://www.openprocessing.org/sketch/842192/
// perlin_noise_101 by Rupert Russell fork of Shade 3.6 by Roni Kaufman https://www.openprocessing.org/sketch/842192/
// 4 October 2020
// draws and saves grids of 1000 x 1000 x 10

float x = 0;
float t = 0;

float colors;
float resolutions;
float res = 1 / random(200, 1000);
float noice, digit, hue;
float density = random(10, 500);
int count = 0;
int gridCount=0;

int gridSize = 1000;
int xOffset = 0;
int yOffset = 0;


void setup() {
  size(10000, 10000);
  colorMode(HSB, 100);
  background(98);
  noStroke();
}

void draw() {

  for (float y = 0; y < gridSize; y += 0.5) {
    noice = noise(x * res, y * res, t);
    digit = floor(noice * density);
    float step = 1/density;
    for (float i = 0; i < 1; i += step) {
      if (noice >= i && noice < i + step) {
        if (digit % 2 == 0) {
          hue = map(noice, i, i + step, 0, 100);
        } else {
          hue = map(noice, i, i + step, 100, 0);
        }
      }
    }
    fill(hue);
    square(x + xOffset, y + yOffset, 1);
  }



  x += 0.5;

  if (x >= gridSize) {
    println("count = " + count);
    density = random(10, 500);
    t += 0.05;
    x = -1;
    count++;

    if (xOffset <= width) {
      xOffset = xOffset + gridSize;
    } else {
      xOffset = 0;
      yOffset = yOffset + gridSize;
    }
  }

  if (yOffset >= height + gridSize) {
    save(gridCount + ".png");
    gridCount ++;
    xOffset = 0;
    yOffset = 0;
    // exit();
  }
}

void mousePressed() {
  save("density = " + density + ".png");
  println("Saved density = " + density);
  // exit();
}
