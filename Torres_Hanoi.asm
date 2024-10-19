# Santiago Ismael LÃ³pez Contreras
# 
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
	jal fin_mover
	
movedera_recursiva:
    beq s0, zero, fin_mover      # Si n == 0, termina
    beq s0, t0, mover_uno        # Si n == 1, ir a mover_uno

    addi sp, sp, -0x8            # Reservar espacio en el stack
    sw ra, 0x0(sp)               # Guardar retorno
    sw s0, 0x4(sp)               # Guardar n

    # hanoi(n - 1, origen, auxiliar, destino)
    addi s0, s0, -1              # n = n - 1
    jal movedera_recursiva       # Mover discos de origen a auxiliar

    # Aquí se debería realizar la acción de mover el disco
    # Por ejemplo: imprimir "Mover disco n de origen a destino"

    lw s0, 0x4(sp)               # Restaurar n
    lw ra, 0x0(sp)               # Restaurar retorno
    addi sp, sp, 0x8             # Liberar espacio en el stack

    # hanoi(n - 1, auxiliar, destino, origen)
    addi s0, s0, -1              # n = n - 1
    jal movedera_recursiva       # Mover discos de auxiliar a destino

    j fin_mover                  # Saltar al final

mover_uno:
    # Aquí se realiza la acción de mover el disco 1 de origen a destino
    # Por ejemplo: imprimir "Mover disco 1 de origen a destino"

fin_mover:
    jalr ra                       # Retornar

	
	
	
