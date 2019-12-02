using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace LibClases
{
    public class CConexion
    {
        //::::::::::::::::::::::::::::::: ATRIBUTOS :::::::::::::::::::::::::::::::
        private SqlConnection aConexion;
        private SqlDataAdapter aAdaptador;
        private DataSet aDatos;
        //::::::::::::::::::::::::::::::: METODOS ::::::::::::::::::::::::::::::::::
        //----------------------------- CONSTRUCTOR ---------------------------------
        public CConexion()
        {
            aDatos = new DataSet();
            aAdaptador = new SqlDataAdapter();
            //realizarla conexion
            string CadenaConexion = "Data Source = REKARENAN;" +
                                            " Initial Catalog=bdSysPoliclinico; Integrated Security=SSPI;";
            aConexion = new SqlConnection(CadenaConexion);
        }
        //------------------------------- propiedades -------------------------------
        public SqlConnection Conexion
        {
            get { return aConexion; }
        }
        public SqlDataAdapter Adaptador
        {
            get { return aAdaptador; }
        }
        //-------------------------------------------------------------------------------------
        public DataSet Datos
        {
            get { return aDatos; }
        }
        //---------------------------- SERVICIOS ----------------------------------------------
        //----- Metodos para ejecutar comandos sql server
        //----- Devuelve eñ resultado en la tabla 0 del dataset
        public virtual DataSet EjecutarSelect(string pConsulta)
        {
            //metodo para ejecutar consultas del tipo select
            aAdaptador.SelectCommand = new SqlCommand(pConsulta, aConexion);
            aDatos = new DataSet();
            aAdaptador.Fill(Datos);
            return aDatos;
        }

        //_-------------------------------------------------------------------------------
        // ----- METODO PARA EJECUTAR INSTRUCCIONES DML. NO SE RETORNA RESULTADO
        //_-------------------------------------------------------------------------------
        public virtual void EjecutarComando(string pComando)
        {
            //metodo para ejecutar consultas del tipo insert, update, delete
            SqlCommand oComando = new SqlCommand(pComando, aConexion);
            aConexion.Open();
            oComando.ExecuteNonQuery();
            aConexion.Close();
        }
    }
}
