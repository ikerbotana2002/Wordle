#!/bin/bash


as6809 -a -o wordle1.asm
as6809 -a -o utilidades.asm
as6809 -a -o diccionario.asm
as6809 -a -o textos.asm
as6809 -a -o mostrar_dic.asm
as6809 -a -o juego.asm

aslink -s -m -w wordle1.s19 wordle1.rel utilidades.rel diccionario.rel textos.rel juego.rel mostrar_dic.rel

m6809-run wordle1.s19

