using StackExchange.Redis;

namespace MvcTiendaPrueba.Helpers
{
    public class HelperCacheMultiplexer
    {
        private static Lazy<ConnectionMultiplexer>
            CreateConnection = new Lazy<ConnectionMultiplexer>
            (() =>
            {
                string cacheRedisKeys =
                "cacheredisresincraft.redis.cache.windows.net:6380,password=dxZNOanohI5cFjZwqetW3I4coFaNGpdptAzCaPPjNjI=,ssl=True,abortConnect=False";
                return ConnectionMultiplexer.Connect(cacheRedisKeys);
            });

        public static ConnectionMultiplexer Connection
        {
            get
            {
                return CreateConnection.Value;
            }
        }

    }
}
