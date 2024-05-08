using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcTiendaPrueba.Models
{
    public class Subcategoria
    {
        public int IdSubcategoria { get; set; }

        public string Nombre { get; set; }

        public int IdCategoria { get; set; }

        public Categoria Categoria { get; set; }
    }
}
