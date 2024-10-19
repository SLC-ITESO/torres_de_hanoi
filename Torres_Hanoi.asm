# Santiago Ismael LÃ³pez Contreras
# LOPEZ RODRIGUEZ, VICENTE SILOE
# Impares 1 3 2
# Pares 1 2 3
addi s0, zero, 3				# n = x (cantidad de Discos)
lui a0, 0x10010					# a0: direcciÃ³n de la primera torre (origen)
add a7, zero, a0				# se guarda la direcciÃ³n del disco

addi t0, zero, 1				# Para comparar si n = 1
jal hanoi

hanoi:
	addi t6, zero, 1			# valor de los discos
	addi s0, s0, 1				# Le agregamos +1 para que se agreguen todos los valores
inicia_torre:
	beq t6, s0, termina_torre
	sw t6, 0x0(a0)
	addi a0, a0, 0x20
	addi t6, t6, 1
	jal inicia_torre
	
termina_torre:
	addi s0, s0, -1				# restauramos n
	addi a0, a0, -0x20			
	
	addi a1, a0, 0x4			# a1: direccion segunda torre (auxiliar)
	#sw t6 0x0(a1)
	addi a2, a1, 0x4			# a2: direccion tercera torre (destino)
	#sw t6 0x0(a2)
	
	# LAS DIRECCIONES SE ENCUENTRAN EN LA "BASE" DE LAS TORRES
	jal movedera_recursiva
	#void hanoi(int n, char origen, char destino, char auxiliar)
	#void hanoi( s0, a0, a2, a1)
	jal si_termina
	
movedera_recursiva: #void hanoi()
	
	beq s0, t0, es_uno			# if n == 1
	
	#hanoi(n - 1, origen, auxiliar, destino);
    	addi sp, sp, -0x8			#si se necesita más, aumentale
    	sw ra, 0x0(sp)
    	sw s0, 0x4(sp)
    	addi s0, s0, -1
    	
    	jal movedera_recursiva
    	#printf("Mover disco %d de %c a %c\n", n, origen, destino);

    	lw ra, 0x0(sp)
    	lw s0, 0x4(sp)
    	addi sp, sp, 0x8			#si se necesita más, aumentale
	addi s0, s0, -1
	
	#hanoi(n - 1, auxiliar, destino, origen);
	jal movedera_recursiva
	lw ra,0x0(sp)
	
	jalr ra
	
es_uno:
	#        printf("Mover disco 1 de %c a %c\n", origen, destino);
        #	return;
        
        jalr ra
        
si_termina:
	addi a6, zero, 0xF
