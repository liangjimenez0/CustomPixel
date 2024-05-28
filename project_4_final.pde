import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;

PImage img1;
PImage img2;

color color11;
color color12;
color color13;
color color14;
color color15;
color color16;
color color17;
color color18;
color color19;
color color110;

color color21;
color color22;
color color23;
color color24;
color color25;
color color26;
color color27;
color color28;
color color29;
color color210;

ArrayList<Pixel> colors1 = new ArrayList<>();
ArrayList<Pixel> colors2 = new ArrayList<>();

ArrayList<Pixel> colors1Old = new ArrayList<>();
ArrayList<Pixel> colors2Old = new ArrayList<>();

color[] allColors1 = new color[10];
color[] allColors2 = new color[10];

int currentImage = 0;
int frameDelay = 60; 
int frameCounter = 0;
boolean imagesLoaded = false;

void setup() {
  size(800, 800);

  allColors1[4] = color(102, 127, 165);
  allColors1[3] = color(142, 131, 136);
  allColors1[6] = color(183, 153, 147);
  allColors1[0] = color(21, 24, 20);
  allColors1[7] = color(140, 165, 194);
  allColors1[2] = color(110, 98, 93);
  allColors1[8] = color(196, 199, 193);
  allColors1[9] = color(241, 171, 145);
  allColors1[1] = color(68, 68, 65);
  allColors1[5] = color(179, 117, 89);

  allColors2[7] = color(200, 214, 226);
  allColors2[6] = color(189, 204, 218);
  allColors2[0] = color(18, 20, 5);
  allColors2[8] = color(211, 225, 233);
  allColors2[5] = color(176, 193, 209);
  allColors2[1] = color(56, 49, 25);
  allColors2[4] = color(201, 143, 106);
  allColors2[9] = color(245, 180, 135);
  allColors2[3] = color(154, 113, 87);
  allColors2[2] = color(107, 77, 59);

  img1 = loadImage("71122669794__45178198-8709-4C32-A7C6-20C195C4F82D.jpeg");
  img1.resize(400, 400);

  img2 = loadImage("IMG_5476.jpeg");
   
  img2.resize(400, 400);

  img1.loadPixels();

  for (int x = 0; x < img1.width; x+=1) {
    for (int y = 0; y < img1.height; y+=1) {
      color pix = img1.get(x, y);
      colors1.add(new Pixel(x, y, pix));
      colors1Old.add(new Pixel(x, y, pix));
    }
  }

  img2.loadPixels();

  for (int x = 0; x < img2.width; x+=1) {
    for (int y = 0; y < img2.height; y+=1) {
      color pix = img2.get(x, y);
      colors2.add(new Pixel(x, y, pix));
      colors2Old.add(new Pixel(x, y, pix));
    }
  }

  for (Pixel p : colors1Old) {
    p.findClosestColor(allColors1);
  }

  for (Pixel p : colors2Old) {
    p.findClosestColor(allColors2);
  }

  for (Pixel p : colors2) {
    p.findClosestColor(allColors1);
  }

  for (Pixel p : colors1) {
    p.findClosestColor(allColors2);
  }

  imagesLoaded = true;
  frameRate(30);
}

void draw() {
  if (imagesLoaded) {
    if (currentImage < 10) {
      if (frameCounter >= frameDelay) {
        frameCounter = 0; // Reset the frame counter
        drawNextImage();
      } else {
        frameCounter++;
      }
    } else {
      noLoop(); // Stop looping when all images are displayed
    }
  }
}

void drawNextImage() {
  if (currentImage == 0) {
    drawAllColoredPixels(allColors1[0]);
    drawAllColoredPixels(allColors2[0]);
  } else if (currentImage == 1) {
    drawAllColoredPixels(allColors1[1]);
    drawAllColoredPixels(allColors2[1]);
  } else if (currentImage == 2) {
    drawAllColoredPixels(allColors1[2]);
    drawAllColoredPixels(allColors2[2]);
  } else if (currentImage == 3) {
    drawAllColoredPixels(allColors1[3]);
    drawAllColoredPixels(allColors2[3]);
  } else if (currentImage == 4) {
    drawAllColoredPixels(allColors1[4]);
    drawAllColoredPixels(allColors2[4]);
  } else if (currentImage == 5) {
    drawAllColoredPixels(allColors1[5]);
    drawAllColoredPixels(allColors2[5]);
  } else if (currentImage == 6) {
    drawAllColoredPixels(allColors1[6]);
    drawAllColoredPixels(allColors2[6]);
  } else if (currentImage == 7) {
    drawAllColoredPixels(allColors1[7]);
    drawAllColoredPixels(allColors2[7]);
  } else if (currentImage == 8) {
    drawAllColoredPixels(allColors1[8]);
    drawAllColoredPixels(allColors2[8]);
  } else if (currentImage == 9) {
    drawAllColoredPixels(allColors1[9]);
    drawAllColoredPixels(allColors2[9]);
  }

  currentImage++; // Move to the next image
}



class Pixel {
  int x;
  int y;
  color fill;

  Pixel(int x, int y, color fill) {
    this.x = x;
    this.y = y;
    this.fill = fill;
  }

  void changeFill(color newColor) {
    this.fill = newColor;
  }

  void findClosestColor(color[] colors) {
    float pixelBrightness = brightness(this.fill);
    if (pixelBrightness <= 25) {
      this.fill = colors[0];
    } else if (pixelBrightness <= 50) {
      this.fill = colors[1];
    } else if (pixelBrightness <= 75) {
      this.fill = colors[2];
    } else if (pixelBrightness <= 100) {
      this.fill = colors[3];
    } else if (pixelBrightness <= 125) {
      this.fill = colors[4];
    } else if (pixelBrightness <= 150) {
      this.fill = colors[5];
    } else if (pixelBrightness <= 175) {
      this.fill = colors[6];
    } else if (pixelBrightness <= 200) {
      this.fill = colors[7];
    } else if (pixelBrightness <= 225) {
      this.fill = colors[8];
    } else {
      this.fill = colors[9];
    }
  }
}


void drawPixelatedImage(ArrayList<Pixel> pixels, int locationX, int locationY, color fill) {
  for (Pixel p : pixels) {

    if (p.fill == fill) {
      rectMode(CENTER);
      stroke(p.fill);
      fill(p.fill);
      rect(p.y + locationX, p.x + locationY, 5, 5);
    }
  }
}

void drawAllColoredPixels(color fill) {
  drawPixelatedImage(colors1Old, 0, 0, fill);
  drawPixelatedImage(colors1, 0, 400, fill);
  drawPixelatedImage(colors2Old, 400, 0, fill);
  drawPixelatedImage(colors2, 400, 400, fill);
}
