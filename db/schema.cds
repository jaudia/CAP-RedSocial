using {
    cuid,
    managed
} from '@sap/cds/common';

namespace redSocial;

type tv_pais : String(3);

type tv_genero : String enum {
    Femenino;
    Masculino;
    Otro
};

type tv_categoria : String enum {
    Carbon;
    Bronce;
    Plata;
    Oro;
    Diamante;
};

type tv_tipo : String enum {
    Texto;
    Foto;
    Video;
    url;
};

type ts_email {
    usuario : String;
    dominio : String;
    full    : String;
}

aspect Usuario_humano {
    nombre                : String;
    apellido              : String;
    @mandatory paisOrigen : String(3);
    genero                : tv_genero;
    telefono              : String;
    fechaNacimiento       : Date;
    correoElectronico     : ts_email;
}

entity Usuarios : cuid, Usuario_humano {
    @mandatory username : String;
    @mandatory password : String;
    amigos              : Integer;
    estatus             : Boolean;
    mensajes            : Composition of many Mensajes
                              on mensajes.parent = $self;
    perfil              : Association to one Perfiles;
}

entity Mensajes {
    key parent          : Association to one Usuarios;
        nombreRemitente : String;
        contenido       : String;
        leido           : Boolean;
        multimedia      : array of {
            tipo        : String;
            tamanio     : Integer(7, 3);
        };
}


entity Perfiles : cuid {
    titulo          : String;
    descripcion     : String;
    visualizaciones : Integer;
    categoria       : tv_categoria;
    usuario         : Association to one Usuarios;
};


entity Publicaciones : cuid, managed {
    titulo             : String default 'titulo';
    cantidadCompartido : Integer;
    tipo               : tv_tipo;
    vistaPrevia        : Boolean;
    likes              : Integer;
    usuario            : Association to one Usuarios;
    perfil             : Association to one Perfiles;
}

entity Comentarios : cuid, managed {
    contenido   : String;
    usuario     : Association to one Usuarios;
    publicacion : Association to one Publicaciones;
}
