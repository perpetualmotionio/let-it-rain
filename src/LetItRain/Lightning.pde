class Lightning {

  static final float minBoltWidth = 3;
  static final float maxBoltWidth = 10;

  static final float minJumpLength = 1;
  static final float maxJumpLength = 10;

  int fillColor;
  float increment = 5;
  LightningBolt bolt;

  Lightning() {
      this.fillColor = 255;
  }

  void update(PGraphics pg) {
    if (this.isFlashing())
    {
      if (null == this.bolt)
      {
        this.bolt = new LightningBolt(random(0,width),0, random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength,color(0,0,99));
      }

      background(this.fillColor);

      this.bolt.draw();

      // This needs to be logarithmic
      this.fillColor -= increment;
    }
    else
    {
      this.bolt = null;
    }
  }

  boolean isFlashing() {
    return this.fillColor > 0;
  }

  int lightningFill() {
      return this.fillColor;
  }
}
