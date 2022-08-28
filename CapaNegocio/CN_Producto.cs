﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Producto
    {
        private CD_Producto objCapaDatos = new CD_Producto();

        public List<Producto> Listar()
        {
            return objCapaDatos.Listar();
        }

        public int Registrar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;
            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El Nombre del Producto no puede ser vacío";
            }
            else if (string.IsNullOrEmpty(obj.Descripcion) || string.IsNullOrWhiteSpace(obj.Descripcion))
            {
                Mensaje = "La descripción del Producto no puede ser vacío";
            }
            else if (obj.oMarca.IdMarca == 0)
            {
                Mensaje = "Debe seleccionar una marca";
            }
            else if (obj.oCategoria.IdCategoria == 0)
            {
                Mensaje = "Debe seleccionar una categoria";
            }
            else if (obj.Precio == 0)
            {
                Mensaje = "Debe ingresar el precio del producto";
            }
            else if (obj.Stock == 0)
            {
                Mensaje = "Debe ingresar el stock del producto";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDatos.Registrar(obj, out Mensaje);
            }
            else
            {
                return 0;
            }
        }

        public bool Editar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;

            Mensaje = string.Empty;
            if (string.IsNullOrEmpty(obj.Nombre) || string.IsNullOrWhiteSpace(obj.Nombre))
            {
                Mensaje = "El Nombre del Producto no puede ser vacío";
            }
            else if (string.IsNullOrEmpty(obj.Descripcion) || string.IsNullOrWhiteSpace(obj.Descripcion))
            {
                Mensaje = "La descripción del Producto no puede ser vacío";
            }
            else if (obj.oMarca.IdMarca == 0)
            {
                Mensaje = "Debe seleccionar una marca";
            }
            else if (obj.oCategoria.IdCategoria == 0)
            {
                Mensaje = "Debe seleccionar una categoria";
            }
            else if (obj.Precio == 0)
            {
                Mensaje = "Debe ingresar el precio del producto";
            }
            else if (obj.Stock == 0)
            {
                Mensaje = "Debe ingresar el stock del producto";
            }
            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDatos.Editar(obj, out Mensaje);
            }
            else
            {
                return false;
            }
        }

        public bool GuardarDatosImagen(Producto obj, out string Mensaje)
        {
            return objCapaDatos.GuardarDatosImagen(obj, out Mensaje);
        }

        public bool Eliminar(int id, out string Mensaje)
        {
            return objCapaDatos.Eliminar(id, out Mensaje);
        }
    }
}
