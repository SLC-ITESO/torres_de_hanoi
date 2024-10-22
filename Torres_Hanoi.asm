# Santiago Ismael LÃ³pez Contreras
# LOPEZ RODRIGUEZ, VICENTE SILOE
# Impares 1 3 2
# Pares 1 2 3
addi s0, zero, 3				# n = x (cantidad de Discos)
lui a0, 0x10010					# a0: direccion de la primera torre (origen)
add a7, zero, a0				# se guarda la direccion del disco

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
	
	#Para mejor entendimiento, se le asignara un numero a cada torre
	addi t3, zero, 1			# 1 sera la torre A
	addi t4, zero, 2			# 2 sera la torre B
	addi t5, zero, 3			# 3 sera la torre C
	
	jal movedera_recursiva
	#void hanoi(int n, char origen, char destino, char auxiliar)
	#
	jal si_termina
	
movedera_recursiva: #void hanoi()
	add t2 t4, zero  			# t2 = t4 | almacenamos t4 en t2
	add t4, t5, zero  			# t4 = t5
	add t5, t2, zero  			# t5 = t2 | t2 tenï¿½a el valor original de t4
	
	beq s0, t0, es_uno			# if n == 1
	
    	addi sp, sp, -0x14
    	sw ra, 0x0(sp)
    	sw s0, 0x4(sp)
    	sw t3, 0x8(sp)				# origen
    	sw t4, 0xC(sp)				# auxiliar
    	sw t5, 0x10(sp)				# destino
    	#hanoi(n - 1, origen, auxiliar, destino);
    	addi s0, s0, -1
    	
    	
    	jal movedera_recursiva
    	#printf("Mover disco %d de %c a %c\n", n, origen, destino);

    	lw ra, 0x0(sp)
    	lw s0, 0x4(sp)
    	lw t3, 0x8(sp)
    	lw t5, 0xC(sp)
    	lw t4, 0x10(sp)
    	addi sp, sp, 0x14
	
	#hanoi(n - 1, auxiliar, destino, origen);
	addi s0, s0, -1
	#AQUI
	add t2, t3, zero         # t2 = origen (almacenamos el origen en t2)
	add t3, t5, zero         # t3 = destino (almacenamos el destino en t3)
	add t5, t4, zero         # t5 = auxiliar (el auxiliar pasa a ser el destino)
	jal movedera_recursiva
	
	jalr ra
	
es_uno:
	#        printf("Mover disco 1 de %c a %c\n", origen, destino);
        #	return;
        
        jalr ra
white_snake:


si_termina:
	addi a6, zero, 0xF
