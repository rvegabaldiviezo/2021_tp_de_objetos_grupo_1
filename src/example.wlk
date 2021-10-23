/** First Wollok example */


class Mutante{
	const property nombre =""
	var property potencial = 0
	const property habilidades = []  

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
	
	method integrantesEnComun(otraFaccion)= self.nombres().intersection(otraFaccion.nombres())
	 
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


// Ejemplos me Mutantes
const ciclope = new Mutante(nombre= "Scott Summers", potencial = 30, habilidades = [new Habilidad(nucleo = explosionOptica, nivel= 11)])

const ciclope2 = new Mutante(nombre= "Scott Summers", potencial = 30, habilidades = [new Habilidad(nucleo = explosionOptica, nivel= 10)])


const fenix = new Mutante(nombre= "Jean Gray", potencial = 40, habilidades = [ new Habilidad( nucleo = telepatia, nivel = 13)])

const quicksilver = new Mutante(nombre= "Pietro Maximoff", potencial = 35, habilidades = [new Habilidad(nucleo=supervelocidad, nivel=9) ])

const iceman = new Mutante(nombre= "Bobby Drake", potencial = 25, habilidades = [new Habilidad(nucleo=transformacion, nivel=7) ])

const cable = new Mutante(nombre= "Nathan Summers", potencial=25, habilidades = [new Habilidad(nucleo = telequinesis, nivel = 10)])

const domino = new Mutante(nombre="Neena Thurman" , potencial=25, habilidades = [new Habilidad(nucleo=suerte, nivel=13)])

const sunspot = new Mutante(nombre="Roberto Da Costa" , potencial=25, habilidades = [new Habilidad(nucleo=absorcionSolar, nivel=8)])

const magneto = new Mutante(nombre="Erik Lenhsherr", potencial= 50 , habilidades= [new Habilidad( nucleo = magnetismo, nivel = 14)])

const blob = new Mutante(nombre="Fred Dukes", potencial= 20 , habilidades= [new Habilidad( nucleo = inamovible, nivel = 6)])

const borrar = new Mutante(nombre="Borrar", potencial= 20 , habilidades= [new Habilidad( nucleo = telequinesis, nivel = 11)])
-

// Ejemplos de Facciones
const xforce = new Faccion(mutantes=[cable,domino,sunspot]) // [ telequinesis(10), suerte(13), absorcionSolar(8)]

const hermandad = new Faccion(mutantes = [magneto, blob, quicksilver]) //[ magnetismo(14), inamovible(6), supervelocidad(9)]

const xmen = new Faccion( mutantes = [fenix, iceman, sunspot, cable]) // [ telepatia(13), transformacion(7), absorcionSolar(8), telequinesis(10)]

///////////////////////
/*
object entrenamientoBasico{
	method entrenar(mutante, tiempo, habilidades, fraccion){ 
		mutante.potencial(mutante.potencial + tiempo) 
	}	
}	
	
object entrenamientoCompleto{	
	method entrenar(mutante, tiempo, habilidades, fraccion){
		entrenamientoBasico.entrenar(mutante, tiempo, habilidades, fraccion)
		if( habilidades.any{ habilidad => fraccion.contieneHabilidad(habilidad)})
		{
			habilidades.map{habilidad => if(aEntrenar.contains(habilidad.nucleo())) habilidad.nivel(habilidad.nivel()+2)}
		}
	}
	
}*/
//  fraccion.contieneHabilidad(habilidad) = self.habilidadesFaccion().any{ habilidadFaccion => habilidadFaccion == habilidad}

class Sesion  {
	// Tipo de entrenammiento de la seaion (basico o completo)      
	var property entrenamiento
	// Habilidades q seran entrenadas
	var property habilidades
	// Tiempo q dura la sesion de entrenamiento 
	const property tiempo

	method entrenarMutante(mutante, tiempo, habilidades, faccion) {
		
		entrenamiento.entrenar(mutante, tiempo)
	}
	method entrenamientoFaccion(faccion) {
		// Modifico a cada Mutante de una Fraccion
		faccion.mutantes().map{mutante => self.entrenarMutante(mutante, tiempo, habilidades, fraccion)}
	}

	method entrenamientoBasico(mutante, tiempo){
	method entrenar(mutante, tiempo, habilidades, fraccion){ 
		mutante.potencial(mutante.potencial + tiempo) 
	}	
}	
	
object entrenamientoCompleto{	
	method entrenar(mutante, tiempo, habilidades, fraccion){
		entrenamientoBasico.entrenar(mutante, tiempo, habilidades, fraccion)
		if( habilidades.any{ habilidad => fraccion.contieneHabilidad(habilidad)})
		{
			habilidades.map{habilidad => if(aEntrenar.contains(habilidad.nucleo())) habilidad.nivel(habilidad.nivel()+2)}
		}
	}
	
}
	
}







/*
object entrenamientoBasico{
	method entrenar(mutante, tiempo, habilidades, fraccion){ 
		mutante.potencial(mutante.potencial + tiempo) 
	}	
}	
	
object entrenamientoCompleto{	
	method entrenar(mutante, tiempo, habilidades, fraccion){
		entrenamientoBasico.entrenar(mutante, tiempo, habilidades, fraccion)
		if( habilidades.any{ habilidad => fraccion.contieneHabilidad(habilidad)})
		{
			habilidades.map{habilidad => if(aEntrenar.contains(habilidad.nucleo())) habilidad.nivel(habilidad.nivel()+2)}
		}
	}
	
}
//  fraccion.contieneHabilidad(habilidad) = self.habilidadesFaccion().any{ habilidadFaccion => habilidadFaccion == habilidad}

class Sesion  {
	// Tipo de entrenammiento de la seaion (basico o completo)      
	var property entrenamiento
	// Habilidades q seran entrenadas
	var property habilidades
	// Tiempo q dura la sesion de entrenamiento 
	const property tiempo

	method entrenarMutante(mutante, tiempo, habilidades, faccion) {
		
		entrenamiento.entrenar(mutante, tiempo)
	}
	method entrenamientoFaccion(faccion) {
		// Modifico a cada Mutante de una Fraccion
		faccion.mutantes().map{mutante => self.entrenarMutante(mutante, tiempo, habilidades, fraccion)}
	}

*/

