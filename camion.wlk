import cosas.*
import almacen.*

object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMax = 2500
		

// El camión --------------------------------------------------------------

	method cargar(cosa) {
		cosa.reaccionCargar()
		cosas.add(cosa)
	}


	method descargar(cosa) {
		cosas.remove(cosa)
	}


	method todoPesoPar() {
		return cosas.all({ cosa => (cosa.peso()/2)*2 == (cosa.peso()) })
	}


	method hayAlgunoQuePesa(peso) {
		return cosas.any({ cosa => cosa.peso() == peso })
	}


	method elDeNivel(nivel) {
		return (cosas.find({ cosa => cosa.nivelPeligrosidad() == nivel }))
	}


	method pesoTotal() {
		return (tara + cosas.sum({ cosa => cosa.peso() }))
	}


	method excedidoDePeso() {
		return (self.pesoTotal() > pesoMax)
	}


	method objetosQueSuperanPeligrosidad(nivel) {
		return (cosas.filter({ cosa => cosa.nivelPeligrosidad() > nivel }))
	}


	method objetosMasPeligrososQue(cosa) {
		return (cosas.filter({ cosaD => cosaD.esMasPeligrosaQue(cosa) }))
	}


	method ningunoSuperaNivelDePeligro(niv) {
		return self.objetosQueSuperanPeligrosidad(niv) == []
	}

	method puedeCircularEnRuta(nivMaxPeligro) {
		 return (not(self.excedidoDePeso())) and
		 (self.objetosQueSuperanPeligrosidad(nivMaxPeligro) == [])
	}

// Agregados al camión ------------------------------------------------


	//¿Sería mejor hacerle a cada cosa un metodo "pesaEntre(min,max)" y usarlo aca?
	method tieneAlgoQuePesaEntre(min,max) {
		return (cosas.any({ cosa => (cosa.peso() >= min) and (cosa.peso() <= max) }))
	}

	method cosaMasPesada() {
		return (cosas.max({ cosa => cosa.peso() }))
	}

	method pesos() {
		return (cosas.map({ cosa => cosa.peso() }))
	}

	method totalBultos() {
		return (cosas.map({ cosa => cosa.valorBulto() })).sum()
	}

// Transporte ---------------------------------------------------------

	method transportar(destino, camino) {
		self.validarTransporte(destino, camino)
		destino.cargar(cosas)
		cosas.removeAll(cosas)
	}

	method validarTransporte(destino,camino) {
		self.validarPeso()
		self.validarBultos(destino)
		self.validarCamino(camino)
	}

	method validarPeso() {
		if (self.excedidoDePeso()) {self.error("esta excedido de peso")}
	}

	method validarBultos(destino) {
		if (self.totalBultos() > destino.bultosMax()) {self.error("esta excedido de bultos")}
	}

	method validarCamino(camino) {
		if (not camino.camionPuedePasar(self)) {self.error("esta excedido de peligrosidad")}
	}
}

object rutaNueve {
	const nivelPeligrosidad = 11

	method camionPuedePasar(camionD) {
		return camionD.puedeCircularEnRuta(nivelPeligrosidad)
	}
}

object vecinales {
	var property  pesoMax = 0

	method camionPuedePasar(camionD) {
		return (camionD.pesoTotal() < pesoMax)
	}
}
