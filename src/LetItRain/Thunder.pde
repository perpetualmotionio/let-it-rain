class Thunder {

    final int minTimeBetweenThunder = 5000;
    final int maxTimeBetweenThunder = 25000;

    AudioSample thunderSound;
    float nextThunderSound;

    Lightning lightning;

    Thunder(AudioSample thunderSound) {
      this.thunderSound = thunderSound;
      this.nextThunderSound = millis() + random(minTimeBetweenThunder, maxTimeBetweenThunder);
    }

    void update(PGraphics pg) {
      if (millis() > (Float)this.nextThunderSound) {
          this.lightning = new Lightning();
          lightning.update(pg);
          thunderSound.trigger();
          this.nextThunderSound = millis() + random(minTimeBetweenThunder, maxTimeBetweenThunder);
      } else {
          if (null != lightning) {
            lightning.update(pg);
          }
      }
    }

    void stop() {
      this.thunderSound.close();
    }
}
