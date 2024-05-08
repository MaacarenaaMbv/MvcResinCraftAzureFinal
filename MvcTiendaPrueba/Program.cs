using Azure.Security.KeyVault.Secrets;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Azure;
using MvcTiendaPrueba.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddAzureClients(factory =>
{
    factory.AddSecretClient
    (builder.Configuration.GetSection("KeyVault"));
});

builder.Services.AddSession(options => {
    options.IdleTimeout = TimeSpan.FromMinutes(30);
});


builder.Services.AddTransient<ServiceCacheRedis>();
SecretClient secretredis =

builder.Services.BuildServiceProvider().GetService<SecretClient>();

KeyVaultSecret secretClientRedis = await secretredis.GetSecretAsync("secretocacheredis");

string cacheRedisKeys = secretClientRedis.Value;



builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = cacheRedisKeys;
});

/****/
builder.Services.AddDistributedMemoryCache();
/****/


builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
}).AddCookie();
builder.Services.AddControllersWithViews(options => options.EnableEndpointRouting = false);
builder.Services.AddHttpContextAccessor();


builder.Services.AddTransient<ServiceApiTienda>();
var app = builder.Build();


// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();
app.UseSession();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Tienda}/{action=Index}/{id?}");

app.Run();
