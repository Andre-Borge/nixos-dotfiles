{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
	  home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, ... }: {
	    system = "x86_64-linux";
	    nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
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
      };
  };
}
