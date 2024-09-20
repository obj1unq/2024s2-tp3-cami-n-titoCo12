object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method valorBulto() { return 1 }

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method reaccionCargar() {}
}


object bumblebee {
	var transformacion = auto
	method peso() { return 800 }
	method nivelPeligrosidad() {return transformacion.nivelPeligrosidad()}
	method valorBulto() {return 2}

	method seTransformaEnAuto() {
		transformacion = auto
	}

	method seTransformaEnRobot() {
		transformacion = robot
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method reaccionCargar() {
		self.seTransformaEnRobot()
	}
}

object auto {
	method nivelPeligrosidad() {return 15}
}

object robot {
	method nivelPeligrosidad() {return 30}
}

object ladrillos {
	var cantidad = 0
	method peso() {return cantidad * 2}
	method nivelPeligrosidad() {return 2}

	method cantidad() {
		return cantidad
	}

	method agregarLadrillos(cant) {
		cantidad += cant
	}

	method sacarLadrillos(cant) {
		cantidad -= cant
	}

	method valorBulto() {
		return if (cantidad.between(0, 100)) {1}
		else if (cantidad.between(101, 300)) {2}
		else {3}
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method reaccionCargar() {
		self.agregarLadrillos(12)
	}
}


object arena {
	var peso = 0
	method nivelPeligrosidad() {return 1}
	method valorBulto() {return 1}

	method peso() {
		return peso
	}

	method agregarPeso(cant) {
		peso += cant
	}

	method sacarPeso(cant) {
		peso -= cant
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method reaccionCargar() {
		self.agregarPeso(20)
	}
}


object bateria {
	var tieneMisiles = false

	method tieneMisiles() {
		return tieneMisiles
	}

	method cargaMisiles() {
		tieneMisiles = true
	}

	method remueveMisiles() {
		tieneMisiles = false
	}

	method peso() {
		return if (tieneMisiles) {300}
		else {200}
	}

	method nivelPeligrosidad() {
		return if (tieneMisiles) {100}
		else {0}
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method valorBulto() {
		return if (tieneMisiles) {2}
		else {1}
	}

	method reaccionCargar() {
		self.cargaMisiles()
	}
}


object contenedor {
	var property cosas = #{}

	method cargar(cosa) {
		cosas.add(cosa)
	} 

	method peso() {
		return 100 + (cosas.sum({ cosa => cosa.peso() }))
	}

	method nivelPeligrosidad() {
		return if (cosas.isEmpty()) {0}
		else {(cosas.map({ cosa => cosa.nivelPeligrosidad() })).max()}
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}
	
	method valorBulto() {
		return 1 + (cosas.sum({ cosa => cosa.valorBulto() }))
	}

	method reaccionCargar() {
		cosas.forEach({cosa => cosa.reaccionCargar()})
	}
}


object residuos {
	var peso = 0
	method nivelPeligrosidad() {return 200}
	method valorBulto() {return 1}


	method peso() {
		return peso
	}

	method agregarPeso(cant) {
		peso += cant
	}

	method sacarPeso(cant) {
		peso -= cant
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method reaccionCargar() {
		self.agregarPeso(15)
	}
}


object embalaje {
	var property cosaEmbalada = arena
	method peso() {return cosaEmbalada.peso()}
	method nivelPeligrosidad() {return (cosaEmbalada.nivelPeligrosidad()/2)}
	method valorBulto() {return 1}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method reaccionCargar() {}
}