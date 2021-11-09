/** First Wollok example */
class NoAprendeHabilidadExeption inherits Exception { }

class Mutante{
	const property nombre = ""
	var property potencial = 0
	const property habilidades = []  

	method incrementarPotencial(valor){ potencial += valor}
	
	method incrementoPotencialTotal() = habilidades.sum{ habilidad => habilidad.incrementoPotencial(self)}

	method poderTotal()= potencial + self.incrementoPotencialTotal()

	method puedeAprender(habilidad) = habilidad.cumpleRequisitos(self)
	
	method tieneHabilidad(habilidad) = habilidades.contains(habilidad)
	
	method aprenderHabilidad(habilidad){
		if( !self.puedeAprender(habilidad)){
			throw new NoAprendeHabilidadExeption(message = "No cumple los requisitos para aprender la habilidad")
		}
		if( self.tieneHabilidad(habilidad)){
			throw new NoAprendeHabilidadExeption(message = "Ya aprendio la habilidad indicada")
		}
		
		habilidades.add(habilidad)
	}	
}


class Habilidad{
	var property nucleo
	var property nivel = 1

	method aumentarNivel(numero) {nivel = nivel + numero}
	
 	override method ==(habilidad)= nucleo == habilidad.nucleo()
 	
 	method incrementoPotencial(mutante) = nucleo.incrementarPotencial(mutante)
	
	method cumpleRequisitos(mutante) = nucleo.cumpleRequisitos(mutante)  
}

object explosionOptica{
	method incrementoPotencial(mutante) = 30		
	method cumpleRequisitos(mutante)= mutante.poderTotal().between(70, 115)
}

object telepatia {  	  
	method incrementoPotencial(mutante)= (mutante.potencial())*2	
	method cumpleRequisitos(mutante)= false
}

object supervelocidad{	
	method incrementoPotencial(mutante)=if(mutante.potencial().even()) 20 else 25	
	method cumpleRequisitos(mutante)= mutante.potencial()<=30		
}

object transformacion{	
	method incrementoPotencial(mutante)= -(mutante.potencial().div(5))
	method cumpleRequisitos(mutante)= 60<mutante.poderTotal()
}

object telequinesis{	
	method incrementoPotencial(mutante){
		const incremento = mutante.potencial()*2
		if(incremento>80){
			return mutante.potencial()
		}else{
			return incremento
		}
	}
	method cumpleRequisitos(mutante)= false
}

object suerte{	
	method incrementoPotencial(mutante){
		const nombreImpar = !(mutante.nombre().length().even())
		if (nombreImpar){
			return mutante.potencial()*2
		}else{
			return 0
		} 
	}
	method cumpleRequisitos(mutante)= mutante.poderTotal()>45
}

object absorcionSolar{	
	method incrementoPotencial(mutante){
		const nroHabilidades = mutante.habilidades().size()
		return mutante.potencial() * (nroHabilidades -1)
	} 
	method cumpleRequisitos(mutante)= mutante.habilidades().size() == 2
}


object magnetismo{	
	method incrementoPotencial(mutante)= mutante.poderTotal()/2
	method cumpleRequisitos(mutante)= mutante.potencial()>=30 and mutante.poderTotal()>50		
}

object inamovible{	
	method incrementoPotencial(mutante){ 
		const size =  mutante.habilidades().size()
		if( size == 1){
			 return 50 - mutante.potencial() 
		}else{
			return size
		} 		  
	}		  
	method cumpleRequisitos(mutante)= true	
}

class Faccion{

	const property mutantes = #{} 
	
	// pto 4
	method agregar(mutante)= mutantes.add(mutante) 
	method quitar(mutante)= mutantes.remove(mutante) 

	method habilidades() = (mutantes.map{ mutante => mutante.habilidades()}).flatten()
	method habilidadesDistintas() = self.habilidades().asSet()
	method poderTotalMutantes() = mutantes.sum{ mutante => mutante.poderTotal()}
	method multiplicador() = (mutantes.size()).min(self.habilidadesDistintas().size())
	// pto 5 
	method poderTotal() = self.multiplicador() * self.poderTotalMutantes()
	
	method nombres() = (mutantes.map{ mutante => mutante.nombre()}).asSet()
	// pto 6
	method integrantesEnComun(faccion) = self.nombres().intersection(faccion.nombres())
	 

	method contieneHabilidad(habilidad) = self.habilidadesDistintas().contains(habilidad)

	method puedeAgregarHabilidad(nuevaHabilidad){
		var habilidadesConNucleosIguales = self.habilidades().filter{ habilidad => habilidad == nuevaHabilidad}
		var existeUnaHabilidadIgualPeroDeNucleoMenor = habilidadesConNucleosIguales.any{ habilidad => habilidad.nivel() < nuevaHabilidad.nivel()}	
		return existeUnaHabilidadIgualPeroDeNucleoMenor
	}	 
	// pto 7
	method convieneAgregar(mutante) = mutante.habilidades().any{ habilidad => !self.contieneHabilidad(habilidad) or self.puedeAgregarHabilidad(habilidad)}		



}

class EntrenamientoBasico{
	var property tiempo

	method entrenarMutante(mutante){ 
		mutante.incrementarPotencial(tiempo) 
	}
	method entrenarFaccion(faccion){
		faccion.mutantes().forEach{mutante => self.entrenarMutante(mutante)}
	}
}

class EntrenamientoCompleto inherits EntrenamientoBasico{
	var property nucleos = []

	method entrenarHabilidades(mutante){
		mutante.habilidades().forEach{ habilidad => if(nucleos.contains(habilidad.nucleo())) habilidad.aumentarNivel(2)}
	}
	override method entrenarMutante(mutante){
		super(mutante)
		self.entrenarHabilidades(mutante)
	}
}
