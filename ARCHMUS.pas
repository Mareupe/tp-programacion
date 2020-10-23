
Unit ARCHMUS;

Interface
//Parte Publica
uses crt;

Type 
    Museo =   Record
        Codigo, Telefono :   Int64;
        Nombre, Calle, Ciudad, Pais, Name_Director :   String;
        Activo :   Boolean;
    End;
    Archivo_Museos =   File Of Museo;

Var 
    Museos:   Archivo_Museos;
    Mus:   Museo;

    //METODOS DE APERTURA, LECTURA, MODIFICACION, GUARDADO Y CIERRE
Procedure AbrirM (Var Museos:Archivo_Museos);
Procedure LeerM (Var Museos:Archivo_Museos; Var Mus:Museo; Pos:Integer);
Procedure ModificarM (Var Museos:Archivo_Museos; Var Mus:Museo; Pos:integer);
Procedure GuardarM (Var Museos:Archivo_Museos; Var Mus:Museo);
Procedure CerrarM (Var Museos:Archivo_Museos);

//METODOS DE BUSQUEDA Y ORDENAMIENTO
Procedure burbujaM (Var Museos:Archivo_Museos);
Procedure Buscar_Museo_Codigo (Var Museos:Archivo_Museos; Var pos:int64; codigo_buscado:int64; Var Mus:Museo);
Procedure Buscar_Museo_Nombre (Var Museos:Archivo_Museos; Var pos:int64; Nombre:String; Var Mus:Museo);

//METODO DE PRUEBAS
Procedure Barrido_Mus(Var Museos:Archivo_Museos);

Implementation
//Parte Privada

{APERTURA, LECTURA, MODIFICACION, GUARDADO Y CIERRE
}

Procedure AbrirM(Var Museos : Archivo_Museos);
Begin
    Assign(Museos,'X:\ARCHMUS.dat');
    Reset(Museos);
    If (ioresult <> 0) Then
	Begin
		Rewrite(Museos);
	End;
End;

Procedure LeerM(Var Museos:Archivo_Museos; Var Mus:Museo; Pos:Integer);
Begin
Seek(Museos,Pos);
Read(Museos,Mus);
End;

Procedure ModificarM(Var Museos:Archivo_Museos; Var Mus:Museo; Pos:Integer);
Begin
Seek(Museos,Pos);
Write(Museos,Mus);
End;

Procedure GuardarM (Var Museos:Archivo_Museos; Var Mus:Museo);
Begin
Seek(Museos,Filesize(Museos));
Write(Museos,Mus);
End;

Procedure CerrarM (Var Museos:Archivo_Museos);
Begin
Close(Museos);
End;

Procedure burbujaM(Var Museos:Archivo_Museos);
//BURBUJA MEJORADO PARA ARCHIVOS

Var 
    L, i, j :   LongInt;
    RegA, RegB, RegAux :   Museo;
begin
AbrirM(Museos);
L := FileSize(Museos);
	if (L>1) then;
	begin
		for j := 1 to (L-1) do
		begin //mientras no este ordenado
			for i := 0 to (L-j-1) do
			begin //Ciclo de i y el adyascente
			 LeerM (Museos, RegA, i); //Obtengo los parametros por los cuales quiero ordenar
			 LeerM (Museos, RegB, i+1);
				if (RegB.Nombre < RegA.Nombre) then
				begin
				 RegAux := RegB;
				 ModificarM (Museos, RegAux, i);
				 ModificarM (Museos, RegA, i+1);
				end;
			end;
		end;
	end;
CerrarM(Museos);
end;

{
Procedure BurbujaMejorado (Var L: ListaEmpleados; N: Integer);
Var
	I,J: Integer;
	Aux : Empleado
	Ordenado : Boolean;

Begin
I : = 1;
Repeat
Ordenado : = True;
	For J : = 1 To N – 1 Do
		If L [ J ]. Nombre > L [ J + 1 ]. Nombre Then
		Begin
			Aux : = Lista [ J ];
			Lista [ J ] : = Lista [ J + 1 ];
			Lista [ J + 1 ] : = Aux ;
			Ordenado : = False
		End;
	 inc(I)
Until Ordenado Or ( I > N – 1 )
End;}


Procedure Buscar_Museo_Codigo(Var Museos:Archivo_Museos;Var pos:int64; codigo_buscado:int64; Var Mus:Museo);

Var 
    posicion :   int64;

Begin
    AbrirM(Museos);
    // Apertura del Archivo de Museos
    posicion := 0;
    pos := -1;
    While (Not eof (Museos)) And (pos=-1) Do
        Begin
            LeerM (Museos, Mus, posicion);
            If (Mus.Codigo = codigo_buscado) Then
                Begin
                    pos := posicion;
                End;
            inc(posicion);
        End;
    CerrarM(Museos);
    // Cierre del Archivo de Museos
End;


Procedure Buscar_Museo_Nombre(Var Museos:Archivo_Museos; Var pos:int64; Nombre:String; Var Mus:Museo);

Var 
    posicion :   int64;

Begin
    posicion := 0;
    pos := -1;
    AbrirM(Museos);
    // Apertura del Archivo de Museos
    While (Not eof (Museos)) And (pos = -1) Do
        Begin
            LeerM(Museos, Mus, posicion);
            If (Mus.Nombre = Nombre)Then
                Begin
                    pos := posicion;
                End;
            inc(posicion);
        End;
    CerrarM(Museos);
    // Cierre del Archivo de Museos
End;

{METODOS PARA PRUEBAS
* }

Procedure Barrido_Mus(Var Museos:Archivo_Museos);

Var 
    Punt, Lim : int64;
	y:integer;
Begin
	burbujaM(Museos);
	y:=2;
    AbrirM(Museos);
    Lim := FileSize(Museos);
    Punt := 0;
		While (Not eof) And (punt <> Lim) Do
        Begin
            LeerM(Museos, Mus, Punt);
				If (Mus.Activo = True) Then
                Begin
					Gotoxy(50,y);
                    Writeln(Mus.Nombre);
                    inc(y);
                End;
            Punt := (Punt+1);
        End;
    CerrarM(Museos);
readkey;
End;


Begin
End.
