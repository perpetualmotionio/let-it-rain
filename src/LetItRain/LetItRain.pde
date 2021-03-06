import ddf.minim.*;
import java.util.Iterator;
import java.util.Map;
import SimpleOpenNI.*;

Minim minim;
AudioSnippet backgroundSound;
AudioSnippet backgroundSoundWhenDetected;

SimpleOpenNI context;
PGraphics pg;
PFont f;

Thunders thunders;

final float scale = 1.0;
final int numDrops = 20000;

final boolean shouldTakePhotos = false;
final String saveDirectory = "/Users/ryankanno/Projects/Makerfaire/let-it-rain-images/";
final int milliSecondsBetweenImageSaves = 30000;
int timer = 0;

String timestamp;

HashMap drops = new HashMap();

void setup() {
  size((int)(640 * scale), (int)(480 * scale), P3D);
  background(0);
  pg = createGraphics(width, height);
  f = createFont("Helvetica", 32, true);
  smooth();
  setupAudio();
  setupKinect();
  setupThunders();
  setupRain();
}


void stop() {
  thunders.stop();
  backgroundSound.close();
  minim.stop();
  super.stop();
  exit();
}

void setupAudio() {
  minim = new Minim(this);

  // Initialize background
  backgroundSound = minim.loadSnippet("rain.wav");
  backgroundSound.loop(999);
  backgroundSound.setGain(10);

  // Initialize background when detected
  backgroundSoundWhenDetected = minim.loadSnippet("background_rain.wav");
  backgroundSoundWhenDetected.loop(999);
  backgroundSoundWhenDetected.setGain(-10);
}

void setupRain() {
  for (int i = 0; i < numDrops; i++) {
    drops.put(i, new Drop(i, context));
  }
}

void setupThunders() {
  thunders = new Thunders(minim, context);
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
  frame.setTitle(int(frameRate) + " fps");

  background(0);

  context.update();

  pg.background(0, 0);

  pg.beginDraw();
  pg.noStroke();

  pg.loadPixels();
  updateRain();
  drawRain(pg);

  thunders.update(pg);

  pg.updatePixels();
  pg.endDraw();

  image(pg, 0, 0);
  screenShot();
}

// TODO: Make more fancy
void screenShot() {
  if (millis() - timer >= milliSecondsBetweenImageSaves) {
    if (shouldTakePhotos) {
      timestamp = year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
      save(saveDirectory + timestamp + ".jpg");
    }
    timer = millis();
  } else if (millis() - timer >= milliSecondsBetweenImageSaves - 1000) {
    textFont(f,32);
    fill(color(255,0,0));
    text("1", width - 40, 50);

    stroke(color(255, 0, 0));
    strokeWeight(20);
    noFill();
    rect(0, 0, width, height);

  } else if (millis() - timer >= milliSecondsBetweenImageSaves - 2000) {
    textFont(f,32);
    fill(color(255,0,0));
    text("2", width - 40, 50);
  } else if (millis() - timer >= milliSecondsBetweenImageSaves - 3000) {
    textFont(f,32);
    fill(color(255,0,0));
    text("3", width - 40, 50);
  } else if (millis() - timer >= milliSecondsBetweenImageSaves - 4000) {
    textFont(f,32);
    fill(color(255,0,0));
    text("4", width - 40, 50);
  } else if (millis() - timer >= milliSecondsBetweenImageSaves - 5000) {
    textFont(f,32);
    fill(color(255,0,0));
    text("5", width - 40, 50);
  }
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
  return false;
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI currContext, int userId) {
  if (currContext.getUsers().length > 0)
  {
    backgroundSound.setGain(-10);
    backgroundSoundWhenDetected.setGain(10);
  }
}

void onLostUser(SimpleOpenNI currContext, int userId) {
  if (currContext.getUsers().length == 1 || currContext.getUsers().length == 0)
  {
    backgroundSoundWhenDetected.setGain(-10);
    backgroundSound.setGain(10);
  }
}

void onVisibleUser(SimpleOpenNI currContext, int userId) {
  // println("onVisibleUser - userId: " + userId);
}

void onOutOfSceneUser(SimpleOpenNI curContext, int userId)
{
}
