use DBCARRITO

select * from USUARIO

insert into USUARIO(Nombres,Apellidos,Correo,Clave) 
values('test nombre','test apellido', 'test@example.com','ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae')

select * from CATEGORIA

insert into CATEGORIA(Descripcion) values
('Tecnologia'),
('Muebles'),
('Dormitorio'),
('Deportes')

select * from MARCA

insert into MARCA(Descripcion) values
('SONY'),
('HP'),
('LG'),
('HYUNDAI'),
('CANNON')


select * from DEPARTAMENTO

insert into DEPARTAMENTO(IdDepartamento,Descripcion) values
('01','I REGION'),
('02','II REGION'),
('03','III REGION')

select * from PROVINCIA

insert into PROVINCIA(IdProvincia,Descripcion,IdDepartamento) values
('0101','Comuna 1','01'),
('0102','Comuna 2','01'),
('0201','Comuna 1','02'),
('0202','Comuna 2','02'),
('0301','Comuna 1','03'),
('0302','Comuna 2','03')

select * from DISTRITO

insert into DISTRITO(IdDistrito,Descripcion,IdProvincia,IdDepartamento) values
('010101','Localidad 1','0101','01'),
('010102','Localidad 2','0101','01'),
('010201','Localidad 1','0101','01'),
('010202','Localidad 2','0101','01'),
('020101','Localidad 1','0201','02'),
('020102','Localidad 2','0201','02'),
('020201','Localidad 1','0202','02'),
('020202','Localidad 2','0202','02'),
('030101','Localidad 1','0301','03'),
('030102','Localidad 2','0301','03'),
('030201','Localidad 1','0302','03'),
('030202','Localidad 2','0302','03')



