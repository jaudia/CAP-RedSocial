using {redSocial as my} from '../db/schema';


service AdminService @(_requires : 'authenticated-user') {
    entity Usuarios                           as projection on my.Usuarios;
    entity Mensajes                           as projection on my.Mensajes;
    entity Perfiles                           as projection on my.Perfiles;
    entity Publicaciones                      as projection on my.Publicaciones;
    entity Comentarios                        as projection on my.Comentarios;

    entity verPerfilUsuarioPublicaciones      as
        select
            b.username,
            a.titulo,
            a.descripcion
        from Perfiles as a
        inner join Usuarios as b
            on b.ID = a.usuario.ID
        inner join Publicaciones as c
            on c.usuario.ID = b.ID;

    entity verUsuariosMasDoscientosAmigos     as
        select * from Usuarios
        where
            amigos > 200;

    entity verPublicacionesMasCienCompartidas as
        select * from Publicaciones
        where
            cantidadCompartido > 100;


// entity verProductosPorPrecio as
//     select
//         nombre,
//         precio.price as precio
//     from Productos
//     order by
//         precio;


}
