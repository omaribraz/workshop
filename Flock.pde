class Flock {
  ArrayList<Boid> boids;
  ArrayList<trail> trailPop;

  Flock() {
    boids = new ArrayList<Boid>();
    trailPop = new ArrayList<trail>();
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);
    }
    for (int i = 0; i<trailPop.size(); i++) {
      trail t = (trail) trailPop.get(i);
      t.update();
    }
  }

  void addBoid( Boid b) {
    boids.add(b);
  }

  void addTrail( trail t) {
    trailPop.add(t);
  }

  void removeTrail( trail t) {
    trailPop.remove(t);
  }
}