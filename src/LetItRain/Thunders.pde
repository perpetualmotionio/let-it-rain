class Thunders {

    final int numThunders = 4;
    final int initialMinTimeBetweenThunder = 5000;
    final int initialMaxTimeBetweenThunder = 15000;

    Thunder[] thunders;
    float nextThunderSound;

    Thunder currentThunder;

    Thunders(Minim minim, SimpleOpenNI context) {
      this.nextThunderSound = millis() + random(initialMinTimeBetweenThunder, initialMaxTimeBetweenThunder);
      this.thunders = new Thunder[numThunders];
      this.thunders[0] = new Thunder(minim.loadSample("thunder.mp3", 2048), context);
      this.thunders[1] = new Thunder(minim.loadSample("thunderclap1.wav", 2048), context);
      this.thunders[2] = new Thunder(minim.loadSample("thunderclap2.wav", 2048), context);
      this.thunders[3] = new Thunder(minim.loadSample("thunderclap3.wav", 2048), context);
      this.currentThunder = thunders[0];
    }

    void update(PGraphics pg) {
      if (millis() > (Float)this.nextThunderSound) {
        this.nextThunderSound = millis() + random(initialMinTimeBetweenThunder, initialMaxTimeBetweenThunder);
        this.currentThunder = thunders[int(random(0,4))];
        this.currentThunder.boom();
      }
      else
      {
        this.currentThunder.update(pg);
      }
    }

    void stop() {
      for (int i = 0; i < numThunders; i++)
      {
        thunders[i].stop();
      }
    }
}
