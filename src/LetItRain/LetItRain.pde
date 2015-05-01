import ddf.minim.*;

import java.util.Iterator;
import java.util.Map;

Minim minim;
AudioSnippet backgroundSound;

PGraphics pg;
Thunder thunder;

final int numDrops = 10000;
HashMap droplets = new HashMap();

void setup() {
  size(displayWidth, displayHeight);
  frameRate(30);
  pg = createGraphics(displayWidth, displayHeight);
  smooth();
  setupAudio();
  setupThunder();
  setupRain();
}

void stop() {
  thunder.stop();
  backgroundSound.close();
  minim.stop();
  super.stop();
}

void setupAudio() {
  minim = new Minim(this);

  // Initialize background
  backgroundSound = minim.loadSnippet("background_rain.wav");
  backgroundSound.loop(999);
  backgroundSound.setGain(10);
}

void setupRain() {
  for (int i = 0; i < numDrops; i++) {
    droplets.put(i, new Droplet(i));
  }
}

void setupThunder() {
  thunder = new Thunder(minim.loadSample("thunder.mp3", 2048));
}

void draw() {

  pg.background(0);

  pg.beginDraw();
  pg.noStroke();

  pg.loadPixels();

  updateRain();
  drawRain(pg);

  pg.updatePixels();

  thunder.update(pg);

  pg.endDraw();
  image(pg, 0, 0);
}

void updateRain() {

  Object[] dropletsAsArray = droplets.values().toArray();
  for (int i = 0; i < dropletsAsArray.length; i++) {
    ((Droplet)dropletsAsArray[i]).update();
  }
}

void drawRain(PGraphics pg) {
  Iterator i = droplets.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) {
    Map.Entry e = (Map.Entry)i.next();
    ((Droplet)e.getValue()).draw(pg);
  }
}

boolean sketchFullScreen() {
  return true;
}
