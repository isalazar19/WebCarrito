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