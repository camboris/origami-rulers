lado();

module lado(lados=4, largo_exterior=200, ancho_lado=12.5, alto=3) {
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
                cylinder(alto * 2, d=agujero_tercios, center=true, $fn=30);

            translate([_offset_lado_interior + (largo_lado_interior / 3) * i, ancho_lado - 3, alto/2])
                cylinder(alto * 2, d=agujero_tercios, center=true, $fn=30);
        }
    };
}
