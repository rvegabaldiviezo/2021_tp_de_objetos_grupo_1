/** First Wollok example */

object ciclope{
	const property nombre =  "Scott Summers"
	const property potencial = 30	
	const property habilidades = [explosionOptica]	  

	method poderTotal()= potencial + habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}

	method puedeAprender(habilidad)= habilidad.cumpleRequisitos(self)
	
	method tieneHabilidad(habilidad)=habilidades.contains(habilidad)
	
	method aprenderHabilidad(habilidad){
		if(self.puedeAprender(habilidad) && not(self.tieneHabilidad(habilidad))){
			habilidades.add(habilidad)
		}
	}
}

object fenix{
	const property nombre= "Jean Gray"
	const property potencial= 40
	const property habilidades= [telepatia]
	
	method poderTotal()= potencial + habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
	
	method puedeAprender(habilidad)= habilidad.cumpleRequisitos(self)
	
	method tieneHabilidad(habilidad)=habilidades.contains(habilidad)
	
	method aprenderHabilidad(habilidad){
		if(self.puedeAprender(habilidad) && not(self.tieneHabilidad(habilidad))){
			habilidades.add(habilidad)
		}
	}
}

object quicksilver{
	const property nombre = "Pietro Maximoff"
	const property potencial = 35
	const property habilidades = [supervelocidad]
	
	method poderTotal()= potencial + habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
	
	method puedeAprender(habilidad)= habilidad.cumpleRequisitos(self)
	
	method tieneHabilidad(habilidad)=habilidades.contains(habilidad)
	
	method aprenderHabilidad(habilidad){
		if(self.puedeAprender(habilidad) && not(self.tieneHabilidad(habilidad))){
			habilidades.add(habilidad)
		}
	}
}

object iceman {
	const property nombre = "Bobby Drake"
	const property potencial = 25
	const property habilidades = [transformacion]
	
	method poderTotal()= potencial + habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
	
	method puedeAprender(habilidad)= habilidad.cumpleRequisitos(self)
	
	method tieneHabilidad(habilidad)=habilidades.contains(habilidad)
	
	method aprenderHabilidad(habilidad){
		if(self.puedeAprender(habilidad) && not(self.tieneHabilidad(habilidad))){
			habilidades.add(habilidad)
		}
	}
}

object explosionOptica{
	method incrementoPotencial(potencial) = 30		
	method cumpleRequisitos(mutante)= mutante.poderTotal().between(70, 115)
}

object telepatia{
	method incrementoPotencial(potencial)= potencial*2	
	method cumpleRequisitos(mutante)=false
}

object supervelocidad{
	method incrementoPotencial(potencial)=if(potencial.even()) 20 else 25
	
	method cumpleRequisitos(mutante)= mutante.potencial()<=30		
}

object transformacion {
	method incrementoPotencial(potencial)= -(potencial.div(5))
	method cumpleRequisitos(mutante)= 60<mutante.poderTotal()
}

