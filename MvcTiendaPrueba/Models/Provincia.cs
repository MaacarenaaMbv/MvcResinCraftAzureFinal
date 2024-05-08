using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcTiendaPrueba.Models
{
    public class Provincia
    {
        public int IdProvincia { get; set; }

        public string Nombre { get; set; }
    }
}
