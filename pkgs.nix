{
  extras = hackage:
    {
      packages = {
        "ansi-terminal" = (((hackage.ansi-terminal)."0.8.2").revisions).default;
        "ansi-wl-pprint" = (((hackage.ansi-wl-pprint)."0.6.8.2").revisions).default;
        "brittany" = (((hackage.brittany)."0.12.1.0").revisions).default;
        "cabal-plan" = (((hackage.cabal-plan)."0.4.0.0").revisions).default;
        "constrained-dynamic" = (((hackage.constrained-dynamic)."0.1.0.0").revisions).default;
        "floskell" = (((hackage.floskell)."0.10.2").revisions).default;
        "ghc-lib-parser" = (((hackage.ghc-lib-parser)."8.8.1").revisions).default;
        "haddock-api" = (((hackage.haddock-api)."2.22.0").revisions).default;
        "haskell-lsp" = (((hackage.haskell-lsp)."0.18.0.0").revisions).default;
        "haskell-lsp-types" = (((hackage.haskell-lsp-types)."0.18.0.0").revisions).default;
        "hlint" = (((hackage.hlint)."2.2.4").revisions).default;
        "hsimport" = (((hackage.hsimport)."0.11.0").revisions).default;
        "hoogle" = (((hackage.hoogle)."5.0.17.11").revisions).default;
        "lsp-test" = (((hackage.lsp-test)."0.8.2.0").revisions).default;
        "syz" = (((hackage.syz)."0.2.0.0").revisions).default;
        "temporary" = (((hackage.temporary)."1.2.1.1").revisions).default;
        "monad-dijkstra" = (((hackage.monad-dijkstra)."0.1.1.2").revisions).r1;
        haskell-ide-engine = ./haskell-ide-engine.nix;
        hie-plugin-api = ./hie-plugin-api.nix;
        HaRe = ./HaRe.nix;
        cabal-helper = ./cabal-helper.nix;
        ghc-mod = ./ghc-mod.nix;
        ghc-mod-core = ./ghc-mod-core.nix;
        ghc-project-types = ./ghc-project-types.nix;
        };
      };
  resolver = "lts-14.16";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "haskell-ide-engine" = {
            flags = { "pedantic" = lib.mkOverride 900 true; };
            };
          "hie-plugin-api" = {
            flags = { "pedantic" = lib.mkOverride 900 true; };
            };
          };
        })
    { packages = {}; }
    ];
  }