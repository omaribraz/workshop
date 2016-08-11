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
ArrayList attpointsList = new ArrayList();
ArrayList nodePop;

Flock flock;

int nodetp = 3;
int nodebt = 2;

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
    flock.addBoid(new Boid(0, 0, 70,5));
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
  


  for (int i = 0; i < nodePop.size(); i++) {
    node t = (node) nodePop.get(i); 
    t.update();
  }
}

void readText() {
  String[] attptList = loadStrings("geo.txt");
  for (int i = attptList.length-1; i >= 0; i--) {
    float point[] = float(split(attptList[i], ','));
    if (point.length==3) {
      Vec3D Temp_PT = new Vec3D(point[0], point[1], point[2]);
      attpointsList.add(Temp_PT);
    }
  }
}