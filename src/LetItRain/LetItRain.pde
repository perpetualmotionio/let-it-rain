import ddf.minim.*;
import java.util.Iterator;
import java.util.Map;
import SimpleOpenNI.*;

Minim minim;
AudioSnippet backgroundSound;
SimpleOpenNI context;
PGraphics pg;

Thunder thunder;

final int scale = 1;

final int numDrops = 10000;
HashMap drops = new HashMap();

void setup() {
  size(640 * scale, 480 * scale, P3D);
  background(0);
  pg = createGraphics(width, height);
  smooth();
  setupAudio();
  setupKinect();
  setupThunder();
  setupRain();
}


void stop() {
  thunder.stop();
  backgroundSound.close();
  minim.stop();
  super.stop();
  exit();
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
    drops.put(i, new Drop(i, context));
  }
}

void setupThunder() {
  thunder = new Thunder(minim.loadSample("thunder.mp3", 2048), context);
}

void setupKinect() {
  context = new SimpleOpenNI(this);
  if (false == context.isInit()) {
     println("Kinect can't be initialized!");
     exit();
     return;
  }

  context.setMirror(true);
  context.enableDepth();
  context.enableUser();
}

void draw() {
  background(0);

  context.update();

  pg.background(0, 0);

  pg.beginDraw();
  pg.noStroke();

  pg.loadPixels();
  updateRain();
  drawRain(pg);

  thunder.update(pg);

  pg.updatePixels();
  pg.endDraw();

  image(pg, 0, 0);
}

void updateRain() {

  Object[] dropsAsArray = drops.values().toArray();
  for (int i = 0; i < dropsAsArray.length; i++) {
    ((Drop)dropsAsArray[i]).update();
  }
}

void drawRain(PGraphics pg) {
  Iterator i = drops.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) {
    Map.Entry e = (Map.Entry)i.next();
    ((Drop)e.getValue()).draw(pg);
  }
}

boolean sketchFullScreen() {
  return true;
}

void onNewUser(SimpleOpenNI context, int userId) {
}

void onLostUser(SimpleOpenNI curContext, int userId) {
}

void onVisibleUser(SimpleOpenNI curContext, int userId) {
}
