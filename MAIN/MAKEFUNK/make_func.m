function [] = make_func(destination,V)
copyfile('MAKEFUNK\function_template.m',strcat(destination,V))
edit(V)
