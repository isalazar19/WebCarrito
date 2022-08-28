create proc sp_RegistrarUsuario(
	@Nombres varchar(100),
	@Apellidos varchar(100),
	@Correo varchar(100),
	@Clave varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado=0
	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo)
	begin
		insert into USUARIO(Nombres,Apellidos,Correo,Clave,Activo)
		values (@Nombres,@Apellidos,@Correo,@Clave,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	set @Mensaje = 'El correo de usuario ya existe'
end

create proc sp_EditarUsuario(
	@IdUsuario int,
	@Nombres varchar(100),
	@Apellidos varchar(100),
	@Correo varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (
		SELECT * FROM USUARIO 
		WHERE Correo = @Correo AND IdUsuario != @IdUsuario 
	)
	begin
		UPDATE TOP(1) USUARIO SET
		Nombres = @Nombres,
		Apellidos = @Apellidos,
		Correo = @Correo,
		Activo =  @Activo
		WHERE IdUsuario = @IdUsuario

		SET @Resultado = 1
	end
	else
	SET @Mensaje = 'El correo del usuario ya existe'

end

create procedure sp_RegistrarCategoria(
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado=0
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	begin
		insert into CATEGORIA(Descripcion,Activo)
		values (@Descripcion,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	set @Mensaje = 'La categoria ya existe'
	
end

create procedure sp_EditarCategoria(
	@IdCategoria int,
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (
		SELECT * FROM CATEGORIA 
		WHERE Descripcion = @Descripcion AND IdCategoria != @IdCategoria 
	)
	begin
		UPDATE TOP(1) CATEGORIA 
		SET Descripcion = @Descripcion,
			Activo =  @Activo
		WHERE IdCategoria = @IdCategoria

		SET @Resultado = 1
	end
	else
	SET @Mensaje = 'La categoria ya existe'


end

create procedure sp_EliminarCategoria(
	@IdCategoria int,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (
		SELECT * FROM PRODUCTO p
		INNER JOIN CATEGORIA c ON c.IdCategoria=p.IdCategoria
		WHERE p.IdCategoria = @IdCategoria 
	)
	begin
		DELETE TOP(1) FROM CATEGORIA 
		WHERE IdCategoria = @IdCategoria

		SET @Resultado = 1
	end
	else
	SET @Mensaje = 'La categoria se encuentra relacionada a un producto'
end

create procedure sp_RegistrarMarca(
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado=0
	IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
	begin
		insert into MARCA(Descripcion,Activo)
		values (@Descripcion,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	set @Mensaje = 'La marca ya existe'
	
end

create procedure sp_EditarMarca(
	@IdMarca int,
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (
		SELECT * FROM MARCA 
		WHERE Descripcion = @Descripcion AND IdMarca != @IdMarca 
	)
	begin
		UPDATE TOP(1) MARCA 
		SET Descripcion = @Descripcion,
			Activo =  @Activo
		WHERE IdMarca = @IdMarca

		SET @Resultado = 1
	end
	else
	SET @Mensaje = 'La marca ya existe'


end

create procedure sp_EliminarMarca(
	@IdMarca int,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (
		SELECT * FROM PRODUCTO p
		INNER JOIN MARCA c ON c.IdMarca=p.IdMarca
		WHERE p.IdMarca = @IdMarca 
	)
	begin
		DELETE TOP(1) FROM MARCA 
		WHERE IdMarca = @IdMarca

		SET @Resultado = 1
	end
	else
	SET @Mensaje = 'La marca se encuentra relacionada a un producto'
end


create procedure sp_RegistrarProducto(
	@Nombre varchar(100),
	@Descripcion varchar(100),
	@IdMarca varchar(100),
	@IdCategoria varchar(100),
	@Precio decimal(10,2),
	@Stock int,
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as 
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre)
	begin
		insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,Activo)
		values
		(@Nombre,@Descripcion,@IdMarca,@IdCategoria,@Precio,@Stock,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	end
	else
	 set @Mensaje = 'El producto ya existe'
end

create procedure sp_EditarProducto(
	@IdProducto int,
	@Nombre varchar(100),
	@Descripcion varchar(100),
	@IdMarca varchar(100),
	@IdCategoria varchar(100),
	@Precio decimal(10,2),
	@Stock int,
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (
		SELECT * FROM PRODUCTO
		WHERE Nombre = @Nombre and IdProducto != @IdProducto
	)
	begin
		UPDATE PRODUCTO
		SET
			Nombre = @Nombre,
			Descripcion = @Descripcion,
			IdMarca = @IdMarca,
			IdCategoria = @IdCategoria,
			Precio = @Precio,
			Stock = @Stock,
			Activo = @Activo
		WHERE IdProducto = @IdProducto

		SET @Resultado = 1
	end
	else
	 SET @Mensaje = 'El producto ya existe'
end


create procedure sp_EliminarProducto(
	@IdProducto int,
	@Mensaje varchar(500) output,
	@Resultado bit output
)
as
begin
	SET @Resultado=0
	IF NOT EXISTS (SELECT * FROM DETALLE_VENTA dv
		INNER JOIN PRODUCTO p ON p.IdProducto=dv.IdProducto
		WHERE p.IdProducto=@IdProducto
	)
	begin
		DELETE TOP(1) FROM PRODUCTO WHERE IdProducto=@IdProducto
	end
	else
	 set @Mensaje='El producto se encuentra relacionado a una venta'
end

create procedure sp_ListarProductos

as
begin
	select p.IdProducto, p.Nombre, p.Descripcion,
	m.IdMarca, m.Descripcion as DesMarca,
	c.IdCategoria,c.Descripcion as DesCategoria,
	p.Precio, p.Stock, p.RutaImagen, p.NombreImagen, p.Activo
	from PRODUCTO p
	inner join MARCA m on m.IdMarca=p.IdMarca
	inner join CATEGORIA c on c.IdCategoria=p.IdCategoria
end