//-- a = lado exterio

anillos = [50, 100, 150, 200];

regla(values=anillos);

module regla(lados=4, param="a", values=anillos ) {
    for(a = anillos) {
        anillo(largo_exterior=a);
    }
}

/*//-- cuadrado*/
/*anillo(largo_exterior=200);*/
/*anillo(largo_exterior=150);*/
/*anillo(largo_exterior=100);*/
/*anillo(largo_exterior=50);*/

//-- permitir pasar R y r, y calcular lo que haga falta
//-- https://www.calculatorsoup.com/calculators/geometry-plane/polygon.php
//-- dependiendo del poligono, pasamos un dato u otro
module anillo(lados=4, largo_exterior=100) {
    // divido asi para poder calcular los angulos con trigonometria
    _angulo = 360 / (lados * 2);
    // esta es el radio del circulo interior del poligono, lo uso para saber cuanto desplazarlo
    _inradius = -largo_exterior / 2  * 1 / tan(_angulo);
    for(i=[1:lados]) {
        rotate(_angulo * 2 * i)
            translate([-largo_exterior / 2, _inradius, 0])
            lado(lados = lados, largo_exterior = largo_exterior);
    }
}

module lado(lados=4, largo_exterior=200, ancho_lado=12.5, alto=2) {
    _angulo_esquina = 360 / lados / 2;
    _offset_lado_interior = ancho_lado * tan(_angulo_esquina);
    largo_lado_interior = largo_exterior - _offset_lado_interior * 2;
    //-- es el alto de la parte de abajo, donde corre el lapiz e inicia el chanfle
    _alto_base = 1;


    agujero_tercios = 2;

    _corte_esquina = ancho_lado * 2;

    //-- define cuanto es ancho del chanfle del borde
    _offset_chanfle = 3;

    angulo_chanfle = 35;
    alto_chanfle = 1.5;
    // translate([-largo_exterior/2, 0, 0])
    difference() {
        //-- hace los chanfle
        hull() {
            cube([largo_exterior, ancho_lado, _alto_base]);

            translate([0, _offset_chanfle, _alto_base])
                cube([largo_exterior, ancho_lado - _offset_chanfle * 2, alto - _alto_base]);
        }

        //-- corta las esquinas
        rotate([0, 0, -_angulo_esquina])
            translate([-_corte_esquina, 0, -_corte_esquina / 2])
            cube([_corte_esquina, _corte_esquina, _corte_esquina]);


        translate([largo_exterior, 0, -_corte_esquina / 2])
            rotate([0, 0, _angulo_esquina])
            cube([_corte_esquina, _corte_esquina, _corte_esquina]);


        //-- hace los agujeros de los tercios
        for(i=[1:2]) {
            translate([(largo_exterior / 3) * i, 3, alto/2])
                cylinder(alto, d1=agujero_tercios, d2=agujero_tercios*2, center=true, $fn=30);

            translate([_offset_lado_interior + (largo_lado_interior / 3) * i, ancho_lado - 3, alto/2])
                cylinder(alto, d1=agujero_tercios, d2=agujero_tercios*2, center=true, $fn=30);
        }
    };
}
