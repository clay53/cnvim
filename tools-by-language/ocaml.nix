{ pkgs, ... }:
{
  plugins.lsp.servers.ocamllsp = {
    enable = true;
    package = pkgs.ocamlPackages.ocaml-lsp;
    packageFallback = true;
  };
}
