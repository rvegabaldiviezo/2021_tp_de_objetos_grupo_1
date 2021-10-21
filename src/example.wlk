/** First Wollok example */


class Mutante{
	const property nombre =""
	const property potencial = 0
	const property habilidades = []  
	const property poderTotal=0

	method poderTotal()= potencial + habilidades.sum{habilidad=> habilidad.incrementoPotencial(self)}

	method puedeAprender(habilidad)= habilidad.cumpleRequisitos(self)
	
	method tieneHabilidad(habilidad)=habilidades.contains(habilidad)
	
	method aprenderHabilidad(habilidad){
		if(self.puedeAprender(habilidad) && not(self.tieneHabilidad(habilidad))){
			habilidades.add(habilidad)
		}
	}
}

const explosionOptica= new ExplosionOptica(nivel=11)

const ciclope = new Mutante(nombre= "Scott Summers", potencial = 30, habilidades = [explosionOptica])

const fenix = new Mutante(nombre= "Jean Gray", potencial = 40, habilidades = [new Telepatia(nivel=13)])

const quicksilver = new Mutante(nombre= "Pietro Maximoff", potencial = 35, habilidades = [new Supervelocidad(nivel=9)])

const iceman = new Mutante(nombre= "Bobby Drake", potencial = 25, habilidades = [new Transformacion(nivel=7)])

const cable = new Mutante(nombre= "Nathan Summers", potencial=25, habilidades = [new Telequinesis(nivel=10)])

const domino = new Mutante(nombre="Neena Thurman" , potencial=25, habilidades = [new Suerte(nivel=13)])

const sunspot = new Mutante(nombre="Roberto Da Costa" , potencial=25, habilidades = [new AbsorcionSolar(nivel=8)])

const magneto = new Mutante(nombre="Erik Lenhsherr", potencial= 50 , habilidades= [new Magnetismo(nivel=14)])
const blob = new Mutante(nombre="Fred Dukes", potencial= 20 , habilidades= [new Inamovible(nivel=6)])

class Habilidad{
	const property nivel = 1
	method incrementoPotencial(persona)=0	
	method cumpleRequisitos(mutante)=false
}

class ExplosionOptica inherits Habilidad{
	override method incrementoPotencial(mutante) = 30		
	override method cumpleRequisitos(mutante)= mutante.poderTotal().between(70, 115)
}

class Telepatia inherits Habilidad{  	  
	override method incrementoPotencial(mutante)= (mutante.potencial())*2	
}

class Supervelocidad inherits Habilidad{	
	override method incrementoPotencial(mutante)=if(mutante.potencial().even()) 20 else 25	
	override method cumpleRequisitos(mutante)= mutante.potencial()<=30		
}

class Transformacion inherits Habilidad{	
	override method incrementoPotencial(mutante)= -(mutante.potencial().div(5))
	override method cumpleRequisitos(mutante)= 60<mutante.poderTotal()
}

class Telequinesis inherits Habilidad{	
	override method incrementoPotencial(mutante){
		const incremento = mutante.potencial()*2
		if(incremento>80){
			return mutante.potencial()
		}else{
			return incremento
		}
	}
}

class Suerte inherits Habilidad{	
	override method incrementoPotencial(mutante){
		const nombreImpar = !(mutante.nombre().length().even())
		if (nombreImpar){
			return mutante.potencial()*2
		}else{
			return 0
		} 
	}
	override method cumpleRequisitos(mutante)= mutante.poderTotal()>45
}

class AbsorcionSolar inherits Habilidad{	
	override method incrementoPotencial(mutante){
		const nroHabilidades = mutante.habilidades().size()
		return mutante.potencial() * (nroHabilidades -1)
	} 
	override method cumpleRequisitos(mutante)= mutante.habilidades().size() == 2
}


class Magnetismo inherits Habilidad{	
	override method incrementoPotencial(mutante)= mutante.poderTotal()/2
	override method cumpleRequisitos(mutante)= mutante.potencial()>=30 and mutante.poderTotal()>50		
}

class Inamovible inherits Habilidad{	
	override method incrementoPotencial(mutante){ 
		const size =  mutante.habilidades().size()
		if( size == 1){
			 mutante.poderTotal(50)
			 return 0 
		}else{
			return size
		} 		  
	}		
	override method cumpleRequisitos(mutante)= true	
}


