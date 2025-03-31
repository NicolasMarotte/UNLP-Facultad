program p1ej3;
type 
	String15 = String[15];
	
	empleado = record 
		num : integer;
		apellido: String15;
		nombre: String15;
		edad: integer;
		dni: String15;
	end;
	
	archivo = file of empleado;
	
	procedure leerEmpleado(var e:empleado);
	begin
		writeln('///// INGRESE EL APELLIDO DEL EMPLEADO /////');
		readln(e.apellido);
		if(e.apellido<>'fin')then begin
			writeln('///// INGRESE EL NOMBRE DEL EMPLEADO /////');
			readln(e.nombre);
			writeln('///// INGRESE EL NUEMRO DEL EMPLEADO /////');
			readln(e.num);
			writeln('///// INGRESE LA EDAD DEL EMPLEADO /////');
			readln(e.edad);
			writeln('///// INGRESE EL DNI DEL EMPLEADO /////');
			readln(e.dni);
		end;
	end;
	
	procedure crearArchivo (var a:archivo);
	var
		str:String15;
		em:empleado;
	begin
		writeln('--- INGRESE EL NOMBRE QUE QUIERE DARLE AL ARCHIVO ---');
		readln(str);
		assign (a,str);
		rewrite(a);
		leerEmpleado(em);
		while (em.apellido <> 'fin')do 
		begin
			write(a,em);
			leerEmpleado(em);
		end;
		close(a);
	end;
	
	procedure abrirArchivo (var a:archivo);
	var
		str:String15;
	begin
		writeln('--- INGRSE EL NOMBRE DEL ARCHIVO QUE QUIERE ABRIR ---');
		readln(str);
		assign(a,str);
	end;
	procedure imprimir (var a:archivo);
	var 
		em:empleado;
	begin
		reset(a);
		while(not eof(a))do begin
			read(a,em);
			with em do writeln('/// APELLIDO-->',apellido,'      NOMBRE-->',nombre,'      NUMERO-->',num,'      DNI-->',dni,'      EDAD--.',edad,'   ///');
		end;
	close(a);
	end;
	procedure leer(var a:archivo ; var em:empleado);
	begin
		if(not eof(a)) then
			read(a, em)
		else
			em.num := -1;
	end;
	
	procedure buscar(var a:archivo);
	var
		em:empleado;
		str:String15;
	begin
		reset(a);
		writeln('--- INGRESE EL APELLDO DEL EMPLEADO QUE SE BUSCA ---');
		readln(str);
		leer(a,em);
		while(em.num <> -1)do begin
			if ((em.apellido=str) or (em.nombre=str))then
				with em do writeln('/// APELLIDO-->',apellido,'      NOMBRE-->',nombre,'      NUMERO-->',num,'      DNI-->',dni,'      EDAD--.',edad,'   ///');
			leer(a,em);
		end;
		close(a);
	end;
	
	procedure mayores70 (var a:archivo);
	var
		em:empleado;
	begin
		reset(a);
		writeln('--- LOS EMPLEADOS MAYORES A 70 SON ---');
		leer(a,em);
		while (not eof(a))do begin
			if (em.edad>70)then 
				with em do writeln('/// APELLIDO-->',apellido,'      NOMBRE-->',nombre,'      NUMERO-->',num,'      DNI-->',dni,'      EDAD--.',edad,'   ///');
			leer(a,em);
		end;
		close(a);
	end;
	
	{procedure controlUnicidad (var a:archivo);
	var
		em:empleado;
	begin
		leerEmpleado(em);
		reset(a);
		while (not eof(o))do begin
			if(em.num<>a.em.num)then }
	
	procedure agregarEmpleado(var a:archivo);
	var
		em:empleado;
	begin
		leerEmpleado(em);
		if (em.apellido <> 'fin')then begin 
			reset(a);
			seek(a,fileSize(a));
			write(a,em);
			writeln('/// SE AGREGO CORRECTAMENTE ///');
		end;
		close(a);
	end;
		
	procedure modificarEdad(var a:archivo);
	var
		int:integer;
		em:empleado;
	begin
		reset(a);
		writeln('INGRESE EL NUMERO DE EMPLEADO A MODIFICAR');
		readln(int);
		leer(a,em);
		while (em.num<>int)do
			leer(a,em);
		if(em.num<>-1)then begin
			writeln('INGRESE LA NUEVA EDAD');
			read(em.edad);
			seek(a,filePos(a)-1);
			write(a,em);
			writeln('SE MODIFICO LA EDAD');
		end
		else
			writeln('NO SE ENCONTRO EL EMPLEADO');
		close(a);
	end;
			
	procedure exportar(var a:archivo);
	var	
		txt:Text;
		em:empleado;
	begin
		assign(txt,'todos_empleados.txt');
		rewrite(txt);
		reset(a);
		while (not eof(a))do begin
			read(a,em);
			write(txt, em.nombre,' ',em.apellido,'',em.edad,' ',em.dni,' ',em.num);
		end;
		writeln('ARCHIVO EXPORTADO');
		close(txt);
		close(a);
	end;
	
		procedure exportarFaltaDni(var a:archivo);
	var	
		faltan:Text;
		em:empleado;
	begin
		assign(faltan,'todos_empleados.txt');
		rewrite(faltan);
		reset(a);
		while (not eof(a))do begin
			read(a,em);
			if(em.dni='00') then 
			write(faltan, em.nombre,' ',em.apellido,'',em.edad,' ',em.dni,' ',em.num);
		end;
		writeln('ARCHIVO EXPORTADO');
		close(faltan);
		close(a);
	end;

		
		
var
	arch:archivo;
	int :integer;
begin
	repeat 
	writeln('//// MENU ////');
	writeln('----> 1: CREAR ARCHIVO');
	writeln('----> 2: ABRIR ARCHIVO');
	writeln('----> 3: LEER ARCHIVO');
	writeln('----> 4:BUSCAR UN EMPLEADO');
	writeln('----> 5:BUSCAR EMPLEADOS MAYORES A 70');
	writeln('----> 6: AGREGAR EMPLEADO');
	writeln('----> 7: MODIFICAR EDAD');
	writeln('----> 8: EXPORTAR ARCHIVO');
	writeln('-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_');
	readln(int);
		case int of 
		1: crearArchivo(arch);
		2: abrirArchivo(arch);
		3: imprimir(arch);
		4: buscar(arch);
		5: mayores70(arch);
		6: agregarEmpleado(arch);
		7: modificaredad(arch);
		8: exportar(arch);
		9: exportarFaltaDni(arch);
	end;
	until (2<1)
end.
	
	
	
	
	
	
		
