include <reg-common.scad>;

regla(ancho=100, lados=6, anillos=3);
echo(valores()[0]);

function valores(valor_base=200, lados=6) = 
    let ( _angulo = 360 / (lados * 2) )
    let (_a = 2 * valor_base * sin(_angulo))
    let ( _inradius = valor_base * cos(_angulo) )
    [_angulo, _a, _inradius];

