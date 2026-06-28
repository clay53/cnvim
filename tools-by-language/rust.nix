{ ... }:
{
  plugins.lsp.servers.rust_analyzer = {
    enable = true;
    packageFallback = true;

    installCargo = false;
    installRustc = false;
  };
}
