with import <nixos-21.11> { };

mkShell {

  name = "env";
  buildInputs = [
    figlet clang lld llvm binaryen nodejs cmake pkgsi686Linux.glibc
  ];

  shellHook = ''
    figlet ":clang:"
  '';

}