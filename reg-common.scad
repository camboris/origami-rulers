//-- https://www.calculatorsoup.com/calculators/geometry-plane/polygon.php
//-- http://mathafou.free.fr/pbg_en/sol118.html

// CONST
//-- es el alto de la parte de abajo, donde corre el lapiz e inicia el chanfle
ALTO_TOTAL = 2.5;
ALTO_BASE = 1;
// diametro de los agujeros de los tercios
DIAM_TERCIOS = 2;
//-- define cuanto es ancho del chanfle del borde
OFFSET_CHANFLE = 5;


// Conectores

ANCHO_CONECTOR = 3;
SEPARACION_CONECTOR = 1;

// grosor del anillo
ANCHO_LADO = 12.5;

module regla(lados=4, ancho=200, anillos = 4) {
    _dif_anillos = ancho / anillos;
    _sep_anillos = get_inradius(get_largo_lado(ancho)) / anillos;
    echo("Regla Ancho:", ancho, " Anillos: ", anillos, "Separacion: ", _sep_anillos);

    for(i=[1:anillos]) {
        if(i > 1) {
          anillo(
            num_anillo=i,
            valor_base=i * _dif_anillos,
            lados=lados,
            ancho_separacion =_sep_anillos);
        } else {
          anillo(
            num_anillo=i,
            valor_base=i * _dif_anillos,
            lados=lados,
            ancho_separacion = 0);
        }
    }
}

module anillo(num_anillo, lados=4, valor_base=200, ancho_separacion=50) {
    // echo("anillo", lados, valor_base);
    _angulo = get_angulo(lados) / 2;
    _largo_lado = get_largo_lado(valor_base);
    _inradius = get_inradius(_largo_lado);
    echo("Anillo ", num_anillo, "largo externo:", _largo_lado, " interno: ", largoLadoInterior(ANCHO_LADO, _angulo, _largo_lado), " desplazamiento: ", _inradius);
    for(i=[1:lados]) {
        rotate(_angulo * 2 * i)
            translate([-_largo_lado / 2, -_inradius, 0])
                lado(angulo_esquina = _angulo,
                    largo_lado = _largo_lado,
                    largo_union=ancho_separacion,
                    alto=ALTO_TOTAL);
    }
}

function largoLadoInterior(ancho_lado, angulo_esquina, largo_lado) = largo_lado - ancho_lado * tan(angulo_esquina) * 2;

module lado(angulo_esquina = 45, largo_lado=200, ancho_lado=12.5, alto=2, largo_union=10) {
    _angulo_esquina = angulo_esquina;
    _offset_lado_interior = ancho_lado * tan(_angulo_esquina);
    largo_lado_interior =largoLadoInterior(ancho_lado, angulo_esquina, largo_lado);

    _corte_esquina = ancho_lado * 2;

    // conectores
    _offset_conector = ANCHO_CONECTOR / 2 + SEPARACION_CONECTOR / 2;
    translate([largo_lado / 2 + _offset_conector,
          largo_union / 2 + ancho_lado / 2,
          0])
      cube([ANCHO_CONECTOR, largo_union - ancho_lado, ALTO_BASE], center=true);
    translate([largo_lado / 2 - _offset_conector,
          largo_union / 2 + ancho_lado / 2,
          0])
      cube([ANCHO_CONECTOR, largo_union - ancho_lado, ALTO_BASE], center=true);

    difference() {
      //-- hace los chanfle
      hull() {
        cube([largo_lado, ancho_lado, ALTO_BASE]);

        translate([0, OFFSET_CHANFLE, ALTO_BASE])
          cube([largo_lado, ancho_lado - OFFSET_CHANFLE * 2, alto - ALTO_BASE]);
      }

      //-- corta las esquinas
      rotate([0, 0, -_angulo_esquina])
        translate([-_corte_esquina, 0, -_corte_esquina / 2])
        cube([_corte_esquina, _corte_esquina, _corte_esquina]);


      translate([largo_lado, 0, -_corte_esquina / 2])
        rotate([0, 0, _angulo_esquina])
        cube([_corte_esquina, _corte_esquina, _corte_esquina]);


      //-- hace los agujeros de los tercios
      for(i=[1:2]) {
        translate([(largo_lado / 3) * i, 3, alto/2])
          cylinder(alto, d1=DIAM_TERCIOS, d2=DIAM_TERCIOS*2, center=true, $fn=30);

        translate([_offset_lado_interior + (largo_lado_interior / 3) * i, ancho_lado - 3, alto/2])
          cylinder(alto, d1=DIAM_TERCIOS, d2=DIAM_TERCIOS*2, center=true, $fn=30);
      }
    };
}
