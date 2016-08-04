class Flock {
  ArrayList<Boid> boids;
  ArrayList<trail> trailPop;
  ArrayList<printed> printPop;

  Flock() {
    boids = new ArrayList<Boid>();
    trailPop = new ArrayList<trail>();
    printPop = new ArrayList<printed>();
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);
    }
    for (int i = 0; i<trailPop.size(); i++) {
      trail t = (trail) trailPop.get(i);
      t.update();
    }
    for (int i = 0; i<printPop.size(); i++) {
      printed p = (printed) printPop.get(i);
      p.update();
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
  
   void addPrint( printed p) {
    printPop.add(p);
  }
 
}