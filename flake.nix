{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default =
        let
          rustPackages = with pkgs; [
            rustc

            cargo # package manager and build system

            rust-analyzer # language server
            rustfmt # formatter
            clippy # linter

            bacon # linter and test runner
            cargo-nextest # test runner used by bacon

            evcxr # REPL
          ];
          sysTools = with pkgs; [
            go-task
            gh
          ];
        in
        pkgs.mkShell {
          buildInputs = rustPackages ++ sysTools;
        };
    };
}