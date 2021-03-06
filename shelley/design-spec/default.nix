{ pkgs ? (import  ../../nix/default.nix {}).pkgs
}:

with pkgs;

stdenv.mkDerivation {
  name = "docsEnv";
  buildInputs = [ (texlive.combine {
                    inherit (texlive)
                      scheme-small

                      # fonts
                      cm-super

                      # libraries
                      stmaryrd lm-math amsmath
                      extarrows cleveref
                      titlesec

                      # font libraries `mathpazo` seems to depend on palatino, but it isn't pulled.
                      mathpazo palatino microtype

                      # libraries for marginal notes
                      xargs todonotes

                      # drawing
                      pgf

                      # build tools
                      latexmk

                      # Referencing
                      zref
                      ;
                  })
                  gitMinimal
                ];
  src = ./.;
  buildPhase = "make";

  meta = with lib; {
    description = "Delegation Design Specification";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}
