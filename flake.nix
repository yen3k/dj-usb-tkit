{
  description = "dj-usb-kit development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(import rust-overlay)];
    };
    rust = pkgs.rust-bin.stable.latest.default;
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs_24
        # Rust
        rust
        rust-analyzer
        pkg-config
      ];
        buildInputs = with pkgs; [
          dbus
          webkitgtk_4_1
          alsa-lib
        ];
    };
  };
}
