/** First Wollok example */

class Mutante{
	const property nombre =""
	var property potencial = 0
	const property habilidades = []  

	method potencial(valor){ potencial = potencial + valor}
	method poderTotal()= potencial + habilidades.sum{habilidad=> habilidad.nucleo().incrementoPotencial(self)}

	method puedeAprender(nucleo)= nucleo.cumpleRequisitos(self)
	
	method tieneHabilidad(nucleo)=self.nucleos().contains(nucleo)
	
	method aprenderHabilidad(habilidad){
		if(self.puedeAprender(habilidad.nucleo()) && not(self.tieneHabilidad(habilidad.nucleo()))){
			habilidades.add(habilidad)
		}
	}
	
	method nucleos()=habilidades.map{habilidad => habilidad.nucleo()}
	
}


class Habilidad{
	var property nucleo
	var property nivel = 1

	method aumentarNivel(numero) {nivel = nivel + numero}
 	override method ==(habilidad)= nucleo == habilidad.nucleo() 
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
	const property mutantes= [] 
	var property habilidadesFaccion= #{}
	
	method multiplicador()= self.nucleos().asSet().size().max(self.mutantes().size())
	method nucleos()= self.habilidadesFaccion().map{habilidad => habilidad.nucleo()}
	method habilidadesFaccion()= (mutantes.map{mutante => mutante.habilidades()}).flatten()
	
	method poderTotal()= (mutantes.sum{mutante => mutante.poderTotal()}) * self.multiplicador()
	
	method agregarMutante(mutante)= mutantes.add(mutante)
	method quitarMutante(mutante)= mutantes.remove(mutante)
	
	method nombres() = mutantes.map{mutante => mutante.nombre()}
	
	method integrantesEnComun(otraFaccion)= self.nombres().asSet().intersection(otraFaccion.nombres())
	 
	method contieneHabilidad(habilidad) = self.habilidadesFaccion().any{ habilidadFaccion => habilidadFaccion == habilidad}

	method puedeAgregarHabilidad(habilidad) = mutantes.any{ mutanteFaccion => 
		mutanteFaccion.habilidades().any{ habilidadFaccion => 
			habilidadFaccion == habilidad and habilidadFaccion.nivel() < habilidad.nivel()			
		}														
	}	 

	method convieneAgregar(mutante) = mutante.habilidades().any{ habilidad => 
		not self.contieneHabilidad(habilidad) or self.puedeAgregarHabilidad(habilidad)
	}
				
}

///////////////////////

class Entrenamiento{
	
	// Habilidades q seran entrenadas
	var property habilidades = []
	// Tiempo q dura la sesion de entrenamiento 
	const property tiempo

	method entrenamientoBasicoMutante(mutante){ 
		mutante.potencial(tiempo) 
	}
	method entrenamientoBasico(faccion){
		faccion.mutantes().forEach{mutante => self.entrenamientoBasicoMutante(mutante)}
	}

	method entrenamientoCompletoMutante(mutante){
		mutante.habilidades().forEach{
			habilidad => 
			if(habilidades.contains(habilidad.nucleo()))
			{
				habilidad.aumentarNivel(2)
			}
		}
	}

	method entrenamientoCompleto(faccion) {
		self.entrenamientoBasico(faccion)
		faccion.mutantes().forEach{mutante => self.entrenamientoCompletoMutante(mutante)}
	}
	
	
}
<<<<<<< HEAD

=======
>>>>>>> 6329071c719fb7935a1a9cc05ec8f52a98eb2a99
