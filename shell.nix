with import <nixpkgs> { };

mkShell {

  name = "env";
  buildInputs = [
    figlet binaryen nodejs
  ];

  shellHook = ''
    figlet ":clang:"
  '';

}