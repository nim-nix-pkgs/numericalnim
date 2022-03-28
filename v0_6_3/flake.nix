{
  description = ''A collection of numerical methods written in Nim. Current features: integration, ode, optimization.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-numericalnim-v0_6_3.flake = false;
  inputs.src-numericalnim-v0_6_3.ref   = "refs/tags/v0.6.3";
  inputs.src-numericalnim-v0_6_3.owner = "SciNim";
  inputs.src-numericalnim-v0_6_3.repo  = "numericalnim";
  inputs.src-numericalnim-v0_6_3.type  = "github";
  
  inputs."arraymancer".owner = "nim-nix-pkgs";
  inputs."arraymancer".ref   = "master";
  inputs."arraymancer".repo  = "arraymancer";
  inputs."arraymancer".dir   = "v0_7_11";
  inputs."arraymancer".type  = "github";
  inputs."arraymancer".inputs.nixpkgs.follows = "nixpkgs";
  inputs."arraymancer".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/hugogranstrom/cdt".owner = "nim-nix-pkgs";
  inputs."github.com/hugogranstrom/cdt".ref   = "master";
  inputs."github.com/hugogranstrom/cdt".repo  = "github.com/hugogranstrom/cdt";
  inputs."github.com/hugogranstrom/cdt".dir   = "";
  inputs."github.com/hugogranstrom/cdt".type  = "github";
  inputs."github.com/hugogranstrom/cdt".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/hugogranstrom/cdt".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-numericalnim-v0_6_3"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-numericalnim-v0_6_3";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}