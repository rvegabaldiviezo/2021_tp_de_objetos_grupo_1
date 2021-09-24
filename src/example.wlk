/** First Wollok example */

object ciclope{
	const nombre =  "Scott Summers"
	const potencial = 30	
	var habilidades = [explosionOptica]	  
	var potencialAdquirido=0
	
	method poderTotal(){
		potencialAdquirido = habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
		return potencial + potencialAdquirido
	}
}

object explosionOptica{
	method incrementoPotencial(potencial) = 30
}

object fenix{
	const nombre= "Jean Gray"
	var potencial= 40
	var habilidades= [telepatia]
	var potencialAdquirido=0
	
	method poderTotal(){
		potencialAdquirido = habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
		return potencial + potencialAdquirido
	}
	
}

object telepatia{
	method incrementoPotencial(potencial)= potencial*2
}

object quicksilver{
	const nombre = "Pietro Maximoff"
	var potencial = 35
	var habilidades = [supervelocidad]
	var potencialAdquirido=0
	
	method poderTotal(){
		potencialAdquirido = habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
		return potencial + potencialAdquirido
	}
}
object supervelocidad{
	method incrementoPotencial(potencial){
		if(potencial.even()){
			return 20
		}else{
			return 25
		}
	}   		
}

object iceman {
	const nombre = "Bobby Drake"
	var potencial = 25
	var habilidades = [transformacion]
	var potencialAdquirido=0
	
	method poderTotal(){
		potencialAdquirido = habilidades.sum{habilidad=> habilidad.incrementoPotencial(potencial)}
		return potencial + potencialAdquirido
	}
}

object transformacion {
	method incrementoPotencial(potencial)= (potencial.div(5))
}

