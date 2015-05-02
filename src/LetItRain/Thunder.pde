class Thunder {

    final int minTimeBetweenThunder = 5000;
    final int maxTimeBetweenThunder = 15000;

    AudioSample thunderSound;
    SimpleOpenNI context;

    float nextThunderSound;

    Lightning lightning;

    Thunder(AudioSample thunderSound, SimpleOpenNI context) {
      this.thunderSound = thunderSound;
      this.nextThunderSound = millis() + random(minTimeBetweenThunder, maxTimeBetweenThunder);
      this.context = context;
    }

    // This should probably be lightning, then thunder, but too lazy. :)
    void update(PGraphics pg) {
      if (millis() > (Float)this.nextThunderSound) {
        this.lightning = new Lightning();
        thunderSound.trigger();
        this.nextThunderSound = millis() + random(minTimeBetweenThunder, maxTimeBetweenThunder);
      } else {
        if (null != lightning) {
          lightning.update(pg);
          if (lightning.isFlashing())
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
