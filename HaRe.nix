let
  buildDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (build dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  sysDepError = pkg:
    builtins.throw ''
      The Nixpkgs package set does not contain the package: ${pkg} (system dependency).
      
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      '';
  pkgConfDepError = pkg:
    builtins.throw ''
      The pkg-conf packages does not contain the package: ${pkg} (pkg-conf dependency).
      
      You may need to augment the pkg-conf package mapping in haskell.nix so that it can be found.
      '';
  exeDepError = pkg:
    builtins.throw ''
      The local executable components do not include the component: ${pkg} (executable dependency).
      '';
  legacyExeDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (executable dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  buildToolDepError = pkg:
    builtins.throw ''
      Neither the Haskell package set or the Nixpkgs package set contain the package: ${pkg} (build tool dependency).
      
      If this is a system dependency:
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      
      If this is a Haskell dependency:
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
in { system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "2.0";
      identifier = { name = "HaRe"; version = "0.8.4.1"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "Alan Zimmerman (alan.zimm@gmail.com)";
      author = "Chris Brown, Huiqing Li, Simon Thompson,\nAlan Zimmerman, Stephen Adams";
      homepage = "https://github.com/RefactoringTools/HaRe/wiki";
      url = "";
      synopsis = "the Haskell Refactorer.";
      description = "A Haskell 2010 refactoring tool. HaRe supports the full\nHaskell 2010 standard, through making use of the GHC API.\n\nVersion 0.7.2.8 supports up to GHC 7.6.3.\n\nThere is no support for GHC 7.8.x. There will never be support for GHC 7.8.x\n\nFrom version 0.8.0.0, GHC 7.10.2 is supported.\n\nFrom version 0.8.3.0, GHC 8.0.1 is supported.\n\nFrom version 0.8.4.0, GHC 8.0.2 is supported.\n\nIt is tested against GHC 7.10.3, GHC 8.0.1 and GHC 8.0.2 (via travis-ci.org)\n\nIt currently only has emacs integration built in, community input\nwelcome for others.\n\nHaRe attempts to operate in a safe way, by first writing new files with\nproposed changes, and only swapping these with the originals when the change\nis accepted. In the process the original file is renamed to have the current\ndate/time as a suffix. Thus it should be possible to (manually) undo changes.\n\nEven so, it is strongly advised to back up any source files before\nrefactoring, as we can make no promises as to the reliability of this tool.\nUse at your own risk.\n\nAt the moment parsing of any file with FFI exports will fail.\n\nSee Language.Haskell.Refact.HaRe for the current list of refactorings supported\n";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."Strafunski-StrategyLib" or (buildDepError "Strafunski-StrategyLib"))
          (hsPkgs."cabal-helper" or (buildDepError "cabal-helper"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."directory" or (buildDepError "directory"))
          (hsPkgs."filepath" or (buildDepError "filepath"))
          (hsPkgs."ghc" or (buildDepError "ghc"))
          (hsPkgs."ghc-exactprint" or (buildDepError "ghc-exactprint"))
          (hsPkgs."hie-plugin-api" or (buildDepError "hie-plugin-api"))
          (hsPkgs."hslogger" or (buildDepError "hslogger"))
          (hsPkgs."monad-control" or (buildDepError "monad-control"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."syb" or (buildDepError "syb"))
          (hsPkgs."syz" or (buildDepError "syz"))
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") (hsPkgs."ghc-syb-utils" or (buildDepError "ghc-syb-utils"));
        buildable = if compiler.isGhc && (compiler.version).lt "7.10.2"
          then false
          else true;
        };
      exes = {
        "ghc-hare" = {
          depends = [
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."Cabal" or (buildDepError "Cabal"))
            (hsPkgs."HaRe" or (buildDepError "HaRe"))
            (hsPkgs."gitrev" or (buildDepError "gitrev"))
            (hsPkgs."hie-plugin-api" or (buildDepError "hie-plugin-api"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."optparse-applicative" or (buildDepError "optparse-applicative"))
            (hsPkgs."optparse-simple" or (buildDepError "optparse-simple"))
            ];
          buildable = if compiler.isGhc && (compiler.version).lt "7.10.2"
            then false
            else true;
          };
        };
      tests = {
        "spec" = {
          depends = [
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."Diff" or (buildDepError "Diff"))
            (hsPkgs."HUnit" or (buildDepError "HUnit"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."foldl" or (buildDepError "foldl"))
            (hsPkgs."ghc" or (buildDepError "ghc"))
            (hsPkgs."ghc-exactprint" or (buildDepError "ghc-exactprint"))
            (hsPkgs."hie-plugin-api" or (buildDepError "hie-plugin-api"))
            (hsPkgs."hslogger" or (buildDepError "hslogger"))
            (hsPkgs."hspec" or (buildDepError "hspec"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."turtle" or (buildDepError "turtle"))
            (hsPkgs."process" or (buildDepError "process"))
            (hsPkgs."foldl" or (buildDepError "foldl"))
            (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
            (hsPkgs."base-prelude" or (buildDepError "base-prelude"))
            (hsPkgs."conversion-case-insensitive" or (buildDepError "conversion-case-insensitive"))
            (hsPkgs."conversion" or (buildDepError "conversion"))
            (hsPkgs."conversion-text" or (buildDepError "conversion-text"))
            (hsPkgs."parsec" or (buildDepError "parsec"))
            (hsPkgs."case-insensitive" or (buildDepError "case-insensitive"))
            (hsPkgs."cabal-helper" or (buildDepError "cabal-helper"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."monad-control" or (buildDepError "monad-control"))
            (hsPkgs."Strafunski-StrategyLib" or (buildDepError "Strafunski-StrategyLib"))
            (hsPkgs."syb" or (buildDepError "syb"))
            (hsPkgs."syz" or (buildDepError "syz"))
            (hsPkgs."dlist" or (buildDepError "dlist"))
            (hsPkgs."case-insensitive" or (buildDepError "case-insensitive"))
            ];
          buildable = if compiler.isGhc && (compiler.version).lt "7.10.2"
            then false
            else true;
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ./submodules/HaRe; }