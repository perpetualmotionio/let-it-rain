class Lightning {

  color fillColor;
  float increment = 3;

  Lightning() {
      this.fillColor = 255;
  }

  void update(PGraphics pg) {
    if (this.fillColor > 0) {
      pg.background(this.fillColor);
      // This needs to be logarithmic
      if (this.fillColor > 0) {
        this.fillColor -= increment;
      }
    }
  }
}
