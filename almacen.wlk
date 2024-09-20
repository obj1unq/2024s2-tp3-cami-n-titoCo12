
object almacen {
    const property cosas = #{}
    var property bultosMax = 3

    method cargar(cosasD) {
        cosas.addAll(cosasD)
    }

    method totalBultos() {
        return (cosas.map({ cosa => cosa.valorBulto() })).sum()
    }
}