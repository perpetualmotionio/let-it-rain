class Lightning {

  int fillColor;
  float increment = 5;

  Lightning() {
      this.fillColor = 255;
  }

  void update(PGraphics pg) {
    if (this.isFlashing())
    {
      background(this.fillColor);

      // This needs to be logarithmic
      this.fillColor -= increment;
    }
  }

  boolean isFlashing() {
    return this.fillColor > 0;
  }

  int lightningFill() {
      return this.fillColor;
  }
}
