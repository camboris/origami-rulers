alto = 5;
ancho = 15;
largo = 100;
gap_papel_ancho = 5;
gap_papel_alto = 2;
ancho_regla = 30;

module puntera(diametro=10) {
  cylinder(h=alto, d=diametro, center = true);
};

module base() {
  largo_base = largo - ancho;
  color("red")
    cube([ancho, largo_base, alto], true);

  color("green")
    /* translate([- gap_papel_ancho / 2, largo_base / 2, 0]) */
    /*   puntera(diametro = ancho - gap_papel_ancho); */
    translate([0, largo_base / 2, 0]) 
    puntera(diametro = ancho);

  translate([0, -largo_base / 2, 0]) 
    puntera(diametro = ancho);
}


module portaRegla(adjust = 1) {
  color("blue")
    translate([0, 0, alto/3*2 * adjust])
    rotate([0, 0, -45])
    cube([80, ancho_regla, alto], true);
}

module guiaPapel() {
  // guia papel
  color("green")
    translate([ancho / 2 - gap_papel_ancho / 2, 0, alto / 2 - gap_papel_alto * 2])
    cube([gap_papel_ancho, largo, gap_papel_alto], true);
}

module gapRegla() {
  alto_gap_regla = largo;
  dx = ancho / 2 - gap_papel_ancho / 2;
  intersection() {
    portaRegla(adjust = 0);
    translate([dx, 0, 0])
      cube([gap_papel_ancho, alto_gap_regla, 30], true);
  }

  intersection() {
    translate([dx, 0, 0])
      cube([gap_papel_ancho, alto_gap_regla, 30], true);

    cubo_side = gap_papel_ancho * 2 * sin(45);
    cubo_dx = ancho / 2;
    cubo_dy = 30 * sin(45) - cubo_side * sin(45) / 2;
    color("purple")
      translate([cubo_dx, cubo_dy, 0])
      rotate([0, 0, -45])
      /* translate([-cubo_dx , 30 * tan(45), 0]) */
      cube([cubo_side, cubo_side, 20], true);
  }
}

module guia45() {
  difference() {
    base();
      guiaPapel();

    translate([0, 10, 0]) {
      portaRegla();
      gapRegla();
    }
  }

  ancho_peg = 4;
  translate([-ancho / 2 - ancho_peg / 2, -5, 0])
  rotate([0, 90, 0])
  cylinder(h=ancho_peg, d=2.5, center= true);

  translate([-ancho / 2 - ancho_peg / 2, largo / 2 - ancho / 2 - 1, 0])
  rotate([0, 90, 0])
  cylinder(h=ancho_peg, d=2.5, center= true);
}

translate([-10, 0, 0])
  guia45();

  translate([10, 0, 0])
mirror([1, 0, 0]) 
  guia45();
