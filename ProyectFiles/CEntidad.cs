using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace LibClases
{
    public abstract class CEntidad
    {
        // ATRIBUTOS --------------------------------------------------
        private CConexion aConexion;
        private string aNombreTabla;
        private int aNroClavesPrimarias;
        string[] aNombres = null; // Nombres de los campos de la tabla
        string[] aValores = null; // Valores de los campos de la tabla
        private bool aNuevo;
        // CONSTRUCTORES ----------------------------------------------
        public CEntidad(string pNombreTabla, int pNroClavesPrimarias)
        {
            aNuevo = true;
            aNombreTabla = pNombreTabla;
            aNroClavesPrimarias = pNroClavesPrimarias;
            aConexion = new CConexion();
            aNombres = NombresAtributos();
            aValores = null;
        }
        // PROPIEDADES-------------------------------------------------
        public bool Nuevo
        {
            get { return aNuevo; }
            set { aNuevo = value; }
        }

        // METODOS DE SOPORTE DE LA BD --------------------------------
        // Metodo abstracto encargado de establecer los nombres de los campos
        // (atributos) de la tabla. Se deben implementar necesariamente
        // en los herederos como arreglo de cadenas.
        // Estos atributos deben coincidircon los existentes en la BD.
        public abstract string[] NombresAtributos();

        // METODOS PARA EL MANTENIMIENTO DE LA TABLA
        // Insercion de nuevos registros
        public virtual void Insertar(params string[] pAtributos) // PARAMS: Numero de parametros variable
        {   // Permite insertar informacion de un registro en la tabla
            // Recuperar los valores de los atributos
            aValores = pAtributos;
            // Formar cadena de insercion
            string CadenaInsertar = "insert into " + aNombreTabla + " values ('";
            for (int k = 0; k < aValores.Length; k++)
            {   // Incluir los atributos en la consulta
                CadenaInsertar += aValores[k];
                if (k == aValores.Length - 1)
                {   // Concatenamos el ultimo atributo
                    CadenaInsertar += "')";
                }
                else
                {   // Dejar la consulta lista para el siguiente atributo
                    CadenaInsertar += "', '";
                }
            }
            // Ejecutar la consulta para insertar el registro
            aConexion.EjecutarComando(CadenaInsertar);
            aNuevo = false;
        }
        // Actualizacion de registros
        public void Actualizar(params string[] pAtributos)
        {   // Permite actualizar la informacion de un registro de la tabla
            // Recuperar los nombres y valores de los atributos de la tabla.
            aValores = pAtributos;
            aNombres = NombresAtributos();
            // Formar cadena de actualizacion
            // Se asume que la clave primaria solo es el primer elemento de la lista
            string CadenaActualizar = "update " + aNombreTabla + " set ";
            for (int k = aNroClavesPrimarias; k < aValores.Length; k++)
            {   // Incluir los atributos de la consulta
                CadenaActualizar += aNombres[k] + "= '" + aValores[k];
                if (k == aValores.Length - 1)
                {   // Cuando se concatena el ultimo atributo
                    CadenaActualizar += "'";
                }
                else
                {   // Dejar la consulta lista para el siguiente atributo
                    CadenaActualizar += "', ";
                }
            }
            // Agregar la clausula where a la consulta
            CadenaActualizar += " where ";
            for (int l = 0; l < aNroClavesPrimarias; l++)
            {
                CadenaActualizar += aNombres[l] + "= '" + aValores[l];
                if (l == aNroClavesPrimarias - 1)
                {   // Cuando se concatena el ultimo atributo
                    CadenaActualizar += "'";
                }
                else
                {   // Dejar la consulta lista para el siguiente atributo
                    CadenaActualizar += "' and ";
                }
            }
            // Ejecutar la consulta para actualizar el registro
            aConexion.EjecutarComando(CadenaActualizar);
        }
        // Eliminacion de un registro
        public void Eliminar(params string[] Atributos)
        {   // Permite eliminar un registro
            // Recuperar los nombres y valores de los atributos de la tabla.
            aNombres = NombresAtributos();
            aValores = Atributos;
            // Formar cadena de eliminacion
            string CadenaEliminar = "delete from " + aNombreTabla + " where ";
            for (int l = 0; l < aNroClavesPrimarias; l++)
            {
                CadenaEliminar += aNombres[l] + "= '" + aValores[l];
                if (l == aNroClavesPrimarias - 1)
                {   // Cuando se concatena el ultimo atributo
                    CadenaEliminar += "'";
                }
                else
                {   // Dejar la consulta lista para el siguiente atributo
                    CadenaEliminar += "' and ";
                }
            }
            // Ejecutar la consulta para eliminar el registro
            aConexion.EjecutarComando(CadenaEliminar);
        }
        public bool ExisteClavePrimaria(params string[] Atributos)
        {   // Verifica si un registro especifico existe
            // Recuperar los nombres y valores de los atributos de la tabla.
            aNombres = NombresAtributos();
            aValores = Atributos;
            // Formar la consulta
            string CadenaConsulta = "select * from " + aNombreTabla + " where ";
            for (int l = 0; l < aNroClavesPrimarias; l++)
            {
                CadenaConsulta += aNombres[l] + "= '" + aValores[l];
                if (l == aNroClavesPrimarias - 1)
                {   // Cuando se concatena el ultimo atributo
                    CadenaConsulta += "'";
                }
                else
                {   // Dejar la consulta lista para el siguiente atributo
                    CadenaConsulta += "' and ";
                }
            }
            // Ejecutar la consulta
            aConexion.EjecutarSelect(CadenaConsulta);
            // Si existen registros en la tabla 0 del dataset, la clave primaria existe
            return (aConexion.Datos.Tables[0].Rows.Count > 0);
        }

        public DataTable Registro(params string[] Atributos)
        {   // Recupera la informacion de un registro
            // Recuperar los nombres y valores de los atributos de la tabla.
            aNombres = NombresAtributos();
            aValores = Atributos;
            // Formar la consulta
            string CadenaConsulta = "select * from " + aNombreTabla + " where ";
            for (int l = 0; l < aNroClavesPrimarias; l++)
            {
                CadenaConsulta += aNombres[l] + "= '" + aValores[l];
                if (l == aNroClavesPrimarias - 1)
                {   // Cuando se concatena el ultimo atributo
                    CadenaConsulta += "'";
                }
                else
                {   // Dejar la consulta lista para el siguiente atributo
                    CadenaConsulta += "' and ";
                }
            }
            // Ejecutar la consulta para eliminar el registro
            aConexion.EjecutarComando(CadenaConsulta);
            // Ejecutar la consulta y devolver el resultado
            aConexion.EjecutarSelect(CadenaConsulta);
            return aConexion.Datos.Tables[0];
        }

        public string ValorAtributo(string pNombreCampo)
        {   // Recupera el valor del atributo del dataset
            return aConexion.Datos.Tables[0].Rows[0][pNombreCampo].ToString();
        }

        public DataTable ListaGeneral()
        {   // Retorna una tabla con la lista completa de libros
            string Consulta = "select * from " + aNombreTabla;
            aConexion.EjecutarSelect(Consulta);
            return aConexion.Datos.Tables[0];
        }        
    }
}