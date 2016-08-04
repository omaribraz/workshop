class printed {
  Vec3D pos;
  Vec3D orientation;

  printed(Vec3D p, Vec3D o) {
    pos = p.copy();
    orientation = o.copy();
    orientation = orientation.normalize();
  }

  void update() {
    render();
  }

  void render() {
    stroke(255,0,0);
    strokeWeight(6);
    point(pos.x, pos.y, pos.z);
  }
}