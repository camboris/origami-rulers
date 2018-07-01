lado();

module lado(lados=4, largo_exterior=200, ancho_lado=12.5) {
    _angulo_esquina = 360 / lados / 2;
    ancho_lado = 12.5;
    offset_lado_interior = ancho_lado * tan(_angulo_esquina);
    largo_lado_interior = largo_exterior - offset_lado_interior * 2;

    alto = 3;
    agujero_tercios = 2;

    _corte_esquina = ancho_lado * 2;

    angulo_chanfle = 35;
    alto_chanfle = 1.5;
    // translate([-largo_exterior/2, 0, 0])
    difference() {
        cube([largo_exterior, ancho_lado, alto]);

        translate([-largo_exterior/2, 0, alto_chanfle*sin(angulo_chanfle)])
            rotate([angulo_chanfle, 0, 0])
            cube([largo_exterior * 2, ancho_lado, alto]);

        mirror([0, 1, 0])
            translate([-largo_exterior/2, -ancho_lado, alto_chanfle*sin(angulo_chanfle)])
            rotate([angulo_chanfle, 0, 0])
            cube([largo_exterior * 2, ancho_lado, alto]);



        rotate([0, 0, -_angulo_esquina])
            translate([-_corte_esquina, 0, -_corte_esquina / 2])
            cube([_corte_esquina, _corte_esquina, _corte_esquina]);


        translate([largo_exterior, 0, -_corte_esquina / 2])
            rotate([0, 0, _angulo_esquina])
            cube([_corte_esquina, _corte_esquina, _corte_esquina]);


        for(i=[1:2]) {
            translate([(largo_exterior / 3) * i, 3, alto/2])
                cylinder(alto * 2, d=agujero_tercios, center=true, $fn=30);

            translate([offset_lado_interior + (largo_lado_interior / 3) * i, ancho_lado - 3, alto/2])
                cylinder(alto * 2, d=agujero_tercios, center=true, $fn=30);
        }
    };
}
