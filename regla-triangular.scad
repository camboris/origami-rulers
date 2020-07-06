include <reg-common.scad>;

regla(ancho=200, lados=3, anillos=3);
echo(valores()[0]);

function valores(valor_base=200, lados=3) = 
    let ( _angulo = 360 / (lados * 2) )
    let (_a = valor_base)
    let ( _inradius = valor_base * cos(_angulo))
    [_angulo, _a, _inradius];

