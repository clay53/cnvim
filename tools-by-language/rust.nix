{ ... }:
{
  plugins.lsp.servers.rust_analyzer = {
    enable = true;
    packageFallback = true;

    installCargo = false;
    installRustc = false;

    settings = {
      check.command = "clippy";
    };
  };
}
