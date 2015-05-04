class Thunder {

    AudioSample thunderSound;
    SimpleOpenNI context;

    Lightning lightning;

    Thunder(AudioSample thunderSound, SimpleOpenNI context) {
      this.thunderSound = thunderSound;
      this.context = context;
    }

    void update(PGraphics pg) {
      if (null != lightning)
      {
        this.lightning.update(pg);
        if (this.lightning.isFlashing())
        {
          this.flashUser(pg);
        }
      }
    }

    void boom()
    {
      this.thunderSound.trigger();
      this.lightning = new Lightning();
    }

    void flashUser(PGraphics pg)
    {
      int[] userMap = this.context.userMap();
      for (int i = 0; i < userMap.length; i++)
      {
        if (userMap[i] != 0)
        {
          color c = color(lightning.lightningFill());
          pg.pixels[i] = this.makeBrighter(c, 1.5f);
        }
      }
    }

    color makeBrighter(color c, float multiplier)
    {
      float r = (c >> 16 & 0xFF) * multiplier;
      float g = (c >> 8 & 0xFF) * multiplier;
      float b = (c & 0xFF) * multiplier;

      return color(constrain(r, 0, 255),
                   constrain(g, 0, 255),
                   constrain(b, 0, 255));
    }

    void stop() {
      this.thunderSound.close();
    }
}
