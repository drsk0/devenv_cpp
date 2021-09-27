{
  description = "C++ development environment";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; allowBroken = true; };
        # overlays = [ self.overlay ];
      };
    in
    {

      devShell.${system} = pkgs.mkShell.override ({ stdenv = pkgs.llvmPackages.stdenv; }) rec {
        buildInputs = [
          pkgs.clang
          pkgs.llvmPackages.libclang
          pkgs.cmake
          pkgs.ninja
          pkgs.lldb
        ];
        CPATH = pkgs.lib.makeSearchPathOutput "dev" "include" buildInputs;
        shellHook = ''
          export CPATH=${CPATH}
          export C_INCLUDE_PATH=${CPATH}
        '';
      };
    };
}
