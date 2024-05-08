using System.ComponentModel.DataAnnotations.Schema;

namespace MvcTiendaPrueba.Models
{
    public class DetallePedidoView
    {
        public int IdDetallePedido { get; set; }

        public int IdPedido { get; set; }

        public int IdProducto { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnitario { get; set; }

        public string NombreProducto { get; set; }

        public decimal TotalDetalle { get; set; }

        public decimal TotalPedido { get; set; }
        public int IdUsuario { get; set; }

    }
}
