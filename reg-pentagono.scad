include <reg-common.scad>;

regla(ancho=200, lados=5, anillos=4);
echo(valores()[0]);

function valores(valor_base=200, lados=5) = 
    let ( _angulo = 360 / (lados * 2) )
    let ( _R = valor_base / 2 )
    let (_a = 2 * _R * sin(_angulo))
    let ( _inradius = _R * cos(_angulo))
    [_angulo, _a, _inradius];


