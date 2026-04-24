{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

		freesmlauncher = {
			url = "github:FreesmTeam/FreesmLauncher";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
  };
  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, freesmlauncher,  ... }:
	let
	    system = "x86_64-linux";
			pkgs = import nixpkgs { inherit system; };
			pkgsUnstable = import nixpkgs-unstable { inherit system; };
	in
	{
	    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				inherit system;
	      modules = [ 
	    	  ./configuration.nix 
		      home-manager.nixosModules.home-manager
		      {
			        home-manager.useGlobalPkgs = true;
			        home-manager.useUserPackages = true;
			        home-manager.users.andre = import ./home.nix;
			        home-manager.backupFileExtension = "backup";
		      }
        ];
				specialArgs = { inherit pkgsUnstable freesmlauncher; };
      };
	};
}
