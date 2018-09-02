//-- https://www.calculatorsoup.com/calculators/geometry-plane/polygon.php
//

module regla(lados=4, ancho=200, anillos = 4) {
    _dif_anillos = ancho / anillos;
    _sep_anillos = valores()[2] / anillos;
    for(i=[1:anillos]) {
        anillo(valor_base=i*_dif_anillos, lados=lados, ancho_separacion=_sep_anillos);
    }
}
//-- dependiendo del poligono, pasamos un dato u otro
module anillo(lados=4, valor_base=200, ancho_separacion=50) {
    echo("anillo", lados, valor_base);
    // divido asi para poder calcular los angulos con trigonometria
    _valores = valores(valor_base);
    /*_angulo = 360 / (lados * 2);*/
    _angulo = _valores[0];
    // esta es el radio del circulo interior del poligono, lo uso para saber cuanto desplazarlo

    _a = _valores[1];
    _inradius = _valores[2];
    for(i=[1:lados]) {
        rotate(_angulo * 2 * i)
            translate([-_a / 2, -_inradius, 0])
                lado(angulo_esquina = _angulo, largo_lado = _a, largo_union=ancho_separacion);
    }
}

module lado(angulo_esquina = 45, largo_lado=200, ancho_lado=12.5, alto=2, largo_union=10) {
    _angulo_esquina = angulo_esquina;
    _offset_lado_interior = ancho_lado * tan(_angulo_esquina);
    largo_lado_interior = largo_lado - _offset_lado_interior * 2;
    //-- es el alto de la parte de abajo, donde corre el lapiz e inicia el chanfle
    _alto_base = 1;


    agujero_tercios = 2;

    _corte_esquina = ancho_lado * 2;

    //-- define cuanto es ancho del chanfle del borde
    _offset_chanfle = 3;

    angulo_chanfle = 35;
    alto_chanfle = 1.5;
            translate([largo_lado / 2 - 3.5, ancho_lado, 0])
                cube([3, largo_union - ancho_lado, _alto_base]);
            translate([largo_lado / 2 + .5, ancho_lado, 0])
                cube([3, largo_union - ancho_lado, _alto_base]);
        difference() {
            //-- hace los chanfle
            hull() {
                cube([largo_lado, ancho_lado, _alto_base]);

                translate([0, _offset_chanfle, _alto_base])
                    cube([largo_lado, ancho_lado - _offset_chanfle * 2, alto - _alto_base]);
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
                    cylinder(alto, d1=agujero_tercios, d2=agujero_tercios*2, center=true, $fn=30);

                translate([_offset_lado_interior + (largo_lado_interior / 3) * i, ancho_lado - 3, alto/2])
                    cylinder(alto, d1=agujero_tercios, d2=agujero_tercios*2, center=true, $fn=30);
            }
        };
}
