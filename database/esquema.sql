create table if not exists zonas (
  id          bigint generated always as identity primary key,
  nombre      varchar(100) not null,
  descripcion varchar(255)
);

create table if not exists categorias (
  id     bigint generated always as identity primary key,
  nombre varchar(50) not null unique
);

create table if not exists usuarios (
  id         bigint generated always as identity primary key,
  nombre     varchar(100) not null,
  apellido   varchar(100) not null,
  email      varchar(150) not null unique,
  password   varchar(255) not null,
  rol        varchar(20) not null default 'vecino',
  id_zona    bigint references zonas(id),
  estado     boolean not null default true,
  fecha_alta timestamptz not null default now()
);

create table if not exists publicaciones (
  id           bigint generated always as identity primary key,
  titulo       varchar(150) not null,
  descripcion  text not null,
  id_usuario   bigint not null references usuarios(id),
  id_categoria bigint not null references categorias(id),
  id_zona      bigint not null references zonas(id),
  ubicacion    varchar(255),
  estado       boolean not null default true,
  fecha        timestamptz not null default now()
);

-- Datos de ejemplo

insert into zonas (nombre, descripcion) values
  ('Manzana 1', 'Sector norte del barrio'),
  ('Manzana 2', 'Sector sur del barrio');

insert into categorias (nombre) values
  ('Seguridad'),
  ('Servicios'),
  ('Eventos'),
  ('Ayuda mutua');

insert into usuarios (nombre, apellido, email, password, rol, id_zona) values
  ('Lautaro', 'Laborda', 'lautaro@barriowatch.com', 'demo1234', 'administrador', 1),
  ('Lucas', 'Nozikovsky', 'lucas@barriowatch.com', 'demo1234', 'moderador', 1),
  ('Juan', 'Rasjido', 'juan@barriowatch.com', 'demo1234', 'vecino', 2);