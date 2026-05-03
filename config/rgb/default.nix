{ pkgs, pkgsUnstable, ...}:


{
	
	services.hardware.openrgb = {
		enable = true;
		package = pkgsUnstable.openrgb-with-all-plugins;
		motherboard = "amd";
	};
	boot.kernelParams = [ "acpi_enforce_resources=lax" ];
	boot.kernelModules = [ "i2c-dev" "i2c-piix4" "i2c-nct6775"];
	services.udev.packages = [ pkgsUnstable.openrgb ];
	#hardware.i2c.enable = true;






}
