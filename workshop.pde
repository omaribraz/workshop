import processing.opengl.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.processing.*;
import java.util.Iterator;
import java.util.*;
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import hypermedia.net.*;
import peasy.org.apache.commons.math.geometry.*;

import peasy.*;

import java.util.Map;
import controlP5.*;

import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

PeasyCam cam;
PShape obj;

int xmaxint;
int ymaxint;
int xminint;
int yminint;
int zminint;
int zmaxint;

WB_Render render;
HE_Mesh mesh;
WB_KDTree vertexTree;

ArrayList xMax = new ArrayList();
ArrayList yMax = new ArrayList();
ArrayList zMax = new ArrayList();
ArrayList  meshpts= new ArrayList();

Flock flock;

void setup() {
  size(1400, 800, P3D);
  smooth();
  flock = new Flock();
  cam = new PeasyCam(this, 2000, 2000, 0, 3000);
  perspective();
  obj = loadShape("data/"+"drone2.obj");
  obj.scale(.5);

  meshrun();

  for (int i = 0; i <1; i++) {
    flock.addBoid(new Boid(0, 0, 70));
  }
}

void draw() {
  background(0);
  flock.run();


  pushMatrix();
  fill(40);
  //noStroke();
  strokeWeight(.1);
  stroke(10);
  lights();
  render.drawFaces(mesh);
  popMatrix();
}