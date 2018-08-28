//-- a = lado exterio

/*anillo(lados=4);*/
regla(values=4, ancho=200, lados=4);

module regla(lados=4, ancho=200, anillos = 4) {
    _dif_anillos = ancho / anillos;
    for(i=[1:anillos]) {
        anillo(valor_base=i*_dif_anillos, lados=lados, ancho_separacion=_dif_anillos);
    }
}

/*//-- cuadrado*/
/*anillo(valor_base=200);*/
/*anillo(valor_base=150);*/
/*anillo(valor_base=100);*/
/*anillo(valor_base=50);*/

//-- permitir pasar R y r, y calcular lo que haga falta
//-- https://www.calculatorsoup.com/calculators/geometry-plane/polygon.php
//-- dependiendo del poligono, pasamos un dato u otro
module anillo(lados=4, valor_base=200, ancho_separacion=50) {
    echo("anillo", lados, valor_base);
    // divido asi para poder calcular los angulos con trigonometria
    _angulo = 360 / (lados * 2);
    // esta es el radio del circulo interior del poligono, lo uso para saber cuanto desplazarlo

        _a = valor_base;
        _inradius = valor_base / 2  * 1 / tan(_angulo);
    if(lados == 4) {
        _a = valor_base;
        _inradius = valor_base / 2  * 1 / tan(_angulo);
    }
    if(lados == 5) {
        //valor base es R, no r como en el cuadrado
        _R = valor_base / 2;
        _a = 2 * _R * sin(_angulo);
        _inradius = _R * cos(_angulo);
    }
    echo("_a, _inradius", _a, _inradius);
    for(i=[1:lados]) {
        rotate(_angulo * 2 * i)
            translate([-_a / 2, -_inradius, 0])
                lado(lados = lados, largo_lado = _a, largo_union=ancho_separacion);
    }
}

module lado(lados=4, largo_lado=200, ancho_lado=12.5, alto=2, largo_union=10) {
    _angulo_esquina = 360 / lados / 2;
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
    union() {
        translate([largo_lado / 2 - 3.5, ancho_lado, 0])
            cube([3, largo_union / 2 - ancho_lado, _alto_base]);
        translate([largo_lado / 2 + .5, ancho_lado, 0])
            cube([3, largo_union / 2 - ancho_lado, _alto_base]);
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
    };
}
